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
@WebServlet(asyncSupported = true, urlPatterns = { "/LevelsServlet" })
public class LevelsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LevelsServlet() {
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

		if(title == null || title.equals("")) {
			request.getSession().setAttribute("message", new Message("اطلاعات سطح را کامل وارد کنید."));
			response.sendRedirect(request.getContextPath() + "/terms.jsp");
			return;
		}
		
		if("add".equals(command)) {
			Level newLevel = Level.addLevel(title);
		}


		response.sendRedirect(request.getContextPath() + "/terms.jsp");
		return;
	}

}
