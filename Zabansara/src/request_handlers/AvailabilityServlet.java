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

import model.Content;
import model.News;
import model.Role;
import model.Term;
import model.User;
import utility.Constants;
import utility.Message;

/**
 * Servlet implementation class SignInServlet
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/AvailabilityServlet" })
public class AvailabilityServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AvailabilityServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		// Set response content type
		String command = (String) request.getParameter("command");
		
		if(request.getParameter("termId") == null) {
			response.sendRedirect(request.getContextPath() + "/availability.jsp");
			return;
		}
		User user = User.getCurrentUser(request.getSession());
		if(user == null || user.role == Role.STUDENT) {
			response.sendRedirect(request.getContextPath() + "/index.jsp");
			return;			
		}
		int termId = Integer.parseInt((String)request.getParameter("termId"));
		
		if("edit".equals(command)) {
			String [] ScheduleTitles = Constants.ScheduleTitles;
			for(int scheduleId = 1; scheduleId < ScheduleTitles.length * 6 + 1; scheduleId ++) {
				if(request.getParameter("schedule_"+scheduleId) == null) {
					Term.setTeacherAvailablity(termId, user.id, scheduleId, false);
				}else {
					Term.setTeacherAvailablity(termId, user.id, scheduleId, true);					
				}
			}
		}else if("updateContent".equals(command)) {
			String content = request.getParameter("availability_content");
			if(content == null) {
				request.getSession().setAttribute("selected_termId", termId);
				response.sendRedirect(request.getContextPath() + "/classes.jsp");
				return;
			}
			Content newContent = new Content(Constants.AvailabilityContentID, content);
			Content.updateContent(newContent);
			request.getSession().setAttribute("selected_termId", termId);
			response.sendRedirect(request.getContextPath() + "/classes.jsp");
			return;
		}

		request.getSession().setAttribute("selected_termId", termId);
		response.sendRedirect(request.getContextPath() + "/availability.jsp");
		return;
	}

}
