package request_handlers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bps.sw.pgw.service.IPaymentGateway;
import com.bps.sw.pgw.service.PaymentGatewayImplService;
import com.ibm.icu.util.StringTokenizer;

import model.Order;
import model.User;
import utility.Message;

/**
 * Servlet implementation class PayServlet
 */
@WebServlet("/PayServlet")
public class PayServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final long TerminalId = 3647854;
	private static final String UserName = "zaba229";
	private static final String Password = "70808723";
	private static final String LocalDate = "20100517";
	private static final String LocalTime = "140000";
	private static final long payerId = 0;
	private static final String CallBackURL = "http://shiraz-zseci.ir/pay";
	
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PayServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		IPaymentGateway service = new PaymentGatewayImplService().getPaymentGatewayImplPort();
		String responseMessage = "";
		String responseMessage2 = "";
		String command = request.getParameter("command");
		if(command != null) {
			// beginning a payment. We must send a payRequest to server and wait for 
			// its response. Any problems should be reported back to the payment.jsp file through
			// the message attribute in session.
			int price = 0;
			if(request.getParameter("price") != null) {
				try {
					price = Integer.parseInt(request.getParameter("price"));
				}catch(NumberFormatException e) {
					price = 0;
				}
			}
			String type = "class";
			int classId = 0;
			int examId = 0;
			if(request.getParameter("classId") != null) {
				type = "class";
				try {
					classId = Integer.parseInt(request.getParameter("classId"));
				}catch(NumberFormatException e) {
					classId = 0;
				}
			}
			
			if(request.getParameter("examId") != null) {
				type = "exam";
				try {
					examId = Integer.parseInt(request.getParameter("examId"));
				}catch(NumberFormatException e) {
					examId = 0;
				}
			}
			User user = User.getCurrentUser(request.getSession());
			// create new order and save it in the database
			Order newOrder = null;
			if("class".equals(type)) {
				newOrder = Order.addNewOrder(user.id, price, classId, "class");
			}else if("exam".equals(type)) {
				newOrder = Order.addNewOrder(user.id, price, examId, "exam");
			}
			System.out.println("New order created with id " + newOrder.id);
			
			if(price == 0) {
				exitSuccessfully(request, response);
				return;
			}

			try {
				responseMessage  = service.bpPayRequest(TerminalId, UserName, Password,
						newOrder.id, price, LocalDate, LocalTime, "", CallBackURL, payerId);
			} catch (Exception e) {
				exitFailed(request, response, "پرداخت در این زمان ممکن نیست.");
				return;
			}

			request.getSession().setAttribute("bank_response_message", responseMessage);
			
			StringTokenizer stringTokenizer = new StringTokenizer(responseMessage, ",");
			String[] results = new String[2];

			// push all the words to the stack one by one
			int i = 0;
			while (stringTokenizer.hasMoreTokens()) {
				results[i] = (String) stringTokenizer.nextElement();
				i++;
			}
			
			if (results[0].equals("0")) {
				// redirecting to payment.jsp to be sent to the bank page for payment.
				newOrder.refId = results[1];
				Order.updateOrder(newOrder);
				request.getSession().setAttribute("payment_ref_id", newOrder.refId);
				request.getSession().setAttribute("payment_new_order", newOrder);
				response.sendRedirect("./payment.jsp");
				return;				
			}else {
				exitFailed(request, response, "پرداخت در این زمان ممکن نیست.");
				return;
			}
		}
		
		
		/// check if it's returning from payment request
		if(request.getParameter("RefId") != null && request.getParameter("ResCode") != null &&
				request.getParameter("SaleOrderId") != null && request.getParameter("SaleReferenceId") != null) {
			// the only case where all 4 parameters are non-null and present is when the resCode is zero.
			Order newOrder = (Order)request.getSession().getAttribute("payment_new_order");
			request.getSession().removeAttribute("payment_new_order");
			if(! request.getParameter("RefId").equals(newOrder.refId)) {
				exitFailed(request, response, "پرداخت مورد تایید نیست.");
				return;
			}
			int saleOrderId = 0;
			long saleReferenceId = 0;
			int resCode = 0;
			try {
				resCode = Integer.parseInt(request.getParameter("ResCode"));
				saleOrderId = Integer.parseInt(request.getParameter("SaleOrderId"));
				saleReferenceId = Long.parseLong(request.getParameter("SaleReferenceId"));
			} catch (NumberFormatException e) {
				exitFailed(request, response, "پرداخت موفقیت آمیز نبود.");
				return;
			}
			if(saleOrderId != newOrder.id) {
				exitFailed(request, response, "پرداخت مورد تایید نیست.");
				response.sendRedirect("./payment.jsp");
				return;
			}
			if(resCode == 0) {
				// payment was successful. Verify and settle
				newOrder.saleRefId = saleReferenceId;
				Order.updateOrder(newOrder);
		        try {
		            responseMessage = service.bpVerifyRequest(TerminalId, UserName, Password,
		                    newOrder.id, saleOrderId, saleReferenceId);
		            request.getSession().setAttribute("bank_response_message2", responseMessage);
		            
		            if(! "0".equals(responseMessage)) {
			        	exitFailed(request, response, "پرداخت موفقیت آمیز نبود .");
						return;
		            }
		            
		            responseMessage2 = service.bpSettleRequest(TerminalId, UserName, Password,
		                    newOrder.id, saleOrderId, saleReferenceId);
		            request.getSession().setAttribute("bank_response_messag3", responseMessage2);
		        } catch (Exception e) {
		        	exitFailed(request, response, "پرداخت موفقیت آمیز نبود .");
					return;
		        }
		        
		        exitSuccessfully(request, response);
		        if("class".equals(newOrder.type)) {
		        	response.sendRedirect("./register?classId="+newOrder.resourceId);
		        }else if("exam".equals(newOrder.type)) {
		        	response.sendRedirect("./exams?command=register&examId="+newOrder.resourceId);
		        }
		        return;
			}else {
				// This should never happen
				exitFailed(request, response, "پرداخت موفقیت آمیز نبود.");
				return;
			}
		}
		
		
		response.getWriter().print("");
	}

	
	protected void exitSuccessfully(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		request.getSession().removeAttribute("payment_classId");
		request.getSession().removeAttribute("payment_examId");
		request.getSession().removeAttribute("payment_ref_id");
		request.getSession().removeAttribute("payment_new_order");
		request.getSession().removeAttribute("bank_response_message");
		request.getSession().removeAttribute("bank_response_message2");
		request.getSession().removeAttribute("bank_response_message3");
	}
	
	protected void exitFailed(HttpServletRequest request, HttpServletResponse response, String msg) 
			throws ServletException, IOException {
		Message message = new Message(msg, "red");
		request.getSession().setAttribute("message", message);
		response.sendRedirect("./payment.jsp");
		return;
	}
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
