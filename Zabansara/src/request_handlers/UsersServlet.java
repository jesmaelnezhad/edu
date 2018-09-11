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
import model.Photo;
import model.Role;
import model.Term;
import model.User;
import utility.Message;

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
		User user = User.getCurrentUser(request.getSession());
		if(user == null || user.role != Role.ADMIN) {
			response.sendRedirect("./index.jsp");
			return;
		}
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
		}else if("remove".equals(command)) {
			if(request.getParameter("userId") == null) {
				request.getSession().setAttribute("message", new Message("اطلاعات کافی نیست."));
				response.sendRedirect("./users.jsp");
				return;
			}
			int id = Integer.parseInt(request.getParameter("userId"));
			User.deleteUser(id);
			request.getSession().setAttribute("message", new Message("کاربر با موفقیت حذف شد.", "green"));
			response.sendRedirect("./users.jsp");
			return;
		}else if("update".equals(command)) {
			
			if(request.getParameter("userId") == null ) {
				request.getSession().setAttribute("message", new Message("اطلاعات کافی نیست."));
				response.sendRedirect("./users.jsp");
				return;
			}
			int id = Integer.parseInt(request.getParameter("userId"));
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
			Part idImagePart = request.getPart("id_image");
			Part photoPart = request.getPart("photo");

//			if(title == null || title.equals("")) {
//				request.getSession().setAttribute("message", new Message("اطلاعات سطح را کامل وارد کنید."));
//				response.sendRedirect("./terms.jsp");
//				return;
//			}
			
			User changeUser = User.fetchUser(id);
			if(changeUser == null) {
				request.getSession().setAttribute("message", new Message("كاربر یافت نشد."));
				response.sendRedirect("./users.jsp");
				return;
			}
			changeUser.role = role;
			changeUser.fname = fname;
			changeUser.lname = lname;
			changeUser.cellphone_number = cellphone;
			changeUser.national_code = nationalCode;
			changeUser.email_addr = emailAddr;
			if(photoPart != null) {
				changeUser.photoName = idImagePart.getSubmittedFileName();
			}
			if(idImagePart != null) {
				changeUser.photoName2 = photoPart.getSubmittedFileName();
			}
			User.updateUser(changeUser);
			if(changeUser.id == user.id) {
				if(User.isCurrentUserSecondary(request.getSession())) {
					User.setSecondaryUser(request.getSession(), changeUser);
				}else {
					User.setCurrentUser(request.getSession(), changeUser);
				}
				user = changeUser;
			}
			if(photoPart != null) {
				Photo.savePhoto("users", id, photoPart, request.getServletContext());
			}
			if(idImagePart != null) {
				Photo.savePhoto("users", id, idImagePart, request.getServletContext());
			}
			request.getSession().setAttribute("message", new Message("کاربر با موفقیت تغییر یافت.", "green"));
			response.sendRedirect("./users.jsp");
			return;
		}


		response.sendRedirect("./users.jsp");
		return;
	}

}
