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
import model.Term;
import model.User;
import utility.Message;
import utility.Photo;

/**
 * Servlet implementation class SignInServlet
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/UsersServlet" })
public class UsersServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UsersServlet() {
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
			int roleSelector = Integer.parseInt(request.getParameter("role_selector"));
			Role role = Role.STUDENT;
			switch (roleSelector) {
			case 0:
				role = Role.STUDENT;
				break;
			case 1:
				role = Role.TEACHER;
				break;
			case 2:
				role = Role.ADMIN;
				break;
			}
			String fname = (String) request.getParameter("fname");
			String lname = (String) request.getParameter("lname");
			String cellphone = (String) request.getParameter("cellphone");
			String nationalCode = (String) request.getParameter("national_code");
			String emailAddr = (String) request.getParameter("email_addr");
			String username = (String) request.getParameter("username");
			String password = nationalCode;
			String studentId = username;
			Part idImagePart = request.getPart("id_image");
			Part photoPart = request.getPart("photo");
			
			User tryUserExists = User.fetchUser(username);
			if(tryUserExists != null) {
				request.getSession().setAttribute("message", new Message("این نام کاربری در سیستم وجود دارد.", "green"));
			}else {
				User newUser = User.addNewUser(role, username, password, fname, 
						lname, cellphone, emailAddr, nationalCode, 
						studentId, idImagePart.getSubmittedFileName(), 
						photoPart.getSubmittedFileName());
				Photo.savePhoto("users", newUser.id, idImagePart, getServletContext());
				Photo.savePhoto("users", newUser.id, photoPart, getServletContext());
				request.getSession().setAttribute("message", new Message("کاربر با موفقیت اضافه شد.", "green"));
			}
		}


		response.sendRedirect(request.getContextPath() + "/signup.jsp");
		return;
	}

}
