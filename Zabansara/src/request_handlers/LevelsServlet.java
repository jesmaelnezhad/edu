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

import model.Exam;
import model.Level;
import model.News;
import model.Photo;
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
		
		if("add".equals(command)) {
			String title = (String) request.getParameter("title");

			if(title == null || title.equals("")) {
				request.getSession().setAttribute("message", new Message("اطلاعات سطح را کامل وارد کنید."));
				response.sendRedirect(request.getContextPath() + "/terms.jsp");
				return;
			}
			Level newLevel = Level.addLevel(title);
		}else if("remove".equals(command)) {
			if(request.getParameter("levelId") == null) {
				request.getSession().setAttribute("message", new Message("اطلاعات کافی نیست."));
				response.sendRedirect(request.getContextPath() + "/terms.jsp");
				return;
			}
			int id = Integer.parseInt(request.getParameter("levelId"));
			Level.deleteLevel(id);
			request.getSession().setAttribute("message", new Message("سطح با موفقیت حذف شد.", "green"));
		}else if("update".equals(command)) {
			
			if(request.getParameter("levelId") == null ) {
				request.getSession().setAttribute("message", new Message("اطلاعات کافی نیست."));
				response.sendRedirect(request.getContextPath() + "/terms.jsp");
				return;
			}
			int id = Integer.parseInt(request.getParameter("levelId"));
			String title = (String) request.getParameter("levelTitle");

			if(title == null || title.equals("")) {
				request.getSession().setAttribute("message", new Message("اطلاعات سطح را کامل وارد کنید."));
				response.sendRedirect(request.getContextPath() + "/terms.jsp");
				return;
			}
			
			Level level = Level.fetchLevel(id);
			if(level == null) {
				request.getSession().setAttribute("message", new Message("سطح یافت نشد."));
				response.sendRedirect(request.getContextPath() + "/terms.jsp");
				return;
			}
			level.title = title;
			Level.updateLevel(level);
			request.getSession().setAttribute("message", new Message("سطح با موفقیت تغییر یافت.", "green"));
			response.sendRedirect(request.getContextPath() + "/terms.jsp");
			return;
		}



		response.sendRedirect(request.getContextPath() + "/terms.jsp");
		return;
	}

}
