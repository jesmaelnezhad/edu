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

import com.sun.org.apache.bcel.internal.generic.Select;

import db_handlers.DBManager;

/**
 * @author jam
 *
 */
public class TermClass {
	public int id ;
	public int termId;
	public int teacherId;
	public Gender gender;
	public int levelId;
	public int scheduleId;
	public int size;
	public String note;
	public String content;
	
	public TermClass(int id, int termId, int teacherId, Gender gender, 
			int levelId, int scheduleId, int size, String note, String content) {
		this.id = id;
		this.termId = termId;
		this.teacherId = teacherId;
		this.gender = gender;
		this.levelId = levelId;
		this.scheduleId = scheduleId;
		this.size = size;
		this.note = note;
		this.content = content;
	}

	public static TermClass addClass(int termId, int teacherId, 
			Gender gender, int levelId, int scheduleId, int size, String notes) {
		
		TermClass newClass = null;
		
		Connection conn = DBManager.getDBManager().getConnection();
		try {
			PreparedStatement stmt = conn.prepareStatement("INSERT INTO classes (term_id, teacher_id, gender, level_id, schedule_id, notes, content, size) "
					+ "VALUE (?, ?, ?, ?, ?, ?, ?, ?);", Statement.RETURN_GENERATED_KEYS);
			stmt.setInt(1, termId);
			stmt.setInt(2, teacherId);
			String genderString = "";
			switch (gender) {
			case BOYS:
				genderString="boys";
				break;
			case GIRLS:
				genderString="girls";
				break;
			case BOTH:
				genderString="both";
				break;
			}
			stmt.setString(3, genderString);
			stmt.setInt(4, levelId);
			stmt.setInt(5, scheduleId);
			stmt.setString(6, notes);
			stmt.setString(7, "");
			stmt.setInt(8, size);
			stmt.executeUpdate();
			ResultSet rs = stmt.getGeneratedKeys();
			if(rs.next()) {
				int id = rs.getInt(1);
				newClass = new TermClass(id, termId, teacherId, gender, levelId, scheduleId, size, notes, "");
			}
			rs.close();
			stmt.close();
			DBManager.getDBManager().closeConnection();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return newClass;
	}
	
	public static void removeClass(int id) {
		Connection conn = DBManager.getDBManager().getConnection();
		try {
			PreparedStatement stmt = conn.prepareStatement("DELETE FROM classes WHERE id=?");
			stmt.setInt(1, id);
			stmt.executeUpdate();
			stmt.close();
			DBManager.getDBManager().closeConnection();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public static List<TermClass> fetchAllClasses(int termId){
		List<TermClass> classesList = new ArrayList<>();
		
		Connection conn = DBManager.getDBManager().getConnection();
		try {
			PreparedStatement stmt = conn.prepareStatement("SELECT * FROM classes WHERE term_id=?;");
			stmt.setInt(1, termId);
			ResultSet rs = stmt.executeQuery();
			while(rs.next()) {
				int id = rs.getInt("id");
				int teacherId = rs.getInt("teacher_id");
				String genderStr = rs.getString("gender");
				Gender gender = Gender.BOYS;
				if("boys".equals(genderStr)) {
					gender = Gender.BOYS;
				}else if("girls".equals(genderStr)) {
					gender = Gender.GIRLS;			
				}else {
					gender = Gender.BOTH;
				}
				int levelId = rs.getInt("level_id");
				int scheduleId = rs.getInt("schedule_id");
				int size = rs.getInt("size");
				String notes = rs.getString("notes");
				String content = rs.getString("content");
				classesList.add(new TermClass(id,termId, teacherId, gender, levelId, scheduleId, size, notes, content));
			}
			rs.close();
			stmt.close();
			DBManager.getDBManager().closeConnection();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return classesList;
	}
	
	public static List<TermClass> searchClasses(int scheduleId, int termId, int levelId, Gender gender){
		List<TermClass> classesList = new ArrayList<>();
		
		Connection conn = DBManager.getDBManager().getConnection();
		try {
			String sql = "SELECT * FROM classes WHERE schedule_id="+scheduleId;
			if(termId > 0) {
				sql += " AND term_id="+termId;
			}
			if(levelId > 0) {
				sql += " AND level_id="+levelId;
			}if(gender != null) {
				switch (gender) {
				case BOYS:
					sql += " AND gender='boys'";
					break;
				case GIRLS:
					sql += " AND gender='girls'";
					break;
				case BOTH:
					sql += " AND gender='both'";
					break;
				}
			}
			sql += ";";
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			while(rs.next()) {
				int id = rs.getInt("id");
				if(termId == 0) {
					termId = rs.getInt("term_id");
				}
				int teacherId = rs.getInt("teacher_id");
				if(gender == null) {
					String genderStr = rs.getString("gender");
					gender = Gender.BOYS;
					if("boys".equals(genderStr)) {
						gender = Gender.BOYS;
					}else if("girls".equals(genderStr)) {
						gender = Gender.GIRLS;			
					}else {
						gender = Gender.BOTH;
					}
				}
				if(levelId == 0) {
					levelId = rs.getInt("level_id");
				}
				int size = rs.getInt("size");
				String notes = rs.getString("notes");
				String content = rs.getString("content");
				classesList.add(new TermClass(id,termId, teacherId, gender, levelId, scheduleId, size, notes, content));
			}
			rs.close();
			stmt.close();
			DBManager.getDBManager().closeConnection();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return classesList;
	}
	
	public static List<TermClass> fetchTeacherClasses(int termId, int teacherId){
		List<TermClass> classesList = new ArrayList<>();
		
		Connection conn = DBManager.getDBManager().getConnection();
		try {
			PreparedStatement stmt = conn.prepareStatement("SELECT * FROM classes WHERE term_id=? AND teacher_id=?;");
			stmt.setInt(1, termId);
			stmt.setInt(2, teacherId);
			ResultSet rs = stmt.executeQuery();
			while(rs.next()) {
				int id = rs.getInt("id");
				String genderStr = rs.getString("gender");
				Gender gender = Gender.BOYS;
				if("boys".equals(genderStr)) {
					gender = Gender.BOYS;
				}else if("girls".equals(genderStr)) {
					gender = Gender.GIRLS;			
				}else {
					gender = Gender.BOTH;
				}
				int levelId = rs.getInt("level_id");
				int scheduleId = rs.getInt("schedule_id");
				int size = rs.getInt("size");
				String notes = rs.getString("notes");
				String content = rs.getString("content");
				classesList.add(new TermClass(id,termId, teacherId, gender, levelId, scheduleId, size, notes, content));
			}
			rs.close();
			stmt.close();
			DBManager.getDBManager().closeConnection();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return classesList;
	}
	
	public static List<TermClass> fetchStudentClasses(int termId, int studentId){
		List<TermClass> classesList = new ArrayList<>();
		
		Connection conn = DBManager.getDBManager().getConnection();
		try {
			PreparedStatement stmt = 
					conn.prepareStatement("select * from "
							+ "classes AS C JOIN registrations AS R "
							+ "WHERE C.term_id=? AND R.class_id=C.id AND R.student_id=?;");
			stmt.setInt(1, termId);
			stmt.setInt(2, studentId);
			ResultSet rs = stmt.executeQuery();
			while(rs.next()) {
				int id = rs.getInt("id");
				int teacherId = rs.getInt("teacher_id");
				String genderStr = rs.getString("gender");
				Gender gender = Gender.BOYS;
				if("boys".equals(genderStr)) {
					gender = Gender.BOYS;
				}else if("girls".equals(genderStr)) {
					gender = Gender.GIRLS;			
				}else {
					gender = Gender.BOTH;
				}
				int levelId = rs.getInt("level_id");
				int scheduleId = rs.getInt("schedule_id");
				String notes = rs.getString("notes");
				String content = rs.getString("content");
				int size = rs.getInt("size");
				classesList.add(new TermClass(id,termId, teacherId, gender, levelId, scheduleId, size, notes, content));
			}
			rs.close();
			stmt.close();
			DBManager.getDBManager().closeConnection();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return classesList;
	}
	
	
	public static TermClass fetchClass(int classId){
		TermClass fetchedClass = null;
		
		Connection conn = DBManager.getDBManager().getConnection();
		try {
			PreparedStatement stmt = conn.prepareStatement("SELECT * FROM classes WHERE id=?;");
			stmt.setInt(1, classId);
			ResultSet rs = stmt.executeQuery();
			if(rs.next()) {
				int id = rs.getInt("id");
				int termId = rs.getInt("term_id");
				int teacherId = rs.getInt("teacher_id");
				String genderStr = rs.getString("gender");
				Gender gender = Gender.BOYS;
				if("boys".equals(genderStr)) {
					gender = Gender.BOYS;
				}else if("girls".equals(genderStr)) {
					gender = Gender.GIRLS;			
				}else {
					gender = Gender.BOTH;
				}
				int levelId = rs.getInt("level_id");
				int scheduleId = rs.getInt("schedule_id");
				int size = rs.getInt("size");
				String notes = rs.getString("notes");
				String content = rs.getString("content");
				fetchedClass = new TermClass(id,termId, teacherId, gender, levelId, scheduleId, size, notes, content);
			}
			rs.close();
			stmt.close();
			DBManager.getDBManager().closeConnection();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return fetchedClass;
	}
	
	// 0 : success
	// 1 : failure
	// 2 : registerred already
	public static int registerInClass(User user, int classId) {
		if(user == null) {
			return 1;
		}
		if(isRegisterred(user.id, classId)) {
			return 2;
		}
		boolean inserted = false;
		Connection conn = DBManager.getDBManager().getConnection();
		try {
			PreparedStatement stmt = 
					conn.prepareStatement("INSERT INTO registrations (student_id, class_id) "
							+ "VALUE (?,?);", Statement.RETURN_GENERATED_KEYS);
			stmt.setInt(1, user.id);
			stmt.setInt(2, classId);
			stmt.executeUpdate();
			inserted = true;
			stmt.close();
			DBManager.getDBManager().closeConnection();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if(inserted) {
			return 0;
		}else {
			return 1;
		}
	}
	

	public static void removeFromClass(User user, int classId) {
		if(user == null) {
			return;
		}
		if(! isRegisterred(user.id, classId)) {
			return;
		}
		Connection conn = DBManager.getDBManager().getConnection();
		try {
			PreparedStatement stmt = 
					conn.prepareStatement("DELETE FROM registrations WHERE student_id=? AND class_id=?;");
			stmt.setInt(1, user.id);
			stmt.setInt(2, classId);
			stmt.executeUpdate();
			stmt.close();
			DBManager.getDBManager().closeConnection();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public static List<User> fetchClassParticipants(int classId) {
		List<User> participants = new ArrayList<>();

		Connection conn = DBManager.getDBManager().getConnection();
		try {
			PreparedStatement stmt = 
					conn.prepareStatement("SELECT * FROM users AS U JOIN registrations AS R "
							+ "WHERE U.id=R.student_id AND R.class_id=?");
			stmt.setInt(1, classId);
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
			rs.close();
			stmt.close();
			DBManager.getDBManager().closeConnection();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return participants;
	}
	
	public static boolean isRegisterred(int studentId, int classId) {
		boolean found = false;
		
		Connection conn = DBManager.getDBManager().getConnection();
		try {
			PreparedStatement stmt = conn.prepareStatement("SELECT * FROM registrations WHERE student_id=? AND class_id=?;");
			stmt.setInt(1, studentId);
			stmt.setInt(2, classId);
			ResultSet rs = stmt.executeQuery();
			if(rs.next()) {
				found = true;
			}
			rs.close();
			stmt.close();
			DBManager.getDBManager().closeConnection();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return found;
	}
	
	public static boolean isClassFull(int classId) {
		TermClass classObj = TermClass.fetchClass(classId);
		if(classObj == null) {
			return false;
		}
		int registerred = TermClass.getClassSize(classId);
		return registerred == classObj.size;
	}
	
	public static int getClassSize(int classId) {
		int classSize = -1;
		Connection conn = DBManager.getDBManager().getConnection();
		PreparedStatement stmt;
		try {
			stmt = conn.prepareStatement("SELECT count(*) AS total FROM registrations WHERE class_id=?;");
			stmt.setInt(1, classId);
			ResultSet rs = stmt.executeQuery();
			if(rs.next()) {
				classSize = rs.getInt("total");
			}
			rs.close();
			stmt.close();
			DBManager.getDBManager().closeConnection();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if(classSize == -1) {
			return 0;
		}
		return classSize;
	}
	
	public static boolean updateContent(int classId, String content) {
		Connection conn = DBManager.getDBManager().getConnection();
		PreparedStatement stmt;
		try {
			stmt = conn.prepareStatement("UPDATE classes SET content=? WHERE id=?;");
			stmt.setString(1, content);
			stmt.setInt(2, classId);
			stmt.executeUpdate();
			stmt.close();
			DBManager.getDBManager().closeConnection();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}
		return true;
	}
	
}
