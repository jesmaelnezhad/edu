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
			response.sendRedirect(request.getContextPath() + "/terms.jsp");
			return;
		}
		
		if("add".equals(command)) {
			Term newTerm = Term.addTerm(title, termStart, classesStart, finalsStart, termEnd);
		}


		response.sendRedirect(request.getContextPath() + "/terms.jsp");
		return;
	}

}
