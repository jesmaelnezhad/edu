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
import model.ExamType;
import model.Gender;
import model.News;
import model.Term;
import model.TermClass;
import model.User;
import utility.Message;

/**
 * Servlet implementation class SignInServlet
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/ClassServlet" })
public class ClassServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ClassServlet() {
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
			int termId = Integer.parseInt(request.getParameter("termId"));
			int scheduleId = Integer.parseInt(request.getParameter("scheduleId"));
			int teacherId = Integer.parseInt(request.getParameter("teacherId"));
			String genderStr = request.getParameter("gender");
			Gender gender = Gender.BOYS;
			if("boys".equals(genderStr)) {
				gender = Gender.BOYS;
			}else if("girls".equals(genderStr)) {
				gender = Gender.GIRLS;			
			}else {
				gender = Gender.BOTH;
			}
			int levelId = Integer.parseInt(request.getParameter("levelId"));
			int size = Integer.parseInt(request.getParameter("size"));
			String notes = request.getParameter("notes");
			if(notes == null) {
				notes = "";
			}
			TermClass newClass = TermClass.addClass(termId, teacherId, gender, levelId, size, scheduleId, notes);
			if(newClass != null) {
				// add the exams of this class
				Exam midtermExam = Exam.addClassExam(newClass.id, ExamType.MIDTERM);
				Exam finalExam = Exam.addClassExam(newClass.id, ExamType.FINAL);
				Exam participationExam = Exam.addClassExam(newClass.id, ExamType.PARTICIPATION);
				if(midtermExam == null || finalExam == null || participationExam == null) {
					TermClass.removeClass(newClass.id);
					request.getSession().setAttribute("message", new Message("کلاس جدید با موفقیت اضافه نشد."));
				}else {
					request.getSession().setAttribute("message", new Message("کلاس جدید با موفقیت اضافه شد.", "green"));
				}
			}else {
				request.getSession().setAttribute("message", new Message("کلاس جدید با موفقیت اضافه نشد.", "red"));
			}
			request.getSession().setAttribute("selected_termId", termId);

			response.sendRedirect("./classes.jsp");
			return;
		}
		
		if("editContent".equals(command)) {
			int classId = Integer.parseInt(request.getParameter("classId"));
			String content = (String)request.getParameter("content");	
			boolean result = TermClass.updateContent(classId, content);
			if(! result) {
				request.getSession().setAttribute("message", new Message("مطلب کلاسی آپدیت نشد.", "red"));
			}
			response.sendRedirect("./class.jsp?id=" + classId);
			return;
		}
		
		if("remove".equals(command)) {
			
			if(request.getParameter("classId") == null || request.getParameter("termId") == null) {
				request.getSession().setAttribute("message", new Message("اطلاعات کافی نیست."));
				response.sendRedirect("./classes.jsp");
				return;
			}
			int id = Integer.parseInt(request.getParameter("classId"));
			int termId = Integer.parseInt(request.getParameter("termId"));
			TermClass.removeClass(id);
			request.getSession().setAttribute("selected_termId", termId);
			request.getSession().setAttribute("message", new Message("كلاس با موفقیت حذف شد.", "green"));
			response.sendRedirect("./classes.jsp");
			return;
		}

	}

}
