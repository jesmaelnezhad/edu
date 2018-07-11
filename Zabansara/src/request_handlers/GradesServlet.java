package request_handlers;


import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.sun.org.glassfish.gmbal.ParameterNames;

import model.Exam;
import model.Grade;
import model.News;
import model.Term;
import model.User;
import utility.Message;

/**
 * Servlet implementation class SignInServlet
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/GradesServlet" })
public class GradesServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GradesServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		// Set response content type
		String command = (String) request.getParameter("command");
		if(request.getParameter("examId") == null) {
			response.sendRedirect(request.getContextPath() + "/exams.jsp");
			return;
		}
		int examId = Integer.parseInt(request.getParameter("examId"));
		Exam exam = Exam.fetchExam(examId);
		if(exam == null) {
			response.sendRedirect(request.getContextPath() + "/exams.jsp");
			return;	
		}
		
		if("update".equals(command)) {

			List<User> participants = Exam.fetchExamParticipants(exam);
			for(User participant : participants) {
				String gradePName = "student_" + participant.id + "_grade";
				String notesPName = "student_" + participant.id + "_notes";
				if(request.getParameter(gradePName) != null) {
					String gradeStr = request.getParameter(gradePName);
					String notes = request.getParameter(notesPName);
					Grade grade=new Grade(participant.id, gradeStr, notes);
					Grade.updateOrInsertExamGrade(examId, grade);
				}
			}
			request.getSession().setAttribute("message", new Message("نمرات با موفقیت آپدیت شد." , "green"));
			if(request.getParameter("classId") != null) {
				int classId = Integer.parseInt(request.getParameter("classId"));
				response.sendRedirect(request.getContextPath() + "/class.jsp?id="+classId);
				return;
			}else {
				response.sendRedirect(request.getContextPath() + "/exams.jsp");
				return;				
			}
		}
		response.sendRedirect(request.getContextPath() + "/exams.jsp");
		return;
	}

}
