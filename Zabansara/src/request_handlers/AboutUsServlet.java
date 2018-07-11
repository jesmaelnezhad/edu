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

import model.AboutUs;
import model.Level;
import model.News;
import model.Photo;
import model.User;
import utility.Message;

/**
 * Servlet implementation class SignInServlet
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/AboutUsServlet" })
public class AboutUsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AboutUsServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		// Set response content type
		String command = (String) request.getParameter("command");
		
		if("save".equals(command)) {
			String menu_item = (String) request.getParameter("menu_item");
			Part photoFile = request.getPart("photo_file");
			if(menu_item == null || menu_item == "") {
				response.sendRedirect(request.getContextPath() + "/aboutus.jsp");
				return;
			}
			if(photoFile != null) {
				String photoName = photoFile.getSubmittedFileName();
			    AboutUs aboutus = AboutUs.saveAboutUs(menu_item, photoName);
			    Photo.savePhoto("aboutus", aboutus.id, photoFile, getServletContext());
			}else {
				request.getSession().setAttribute("message", new Message("اطلاعات کافی نیست."));
				response.sendRedirect(request.getContextPath() + "/aboutus.jsp");
				return;	
			}
		}else if("remove".equals(command)) {
			if(request.getParameter("aboutusId") == null) {
				request.getSession().setAttribute("message", new Message("اطلاعات کافی نیست."));
				response.sendRedirect(request.getContextPath() + "/aboutus.jsp");
				return;
			}
			int id = Integer.parseInt(request.getParameter("aboutusId"));
			AboutUs.deleteAboutUs(id);
			request.getSession().setAttribute("message", new Message("درباره ما با موفقیت حذف شد.", "green"));
		}else if("update".equals(command)) {
			
			if(request.getParameter("aboutusId") == null ) {
				request.getSession().setAttribute("message", new Message("اطلاعات کافی نیست."));
				response.sendRedirect(request.getContextPath() + "/aboutus.jsp");
				return;
			}
			int id = Integer.parseInt(request.getParameter("aboutusId"));
			AboutUs aboutus = AboutUs.fetchAboutUs(id);
			if(aboutus == null) {
				request.getSession().setAttribute("message", new Message("درباره ما یافت نشد."));
				response.sendRedirect(request.getContextPath() + "/aboutus.jsp");
				return;
			}
			
			String menu_item = (String) request.getParameter("menu_item");
			Part photoFile = request.getPart("photo_file");
			if(menu_item == null || menu_item == "") {
				response.sendRedirect(request.getContextPath() + "/aboutus.jsp");
				return;
			}
			aboutus.menu_item = menu_item;
			if(photoFile != null && ! "".equals(photoFile.getSubmittedFileName())) {
				String photoName = photoFile.getSubmittedFileName();
				aboutus.photoName = photoName;
			    AboutUs.updateAboutUs(aboutus);
			    Photo.savePhoto("aboutus", aboutus.id, photoFile, getServletContext());
			}else {
			    AboutUs.updateAboutUs(aboutus);
			}

			request.getSession().setAttribute("message", new Message("درباره ما با موفقیت تغییر یافت.", "green"));
			response.sendRedirect(request.getContextPath() + "/aboutus.jsp");
			return;
		}


		response.sendRedirect(request.getContextPath() + "/aboutus.jsp");
		return;
	}

}
