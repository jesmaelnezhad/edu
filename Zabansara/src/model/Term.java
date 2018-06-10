/**
 * 
 */
package model;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.Part;

import db_handlers.DBManager;

/**
 * @author jam
 *
 */
public class Term {
	public int id ;
	public String title;
	public String termStart;
	public String classesStart;
	public String finalsStart;
	public String termEnd;
	
	public Term(int id, String title, String termStart, 
			String classesStart, String finalsStart, String termEnd) {
		this.id = id;
		this.title = title;
		this.termStart = termStart;
		this.classesStart = classesStart;
		this.finalsStart = finalsStart;
		this.termEnd = termEnd;
	}

	public static Term addTerm(String title, String termStart, 
			String classesStart, String finalsStart, String termEnd) {
		
		Term news = null;
		
		Connection conn = DBManager.getDBManager().getConnection();
		try {
			PreparedStatement stmt = conn.prepareStatement("INSERT INTO terms (title, term_start, classes_start, finals_start, term_end) "
					+ "VALUE (?, ?, ?, ?, ?);", Statement.RETURN_GENERATED_KEYS);
			stmt.setString(1, title);
			stmt.setString(2, termStart);
			stmt.setString(3, classesStart);
			stmt.setString(4, finalsStart);
			stmt.setString(5, termEnd);
			stmt.executeUpdate();
			ResultSet rs = stmt.getGeneratedKeys();
			if(rs.next()) {
				int id = rs.getInt(1);
				news = new Term(id, title, termStart, classesStart, finalsStart, termEnd);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return news;
	}
	
	public static List<Term> fetchAllTerms(){
		List<Term> termsList = new ArrayList<>();
		
		Connection conn = DBManager.getDBManager().getConnection();
		try {
			PreparedStatement stmt = conn.prepareStatement("SELECT * FROM terms;");

			ResultSet rs = stmt.executeQuery();
			while(rs.next()) {
				int id = rs.getInt("id");
				String title = rs.getString("title");
				String termStart = rs.getString("term_start");
				String classesStart = rs.getString("classes_start");
				String finalsStart = rs.getString("finals_start");
				String termEnd = rs.getString("term_end");
				termsList.add(new Term(id, title, termStart, classesStart, finalsStart, termEnd));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return termsList;
	}
	
	public static Term fetchTerm(int id){
		Term term =null;
		
		Connection conn = DBManager.getDBManager().getConnection();
		try {
			PreparedStatement stmt = conn.prepareStatement("SELECT * FROM terms WHERE id="+id+";");

			ResultSet rs = stmt.executeQuery();
			if(rs.next()) {
				String title = rs.getString("title");
				String termStart = rs.getString("term_start");
				String classesStart = rs.getString("classes_start");
				String finalsStart = rs.getString("finals_start");
				String termEnd = rs.getString("term_end");
				term = new Term(id, title, termStart, classesStart, finalsStart, termEnd);
			}
			rs.close();
			stmt.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return term;
	}
	
	public static boolean isTeacherAvailable(int termId, int teacherId, int scheduleId){
		
		boolean result = false;
		
		Connection conn = DBManager.getDBManager().getConnection();
		try {
			PreparedStatement stmt = 
					conn.prepareStatement("SELECT * FROM availabilities "
							+ "WHERE term_id=? AND "
									+ "teacher_id=? AND "
											+ "schedule_id=?;");
			stmt.setInt(1, termId);
			stmt.setInt(2, teacherId);
			stmt.setInt(3, scheduleId);
			ResultSet rs = stmt.executeQuery();
			if(rs.next()) {
				result = true;
			}
			rs.close();
			stmt.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}
	
	public static void setTeacherAvailablity(int termId, int teacherId, int scheduleId, boolean availability){
		if(Term.isTeacherAvailable(termId, teacherId, scheduleId) == availability) {
			return;
		}
		Connection conn = DBManager.getDBManager().getConnection();
		try {
			PreparedStatement stmt ;
			if(availability) {
				stmt = conn.prepareStatement("INSERT INTO availabilities (term_id, teacher_id, schedule_id) "
								+ "VALUE (?, ?, ?)");
				stmt.setInt(1, termId);
				stmt.setInt(2, teacherId);
				stmt.setInt(3, scheduleId);
			}else {
				stmt = conn.prepareStatement("DELETE FROM availabilities "
						+ "WHERE term_id=? AND "
						+ "teacher_id=? AND "
						+ "schedule_id=?;");
				stmt.setInt(1, termId);
				stmt.setInt(2, teacherId);
				stmt.setInt(3, scheduleId);
			}
			stmt.executeUpdate();
			stmt.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return;
	}
	
	// returns all schedules if scheduleId is zero.
	public static List<User> fetchAvailableTeachers(int termId, int scheduleId){
		List<User> availableTeachers = new ArrayList<>();
		Connection conn = DBManager.getDBManager().getConnection();
		try {
			PreparedStatement stmt ;
			if(scheduleId == 0) {
				stmt = conn.prepareStatement("SELECT * FROM availabilities "
						+ "WHERE term_id=?;");
			}else {
				stmt = conn.prepareStatement("SELECT * FROM availabilities "
						+ "WHERE term_id=? AND "
						+ "schedule_id=?;");
			}
			stmt.setInt(1, termId);
			stmt.setInt(2, scheduleId);
			ResultSet rs = stmt.executeQuery();
			while(rs.next()) {
				int teacherId = rs.getInt("teacher_id");
				User teacher = User.fetchUser(teacherId);
				availableTeachers.add(teacher);
			}
			rs.close();
			stmt.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return availableTeachers;
	}
}
