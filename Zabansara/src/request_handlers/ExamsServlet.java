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
import model.News;
import model.Role;
import model.Term;
import model.TermClass;
import model.User;
import utility.Message;

/**
 * Servlet implementation class SignInServlet
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/ExamsServlet" })
public class ExamsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ExamsServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		// Set response content type
		if(request.getParameter("command") == null) {
			response.sendRedirect(request.getContextPath() + "/exams.jsp");
			return;
		}
		String command = (String) request.getParameter("command");
		
		
		if("register".equals(command) || "unregister".equals(command)) {
			// takes examId and student must be logged in
			if(request.getParameter("examId") == null) {
				request.getSession().setAttribute("message", new Message("اطلاعات برای ثبت‌نام کافی نیست."));
				response.sendRedirect(request.getContextPath() + "/exams.jsp");
				return;
			}
			int examId = Integer.parseInt(request.getParameter("examId"));
			User user = User.getCurrentUser(request.getSession());
			if(user == null) {
				response.sendRedirect(request.getContextPath() + "/index.jsp");
				return;
			}else if("register".equals(command) && user.role != Role.STUDENT) {
				request.getSession().setAttribute("message", new Message("فقط زبان‌آموزها می‌توانند در آزمون ثبت‌نام کنند."));
				response.sendRedirect(request.getContextPath() + "/exams.jsp");
				return;
			}
			
			Exam exam = Exam.fetchExam(examId);
			
			if("register".equals(command)) {
				Exam.registerInExam(exam, user);
				request.getSession().setAttribute("message", new Message("ثبت‌نام با موفقیت انجام شد.", "green"));
				response.sendRedirect(request.getContextPath() + "/exams.jsp");
				return;
			}else if("unregister".equals(command)) {
				if(request.getParameter("userId") == null) {
					Exam.removeExamRegistration(exam, user);
				}else {
					int userId = Integer.parseInt(request.getParameter("userId"));
					User student = User.fetchUser(userId);
					if(student == null) {
						request.getSession().setAttribute("message", new Message("زبان‌آموز یافت نشد"));
						response.sendRedirect(request.getContextPath() + "/exams.jsp");
						return;
					}
					Exam.removeExamRegistration(exam, student);
				}
				request.getSession().setAttribute("message", new Message("ثبت‌نام با موفقیت حذف شد.", "green"));
				response.sendRedirect(request.getContextPath() + "/participants.jsp?type=general_exam&examId="+exam.id);
				return;
			}
			
		}
		response.sendRedirect(request.getContextPath() + "/exams.jsp");
		return;
	}
    
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		// Set response content type
		if(request.getParameter("command") == null) {
			response.sendRedirect(request.getContextPath() + "/exams.jsp");
			return;
		}
		String command = (String) request.getParameter("command");
		
		
		if("add".equals(command)) {
			String title = (String) request.getParameter("examTitle");

			if(title == null || title.equals("")) {
				request.getSession().setAttribute("message", new Message("اطلاعات آزمون را کامل وارد کنید."));
				response.sendRedirect(request.getContextPath() + "/exams.jsp");
				return;
			}
			
			Exam newExam = Exam.addGeneralExam(title);
			if(newExam == null) {
				request.getSession().setAttribute("message", new Message("آزمون با موفقیت اضافه نشد."));
				response.sendRedirect(request.getContextPath() + "/exams.jsp");
				return;
			}
			request.getSession().setAttribute("message", new Message("آزمون با موفقیت اضافه شد.", "green"));
		}else if("register".equals(command) || "unregister".equals(command)) {
			// takes examId and student must be logged in
			if(request.getParameter("examId") == null) {
				request.getSession().setAttribute("message", new Message("اطلاعات برای ثبت‌نام کافی نیست."));
				response.sendRedirect(request.getContextPath() + "/exams.jsp");
				return;
			}
			int examId = Integer.parseInt(request.getParameter("examId"));
			User user = User.getCurrentUser(request.getSession());
			if(user == null) {
				response.sendRedirect(request.getContextPath() + "/index.jsp");
				return;
			}else if("register".equals(command) && user.role != Role.STUDENT) {
				request.getSession().setAttribute("message", new Message("فقط زبان‌آموزها می‌توانند در آزمون ثبت‌نام کنند."));
				response.sendRedirect(request.getContextPath() + "/exams.jsp");
				return;
			}
			
			Exam exam = Exam.fetchExam(examId);
			
			if("register".equals(command)) {
				Exam.registerInExam(exam, user);
				request.getSession().setAttribute("message", new Message("ثبت‌نام با موفقیت انجام شد.", "green"));
				response.sendRedirect(request.getContextPath() + "/exams.jsp");
				return;
			}else if("unregister".equals(command)) {
				if(request.getParameter("userId") == null) {
					Exam.removeExamRegistration(exam, user);
				}else {
					int userId = Integer.parseInt(request.getParameter("userId"));
					User student = User.fetchUser(userId);
					if(student == null) {
						request.getSession().setAttribute("message", new Message("زبان‌آموز یافت نشد"));
						response.sendRedirect(request.getContextPath() + "/exams.jsp");
						return;
					}
					Exam.removeExamRegistration(exam, student);
				}
				request.getSession().setAttribute("message", new Message("ثبت‌نام با موفقیت حذف شد.", "green"));
				response.sendRedirect(request.getContextPath() + "/participants.jsp?type=general_exam&examId="+exam.id);
				return;
			}
			
		}else if("remove".equals(command)) {
			
			if(request.getParameter("examId") == null ) {
				request.getSession().setAttribute("message", new Message("اطلاعات کافی نیست."));
				response.sendRedirect(request.getContextPath() + "/exams.jsp");
				return;
			}
			int id = Integer.parseInt(request.getParameter("examId"));
			Exam.deleteExam(id);
			request.getSession().setAttribute("message", new Message("آزمون با موفقیت حذف شد.", "green"));
			response.sendRedirect(request.getContextPath() + "/exams.jsp");
			return;
		}else if("update".equals(command)) {
			
			if(request.getParameter("examId") == null ) {
				request.getSession().setAttribute("message", new Message("اطلاعات کافی نیست."));
				response.sendRedirect(request.getContextPath() + "/exams.jsp");
				return;
			}
			int id = Integer.parseInt(request.getParameter("examId"));
			String title = (String) request.getParameter("examTitle");

			if(title == null || title.equals("")) {
				request.getSession().setAttribute("message", new Message("اطلاعات آزمون را کامل وارد کنید."));
				response.sendRedirect(request.getContextPath() + "/exams.jsp");
				return;
			}
			
			Exam newExam = Exam.fetchExam(id);
			if(newExam == null) {
				request.getSession().setAttribute("message", new Message("آزمون یافت نشد."));
				response.sendRedirect(request.getContextPath() + "/exams.jsp");
				return;
			}
			newExam.title = title;
			Exam.updateExam(newExam);
			request.getSession().setAttribute("message", new Message("آزمون با موفقیت تغییر یافت.", "green"));
			response.sendRedirect(request.getContextPath() + "/exams.jsp");
			return;
		}


		response.sendRedirect(request.getContextPath() + "/exams.jsp");
		return;
	}

}
