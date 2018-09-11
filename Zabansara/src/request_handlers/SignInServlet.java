package request_handlers;


import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Role;
import model.User;
import utility.Message;

/**
 * Servlet implementation class SignInServlet
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/SignInServlet" })
public class SignInServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SignInServlet() {
        super();
    }
    
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		// Set response content type
	    response.setContentType("text/html");
	    PrintWriter out = response.getWriter();
	    if(request.getParameter("secondaryLogin") != null) {
	    	User loginUser = User.getCurrentUser(request.getSession());
	    	if(loginUser == null || loginUser.role != Role.ADMIN) {
				response.sendRedirect("./signin.jsp");
				return;
	    	}
	    	if(request.getParameter("userId") == null) {
				response.sendRedirect("./index.jsp");
				return;	    		
	    	}
	    	int userId = Integer.parseInt(request.getParameter("userId"));
	    	User secondaryUser = User.fetchUser(userId);
	    	User.setSecondaryUser(request.getSession(), secondaryUser);
			response.sendRedirect("./index.jsp");
			return;	    
	    }
    }
    
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		// Set response content type
	    response.setContentType("text/html");
	    PrintWriter out = response.getWriter();
		
		String username = (String) request.getParameter("username");
		String password = (String) request.getParameter("password");
		if(username == null || username == "" || password == "" || password == null) {
			response.sendRedirect("./index.jsp");
			return;
		}
		
		// make sure no other user is signed in.
		User.removeCurrentUser(request.getSession());
		
		// sign in new user
		User newUser = User.fetchUser(username, password);
		if(newUser == null) {
			request.getSession().setAttribute("message", new Message("رمز عبور یا نام کاربری اشتباه است."));
			response.sendRedirect("./signin.jsp");
			return;
		}
		User.setCurrentUser(request.getSession(), newUser);
		response.sendRedirect("./index.jsp");
		return;
	}

}
