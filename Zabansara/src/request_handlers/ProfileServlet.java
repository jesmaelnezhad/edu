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
import model.Role;
import model.User;
import utility.Message;

/**
 * Servlet implementation class SignInServlet
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/ProfileServlet" })
public class ProfileServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProfileServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		// Set response content type
		String command = (String) request.getParameter("command");
		
//		if(command == null || title == "") {
//			if(newsContent != null && newsContent != "") {
//				request.getSession().setAttribute("news_content", newsContent);
//			}
//			response.sendRedirect(request.getContextPath() + "/news.jsp");
//			return;
//		}
		
		if("passchange".equals(command)) {
			
			User user = User.getCurrentUser(request.getSession());
			if(user == null) {
				response.sendRedirect(request.getContextPath() + "/index.jsp");
				return;
			}
			String password = (String) request.getParameter("current_password");
			String newPassword = (String) request.getParameter("new_password");
			String newPassword2 = (String) request.getParameter("new_password2");
			if((! User.isCurrentUserSecondary(request.getSession()) && password==null) || newPassword == null || newPassword2 == null ||
					!newPassword.equals(newPassword2)) {
				request.getSession().setAttribute("message", new Message("لطفا دوباره امتحان کنید."));
				response.sendRedirect(request.getContextPath() + "/profile.jsp");
				return;
			}
			User tryLoginUser = null;
			if(! User.isCurrentUserSecondary(request.getSession())) {
				tryLoginUser = User.fetchUser(user.username, password);				
			}else {
				tryLoginUser = User.fetchUser(user.username);
			}

			if(tryLoginUser == null) {
				request.getSession().setAttribute("message", new Message("نام کاربری یا رمز عبور اشتباه است"));
				response.sendRedirect(request.getContextPath() + "/profile.jsp");
				return;
			}
			User.updatePassword(tryLoginUser, newPassword);
			request.getSession().setAttribute("message", new Message("رمز عبور با موفقیت تغییر یافت.", "green"));
		}


		response.sendRedirect(request.getContextPath() + "/profile.jsp");
		return;
	}

}
