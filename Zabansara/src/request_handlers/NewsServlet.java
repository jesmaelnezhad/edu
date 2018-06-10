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
import model.User;
import utility.Photo;

/**
 * Servlet implementation class SignInServlet
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/NewsServlet" })
public class NewsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public NewsServlet() {
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
		Part photoFile = request.getPart("photo_file");
		String newsContent = (String) request.getParameter("news_content");
		if(title == null || title == "") {
			if(newsContent != null && newsContent != "") {
				request.getSession().setAttribute("news_content", newsContent);
			}
			response.sendRedirect(request.getContextPath() + "/news.jsp");
			return;
		}
		
		if("save".equals(command)) {
			if(photoFile != null) {
				String photoName = photoFile.getSubmittedFileName();
			    News news = News.saveNews(title, newsContent, photoName);
			    Photo.savePhoto("news", news.id, photoFile, getServletContext());
			}else {
			    News news = News.saveNews(title, newsContent, null);
			}
		}


		response.sendRedirect(request.getContextPath() + "/news.jsp");
		return;
	}

}
