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

import model.Level;
import model.News;
import model.Term;
import model.User;
import utility.Message;

/**
 * Servlet implementation class SignInServlet
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/TermsServlet" })
public class TermsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TermsServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		// Set response content type
		String command = (String) request.getParameter("command");
		
		if("add".equals(command)) {
			String title = (String) request.getParameter("title");
			String termStart = (String) request.getParameter("term_start");
			String classesStart = (String) request.getParameter("classes_start");
			String finalsStart = (String) request.getParameter("finals_start");
			String termEnd = (String) request.getParameter("term_end");

			if(title == null || title.equals("")
					|| termStart == null || termStart.equals("")
					|| classesStart == null || classesStart.equals("")
					|| finalsStart == null || finalsStart.equals("")
					|| termEnd == null || termEnd.equals("")) {
				request.getSession().setAttribute("message", new Message("اطلاعات ترم را کامل وارد کنید."));
				response.sendRedirect("./terms.jsp");
				return;
			}
			Term newTerm = Term.addTerm(title, termStart, classesStart, finalsStart, termEnd);
		}else if("remove".equals(command)) {
			if(request.getParameter("termId") == null) {
				request.getSession().setAttribute("message", new Message("اطلاعات کافی نیست."));
				response.sendRedirect("./terms.jsp");
				return;
			}
			int id = Integer.parseInt(request.getParameter("termId"));
			Term.deleteTerm(id);
			request.getSession().setAttribute("message", new Message("ترم با موفقیت حذف شد.", "green"));
		}else if("update".equals(command)) {
			
			if(request.getParameter("termId") == null ) {
				request.getSession().setAttribute("message", new Message("اطلاعات کافی نیست."));
				response.sendRedirect("./terms.jsp");
				return;
			}
			int id = Integer.parseInt(request.getParameter("termId"));
			String title = (String) request.getParameter("title");
			String termStart = (String) request.getParameter("term_start");
			String classesStart = (String) request.getParameter("classes_start");
			String finalsStart = (String) request.getParameter("finals_start");
			String termEnd = (String) request.getParameter("term_end");

			if(title == null || title.equals("")
					|| termStart == null || termStart.equals("")
					|| classesStart == null || classesStart.equals("")
					|| finalsStart == null || finalsStart.equals("")
					|| termEnd == null || termEnd.equals("")) {
				request.getSession().setAttribute("message", new Message("اطلاعات ترم را کامل وارد کنید."));
				response.sendRedirect("./terms.jsp");
				return;
			}
			
			Term term = Term.fetchTerm(id);
			if(term == null) {
				request.getSession().setAttribute("message", new Message("ترم یافت نشد."));
				response.sendRedirect("./terms.jsp");
				return;
			}
			term.title = title;
			term.termStart = termStart;
			term.classesStart = classesStart;
			term.finalsStart = finalsStart;
			term.termEnd = termEnd;
			Term.updateTerm(term);
			request.getSession().setAttribute("message", new Message("ترم با موفقیت تغییر یافت.", "green"));
			response.sendRedirect("./terms.jsp");
			return;
		}


		response.sendRedirect("./terms.jsp");
		return;
	}

}
