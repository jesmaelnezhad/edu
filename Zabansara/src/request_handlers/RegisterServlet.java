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
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		// Set response content type
		if(request.getParameter("classId") == null) {
			response.sendRedirect(request.getContextPath() + "/index.jsp");
			return;
		}
		User user = User.getCurrentUser(request.getSession());
		if(user == null || user.role != Role.STUDENT) {
			response.sendRedirect(request.getContextPath() + "/index.jsp");
			return;
		}
		
		int classId = Integer.parseInt(request.getParameter("classId"));
		
		int registrationResult = TermClass.registerInClass(user, classId);
		switch (registrationResult) {
		case 0: // success
			request.getSession().setAttribute("message", new Message("ثبت‌نام با موفقیت انجام شد.", "green"));
			response.sendRedirect(request.getContextPath() + "/registration.jsp");
			break;
		case 1: // failure.
			request.getSession().setAttribute("message", new Message("ثبت‌نام با موفقیت انجام نشد."));
			response.sendRedirect(request.getContextPath() + "/registration.jsp");
			break;
		case 2: // already exists;
			request.getSession().setAttribute("message", new Message("شما قبلا در این کلاس ثبت‌نام کرده‌اید."));
			response.sendRedirect(request.getContextPath() + "/registration.jsp");
			break;
		}

		return;
	}

}
