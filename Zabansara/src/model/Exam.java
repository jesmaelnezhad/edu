/**
 * 
 */
package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import db_handlers.DBManager;

/**
 * @author jam
 *
 */
public class Exam {
	public int id;
	public ExamType type;
	public String title = "";
	public String notes = "";
	public int classId = 0;
	public boolean isClassExam() {
		return ((type == ExamType.MIDTERM || 
				type == ExamType.FINAL || 
				type == ExamType.PARTICIPATION) && classId != 0);
	}
	
	public Exam(int id, ExamType type, String title, String notes, int classId) {
		this.id = id;
		this.type = type;
		this.title = title;
		this.notes = notes;
		this.classId = classId;
	}

	public static Exam addClassExam(int classId, ExamType type) {
		Exam exam = fetchClassExam(classId, type);
		if(exam != null) {
			return exam;
		}
		Connection conn = DBManager.getDBManager().getConnection();
		PreparedStatement stmt;
		try {
			stmt = conn.prepareStatement("INSERT INTO exams "
					+ "(type, title, notes, class_id) VALUE (?, ?, ?, ?);"
					, Statement.RETURN_GENERATED_KEYS);
			String title = "";
			switch (type) {
			case MIDTERM:
				title = "میان‌ترم";
				break;
			case FINAL:
				title = "فاينال";
				break;
			case PARTICIPATION:
				title = "نمرات کلاسی";
				break;
			default:
				stmt.close();
				return null;
			}
			stmt.setString(1, Exam.typeToString(type));
			stmt.setString(2, title);
			stmt.setString(3, "");
			stmt.setInt(4, classId);
			stmt.executeUpdate();
			ResultSet rs = stmt.getGeneratedKeys();
			if(rs.next()) {
				int id = rs.getInt(1);
				exam = new Exam(id, type, title, "", classId);
			}
			rs.close();
			stmt.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return exam;
	}
	
	public static Exam addGeneralExam(String title) {
		Exam exam = null;
		Connection conn = DBManager.getDBManager().getConnection();
		PreparedStatement stmt;
		try {
			stmt = conn.prepareStatement("INSERT INTO exams "
					+ "(type, title, notes) VALUE (?, ?, ?);"
					, Statement.RETURN_GENERATED_KEYS);
			stmt.setString(1, Exam.typeToString(ExamType.GENERAL));
			stmt.setString(2, title);
			stmt.setString(3, "");
			stmt.executeUpdate();
			ResultSet rs = stmt.getGeneratedKeys();
			if(rs.next()) {
				int id = rs.getInt(1);
				exam = new Exam(id, ExamType.GENERAL, title, "", 0);
			}
			rs.close();
			stmt.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return exam;
	}
	
	public static void deleteExam(int id) {
		Connection conn = DBManager.getDBManager().getConnection();
		try {
			PreparedStatement stmt = conn.prepareStatement("DELETE FROM exams WHERE id=?");
			stmt.setInt(1, id);
			stmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public static Exam fetchClassExam(int classId, ExamType type) {
		Exam exam = null;
		
		Connection conn = DBManager.getDBManager().getConnection();
		PreparedStatement stmt;
		try {
			stmt = conn.prepareStatement("SELECT * FROM exams WHERE class_id=? AND type=?;");
			stmt.setInt(1, classId);
			stmt.setString(2, Exam.typeToString(type));
			ResultSet rs = stmt.executeQuery();
			while(rs.next()) {
				int id = rs.getInt("id");
				String title = rs.getString("title");
				String notes = rs.getString("notes");
				
				exam = new Exam(id, type, title==null?"":title, notes==null?"":notes, classId);
			}
			rs.close();
			stmt.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return exam;
	}
	
	public static List<Exam> fetchGeneralExams() {
		List<Exam> exams = new ArrayList<>();
		
		Connection conn = DBManager.getDBManager().getConnection();
		PreparedStatement stmt;
		try {
			stmt = conn.prepareStatement("SELECT * FROM exams WHERE type=?;");
			stmt.setString(1, Exam.typeToString(ExamType.GENERAL));
			ResultSet rs = stmt.executeQuery();
			while(rs.next()) {
				int id = rs.getInt("id");
				String title = rs.getString("title");
				String notes = rs.getString("notes");
				
				exams.add(new Exam(id, ExamType.GENERAL, title==null?"":title, notes==null?"":notes, 0));
			}
			rs.close();
			stmt.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return exams;
	}
	
	public static Exam fetchExam(int id) {
		Exam exam = null;
		
		Connection conn = DBManager.getDBManager().getConnection();
		PreparedStatement stmt;
		try {
			stmt = conn.prepareStatement("SELECT * FROM exams WHERE id=?;");
			stmt.setInt(1, id);
			ResultSet rs = stmt.executeQuery();
			while(rs.next()) {
				String typeStr = rs.getString("type");
				ExamType type = Exam.convertFromString(typeStr);
				String title = rs.getString("title");
				String notes = rs.getString("notes");
				int classId = 0;
				if(type != ExamType.GENERAL) {
					classId = rs.getInt("class_id");
				}
				exam = new Exam(id, type, title==null?"":title, notes==null?"":notes, classId);
			}
			rs.close();
			stmt.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return exam;
	}
	
	public static void updateExam(Exam exam) {
		Connection conn = DBManager.getDBManager().getConnection();
		PreparedStatement stmt;
		try {
			stmt = conn.prepareStatement("UPDATE exams SET title=?,notes=? WHERE id=?;");
			stmt.setString(1, exam.title);
			stmt.setString(2, exam.notes);
			stmt.setInt(3, exam.id);
			stmt.executeUpdate();
			stmt.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public static ExamType convertFromString(String typeStr) {
		if("midterm".equals(typeStr)) {
			return ExamType.MIDTERM;
		}else if("final".equals(typeStr)) {
			return ExamType.FINAL;
		}else if("participation".equals(typeStr)) {
			return ExamType.PARTICIPATION;
		}else if("general".equals(typeStr)) {
			return ExamType.GENERAL;
		}
		return ExamType.MIDTERM;
	}
	
	public static String typeToString(ExamType type) {
		switch (type) {
		case MIDTERM:
			return "midterm";
		case FINAL:
			return "final";
		case PARTICIPATION:
			return "participation";
		case GENERAL:
			return "general";
		default:
			return "general";
		}
	}
	
	public static List<User> fetchExamParticipants(Exam exam){
		List<User> participants = new ArrayList<>();
		if(exam == null) {
			return participants;
		}
		if(exam.isClassExam()) {
			return TermClass.fetchClassParticipants(exam.classId);
		}else {
			Connection conn = DBManager.getDBManager().getConnection();
			try {
				PreparedStatement stmt = 
						conn.prepareStatement("SELECT * FROM users AS U JOIN exam_registrations AS R "
								+ "WHERE U.id=R.student_id AND R.exam_id=?");
				stmt.setInt(1, exam.id);
				ResultSet rs = stmt.executeQuery();
				while(rs.next()) {
					int id = rs.getInt("id");
					Role role;
					String roleString = rs.getString("role");
					if("admin".equals(roleString)) {
						role = Role.ADMIN;
					}else if("teacher".equals(roleString)) {
						role = Role.TEACHER;
					}else if("student".equals(roleString)) {
						role = Role.STUDENT;
					}else {
						role = Role.STUDENT;
					}
					String username = rs.getString("username");
					String fname = rs.getString("fname");
					String lname = rs.getString("lname");
					String cellphone = rs.getString("cellphone");
					String email_addr = rs.getString("email_addr");
					String national_code = rs.getString("national_code");
					String student_id = rs.getString("student_id");
					String photoName = rs.getString("photo_name");
					String photoName2 = rs.getString("photo_name2");

					participants.add(new User(id, role, username, fname, lname, 
							cellphone, email_addr, national_code, student_id, photoName, photoName2));
				}
				stmt.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return participants;
		}
	}
	
	public static boolean isRegisterredInExam(Exam exam, User student) {
		if(exam == null || student == null) {
			return false;
		}
		boolean found = false;
		Connection conn = DBManager.getDBManager().getConnection();
		PreparedStatement stmt;
		try {
			stmt = conn.prepareStatement("SELECT * FROM exam_registrations WHERE exam_id=? AND student_id=?;");
			stmt.setInt(1, exam.id);
			stmt.setInt(2, student.id);
			ResultSet rs = stmt.executeQuery();
			if(rs.next()) {
				found = true;
			}
			rs.close();
			stmt.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return found;
	}
	
	public static void registerInExam(Exam exam, User student) {
		if(exam == null || student == null) {
			return;
		}
		if(isRegisterredInExam(exam, student)) {
			return;
		}
		Connection conn = DBManager.getDBManager().getConnection();
		PreparedStatement stmt;
		try {
			stmt = conn.prepareStatement("INSERT INTO exam_registrations (exam_id, student_id)"
					+ " VALUE (?,?);");
			stmt.setInt(1, exam.id);
			stmt.setInt(2, student.id);
			stmt.executeUpdate();
			stmt.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return;
	}
	
	public static void removeExamRegistration(Exam exam, User student) {
		if(exam == null || student == null) {
			return;
		}
		if(! isRegisterredInExam(exam, student)) {
			return;
		}
		Connection conn = DBManager.getDBManager().getConnection();
		PreparedStatement stmt;
		try {
			stmt = conn.prepareStatement("DELETE FROM exam_registrations WHERE exam_id=? AND student_id=?;");
			stmt.setInt(1, exam.id);
			stmt.setInt(2, student.id);
			stmt.executeUpdate();
			stmt.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return;
	}
}
