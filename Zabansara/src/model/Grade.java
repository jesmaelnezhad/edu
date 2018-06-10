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
public class Grade {
	public int studentId;
	public String grade;
	public String notes;
	
	public Grade(int studentId, String grade, String notes) {
		this.studentId = studentId;
		this.grade = grade;
		this.notes = notes;
	}

//	public static List<Grade> fetchExamGrades(int examId){
//		List<Grade> grades = new ArrayList<>();
//		Connection conn = DBManager.getDBManager().getConnection();
//		PreparedStatement stmt;
//		try {
//			stmt = conn.prepareStatement("SELECT * FROM grades WHERE exam_id=?;");
//			stmt.setInt(1, examId);
//			ResultSet rs = stmt.executeQuery();
//			while(rs.next()) {
//				int studentId = rs.getInt("student_id");
//				String grade = rs.getString("grade");
//				String notes = rs.getString("notes");
//				grades.add(new Grade(studentId, grade, notes==null?"":notes));
//			}
//			stmt.close();
//		} catch (SQLException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//		return grades;
//	}
	
	public static Grade fetchExamGrade(int examId, int studentId){
		Grade grade = null;
		Connection conn = DBManager.getDBManager().getConnection();
		PreparedStatement stmt;
		try {
			stmt = conn.prepareStatement("SELECT * FROM grades WHERE exam_id=? AND student_id=?;");
			stmt.setInt(1, examId);
			stmt.setInt(2, studentId);
			ResultSet rs = stmt.executeQuery();
			while(rs.next()) {
				String gradeVal = rs.getString("grade");
				String notes = rs.getString("notes");
				grade = new Grade(studentId, gradeVal, notes==null?"":notes);
			}
			stmt.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return grade;
	}
	
	public static void updateOrInsertExamGrade(int examId, Grade newGrade){
		if(newGrade == null) {
			return;
		}
		
		Connection conn = DBManager.getDBManager().getConnection();
		PreparedStatement stmt;
		try {
			Grade currentGrade = fetchExamGrade(examId, newGrade.studentId);
			if(currentGrade == null) {
				// insert
				stmt = conn.prepareStatement("INSERT INTO grades (exam_id, student_id, grade, notes) "
						+ "VALUE (?,?,?,?);");
				stmt.setInt(1, examId);
				stmt.setInt(2, newGrade.studentId);
				stmt.setString(3, newGrade.grade);
				stmt.setString(4, newGrade.notes);	
			}else {
				// update
				stmt = conn.prepareStatement("UPDATE grades SET grade=?, notes=? WHERE "
						+ "exam_id=? AND student_id=?");
				stmt.setString(1, newGrade.grade);
				stmt.setString(2, newGrade.notes);	
				stmt.setInt(3, examId);
				stmt.setInt(4, newGrade.studentId);
			}

			stmt.executeUpdate();
			stmt.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
}
