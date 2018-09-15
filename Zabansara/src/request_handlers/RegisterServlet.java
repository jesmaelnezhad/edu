package request_handlers;


import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import model.Gender;
import model.News;
import model.Role;
import model.Term;
import model.TermClass;
import model.User;
import utility.Message;

/**
 * Servlet implementation class SignInServlet
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/RegisterServlet" })
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisterServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		// Set response content type
		if(request.getParameter("classId") == null) {
			response.sendRedirect("./index.jsp");
			return;
		}
		User user = User.getCurrentUser(request.getSession());
		if(user == null || user.role != Role.STUDENT) {
			response.sendRedirect("./index.jsp");
			return;
		}
		
		int classId = Integer.parseInt(request.getParameter("classId"));
		
		if(request.getParameter("command") == null) {
			int registrationResult = 3;
			if(! TermClass.isClassFull(classId)) {
				registrationResult = TermClass.registerInClass(user, classId);
			}
			switch (registrationResult) {
			case 0: // success
				request.getSession().setAttribute("message", new Message("ثبت‌نام با موفقیت انجام شد.", "green"));
				response.sendRedirect("./registration.jsp");
				break;
			case 1: // failure.
				request.getSession().setAttribute("message", new Message("ثبت‌نام با موفقیت انجام نشد."));
				response.sendRedirect("./registration.jsp");
				break;
			case 2: // already exists;
				request.getSession().setAttribute("message", new Message("شما قبلا در این کلاس ثبت‌نام کرده‌اید."));
				response.sendRedirect("./registration.jsp");
				break;
			case 3: // class full;
				request.getSession().setAttribute("message", new Message("ظرفیت این کلاس پر شده است."));
				response.sendRedirect("./registration.jsp");
				break;
			}
			
			return;
		}
		String command = request.getParameter("command");
		if("unregister".equals(command)) {
			if(request.getParameter("userId") == null) {
				request.getSession().setAttribute("message", new Message("اطلاعات کافی نیست."));
				response.sendRedirect("./class.jsp?id="+classId);
				return;
			}
			int userId = Integer.parseInt(request.getParameter("userId"));
			TermClass.removeFromClass(user, classId);
			request.getSession().setAttribute("message", new Message("ثبت‌نام با موفقیت حذف شد.", "green"));
			response.sendRedirect("./participants.jsp?type=class&classId=" + classId);
			return;
		}
		
	}
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		// Set response content type
		if(request.getParameter("classId") == null) {
			response.sendRedirect("./index.jsp");
			return;
		}
		User user = User.getCurrentUser(request.getSession());
		if(user == null || user.role != Role.ADMIN) {
			response.sendRedirect("./index.jsp");
			return;
		}
		
		if(request.getParameter("classId") == null) {
			response.sendRedirect("./classes.jsp");
			return;
		}
		int classId = Integer.parseInt(request.getParameter("classId"));
		
		String command = request.getParameter("command");
		if("unregister".equals(command)) {
			if(request.getParameter("userId") == null) {
				request.getSession().setAttribute("message", new Message("اطلاعات کافی نیست."));
				response.sendRedirect("./participants.jsp?type=class&classId=" + classId);
				return;
			}
			int userId = Integer.parseInt(request.getParameter("userId"));
			User removeUser = User.fetchUser(userId);
			TermClass.removeFromClass(removeUser, classId);
			request.getSession().setAttribute("message", new Message("ثبت‌نام با موفقیت حذف شد.", "green"));
			response.sendRedirect("./participants.jsp?type=class&classId=" + classId);
			return;
		}
		
	}

}
