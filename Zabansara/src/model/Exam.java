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
				int classId = rs.getInt("class_id");
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
		default:
			return "general";
		}
	}
	
	public static List<User> fetchExamParticipants(Exam exam){
		List<User> ids = new ArrayList<>();
		if(exam == null) {
			return ids;
		}
		if(exam.isClassExam()) {
			return TermClass.fetchClassParticipants(exam.classId);
		}else {
			//TODO : for general exams
		}
		
		return null;
	}
}
