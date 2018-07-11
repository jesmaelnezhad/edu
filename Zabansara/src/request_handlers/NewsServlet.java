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
import model.User;
import utility.Message;

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
		
		if("save".equals(command)) {
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
			if(photoFile != null) {
				String photoName = photoFile.getSubmittedFileName();
			    News news = News.saveNews(title, newsContent, photoName);
			    Photo.savePhoto("news", news.id, photoFile, getServletContext());
			}else {
			    News news = News.saveNews(title, newsContent, null);
			}
		}else if("remove".equals(command)) {
			if(request.getParameter("newsId") == null) {
				request.getSession().setAttribute("message", new Message("اطلاعات کافی نیست."));
				response.sendRedirect(request.getContextPath() + "/news.jsp");
				return;
			}
			int id = Integer.parseInt(request.getParameter("newsId"));
			News.deleteNews(id);
			request.getSession().setAttribute("message", new Message("مطلب با موفقیت حذف شد.", "green"));
		}else if("update".equals(command)) {
			
			if(request.getParameter("newsId") == null ) {
				request.getSession().setAttribute("message", new Message("اطلاعات کافی نیست."));
				response.sendRedirect(request.getContextPath() + "/news.jsp");
				return;
			}
			int id = Integer.parseInt(request.getParameter("newsId"));
			News news = News.fetchNews(id);
			if(news == null) {
				request.getSession().setAttribute("message", new Message("مطلب یافت نشد."));
				response.sendRedirect(request.getContextPath() + "/news.jsp");
				return;
			}
			
			String title = (String) request.getParameter("title");
			Part photoFile = request.getPart("photo_file");
			String newsContent = (String) request.getParameter("news_content");
			if(title == null || title == "") {
				response.sendRedirect(request.getContextPath() + "/news.jsp");
				return;
			}
			news.title = title;
			news.content = newsContent;
			if(photoFile != null && ! "".equals(photoFile.getSubmittedFileName())) {
				String photoName = photoFile.getSubmittedFileName();
				news.photoName = photoName;
			    News.updateNews(news);
			    Photo.savePhoto("news", news.id, photoFile, getServletContext());
			}else {
			    News.updateNews(news);
			}

			request.getSession().setAttribute("message", new Message("مطلب با موفقیت تغییر یافت.", "green"));
			response.sendRedirect(request.getContextPath() + "/news.jsp");
			return;
		}


		response.sendRedirect(request.getContextPath() + "/news.jsp");
		return;
	}

}
