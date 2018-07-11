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
import model.Photo;
import model.Term;
import model.User;
import utility.Message;

/**
 * Servlet implementation class SignInServlet
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/PhotosServlet" })
public class PhotosServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PhotosServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		if(request.getParameter("command") == null) {
			response.sendRedirect(request.getContextPath() + "/index.jsp");
			return;
		}
		String command = (String) request.getParameter("command");
		
		if("add".equals(command)) {
			String title = (String) request.getParameter("title");
			Part image = request.getPart("image");

			if(title == null || image == null) {
				response.sendRedirect(request.getContextPath() + "/index.jsp");
				return;
			}
			Photo newPhoto = Photo.insertNewPhoto(image.getSubmittedFileName(), title);
			if(newPhoto == null) {
				request.getSession().setAttribute("message", new Message("عکس با موفقیت اضافه نشد."));
			}else {
				Photo.savePhoto("banners", newPhoto.id, image, request.getServletContext());
				request.getSession().setAttribute("message", new Message("عکس با موفقیت اضافه شد.", "green"));
			}
		}else if("remove".equals(command)) {
			if(request.getParameter("photoId") == null) {
				request.getSession().setAttribute("message", new Message("اطلاعات کافی نیست."));
				response.sendRedirect(request.getContextPath() + "/index.jsp");
				return;
			}
			int id = Integer.parseInt(request.getParameter("photoId"));
			Photo.deletePhoto(id);
			request.getSession().setAttribute("message", new Message("عکس با موفقیت حذف شد.", "green"));
		}


		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
	}

}
