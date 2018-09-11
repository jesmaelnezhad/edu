/**
 * 
 */
package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import db_handlers.DBManager;
import utility.JalaliCalendar;

/**
 * @author jam
 *
 */
public class User {
	public int id;
	public Role role;
	public String username;
	public String fname, lname;
	public String cellphone_number;
	public String email_addr;
	public String national_code;
	public String student_id;
	public String photoName;
	public String photoName2;
	
	public User tempLogin = null;
	

	public User(int id, Role role,	String username, String fname, 
			String lname, String cellphone_number, String email_addr, String national_code, String student_id, String photoName, String photoName2) {
		this.id = id;
		this.role = role;
		this.username = username;
		this.fname = fname;
		this.lname = lname;
		this.cellphone_number = cellphone_number;
		this.email_addr = email_addr;
		this.national_code = national_code;
		this.student_id = student_id;
		this.photoName = photoName;
		this.photoName2 = photoName2;
	}
	
	// returns null if no user is currently signed in.
	public static User getCurrentUser(HttpSession session) {
		if(session.getAttribute("signedin-used") != null) {
			User loginUser = (User)session.getAttribute("signedin-used");
			if(loginUser.tempLogin != null) {
				return loginUser.tempLogin;
			}else {
				return loginUser;
			}
		}else {
			return null;
		}
	}
	
	public static boolean isCurrentUserSecondary(HttpSession session) {
		if(session.getAttribute("signedin-used") != null) {
			User loginUser = (User)session.getAttribute("signedin-used");
			if(loginUser.tempLogin != null) {
				return true;
			}else {
				return false;
			}
		}else {
			return false;
		}
	}
	public static void setSecondaryUser(HttpSession session, User user) {
		if(user == null) {
			return;
		}
		User loginUser = (User)session.getAttribute("signedin-used");
		if(loginUser == null) {
			return;
		}
		loginUser.tempLogin = user;
	}
	public static void removeSecondaryUser(HttpSession session) {
		User loginUser = (User)session.getAttribute("signedin-used");
		if(loginUser == null) {
			return;
		}
		loginUser.tempLogin = null;
	}
	public static void setCurrentUser(HttpSession session, User user) {
		if(user == null) {
			return;
		}
		session.setAttribute("signedin-used", user);
	}
	public static void removeCurrentUser(HttpSession session) {
		if(session.getAttribute("signedin-used") != null) {
			session.removeAttribute("signedin-used");
		}
	}

	public static User addNewUser(Role role, String username, String password, String fname, 
			String lname, String cellphone_number, String email_addr, 
			String national_code, String student_id, String photoName, String photoName2) {
		User user = null;
		Connection conn = DBManager.getDBManager().getConnection();
		PreparedStatement stmt;
		try {
			stmt = conn.prepareStatement("INSERT INTO users "
					+ "(role, username, password, fname, lname, "
					+ "cellphone, email_addr, national_code, student_id, "
					+ "photo_name, photo_name2) VALUE (?, ?, MD5(?), ?, ?, ?, ?, ?, ?, ?, ?);"
					, Statement.RETURN_GENERATED_KEYS);
			switch (role) {
			case ADMIN:
				stmt.setString(1, "admin");				
				break;
			case TEACHER:
				stmt.setString(1, "teacher");
				break;
			case STUDENT:
				stmt.setString(1, "student");
				break;
			default:
				break;
			}
			stmt.setString(2, username);
			stmt.setString(3, password);
			stmt.setString(4, fname);
			stmt.setString(5, lname);
			stmt.setString(6, cellphone_number);
			stmt.setString(7, email_addr);
			stmt.setString(8, national_code);
			stmt.setString(9, student_id);
			stmt.setString(10, photoName);
			stmt.setString(11, photoName2);
			stmt.executeUpdate();
			ResultSet rs = stmt.getGeneratedKeys();
			if(rs.next()) {
				int id = rs.getInt(1);
				user = new User(id, role, username, fname, 
						lname, cellphone_number, email_addr, 
						national_code, student_id, photoName, photoName2);
			}
			rs.close();
			stmt.close();
			DBManager.getDBManager().closeConnection();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return user;	
	}
	
	public static void deleteUser(int id) {
		Connection conn = DBManager.getDBManager().getConnection();
		PreparedStatement stmt;
		try {
			stmt = conn.prepareStatement("DELETE FROM users WHERE id=?;");
			stmt.setInt(1, id);
			stmt.executeUpdate();
			stmt.close();
			DBManager.getDBManager().closeConnection();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public static void updateUser(User user) {
		Connection conn = DBManager.getDBManager().getConnection();
		PreparedStatement stmt;
		try {
			stmt = conn.prepareStatement("UPDATE users SET "
					+ "role=?,fname=?,lname=?,cellphone=?,email_addr=?,"
					+ "national_code=?,photo_name=?, photo_name2=? WHERE id=?;");
			switch (user.role) {
			case STUDENT:
				stmt.setString(1, "student");
				break;
			case TEACHER:
				stmt.setString(1, "teacher");
				break;
			case ADMIN:
				stmt.setString(1, "admin");
				break;

			}
			stmt.setString(2, user.fname);
			stmt.setString(3, user.lname);
			stmt.setString(4, user.cellphone_number);
			stmt.setString(5, user.email_addr);
			stmt.setString(6, user.national_code);
			stmt.setString(7, user.photoName);
			stmt.setString(8, user.photoName2);
			stmt.setInt(9, user.id);
			stmt.executeUpdate();
			stmt.close();
			DBManager.getDBManager().closeConnection();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	
	public static void updatePassword(User user, String newPassword) {
		if(user == null) {
			return ;
		}
		Connection conn = DBManager.getDBManager().getConnection();
		PreparedStatement stmt;
		try {
			stmt = conn.prepareStatement("UPDATE users SET password=MD5(?) WHERE id=?;");
			stmt.setString(1, newPassword);
			stmt.setInt(2, user.id);
			stmt.executeUpdate();
			stmt.close();
			DBManager.getDBManager().closeConnection();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return;
	}
	
	public static List<User> fetchAllUsers(String fnameSearch, String lnameSearch) {
		if(fnameSearch == null) {
			fnameSearch = "";
		}
		if(lnameSearch == null) {
			lnameSearch = "";
		}
		List<User> users = new ArrayList<>();
		
		Connection conn = DBManager.getDBManager().getConnection();
		Statement stmt;
		try {
			String sql = "SELECT * FROM users";
			String sqlCondition = "";
			if("".equals(fnameSearch) && "".equals(lnameSearch)) {
				sql += ";";
			}else {
				sqlCondition += " WHERE";
				if(! "".equals(fnameSearch)) {
					sqlCondition += " fname LIKE '%"+fnameSearch+"%'";
				}
				if(! "".equals(lnameSearch)) {
					if(! "".equals(fnameSearch)) {
						sqlCondition += " AND ";
					}
					sqlCondition += " lname LIKE '%"+lnameSearch+"%'";
				}
				sql += sqlCondition + ";";
			}
			stmt = conn.createStatement();
//			System.out.println(sql);
			ResultSet rs = stmt.executeQuery(sql);
			while(rs.next()) {
				int id = rs.getInt("id");
				String username = rs.getString("username");
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
				String fname = rs.getString("fname");
				String lname = rs.getString("lname");
				String cellphone = rs.getString("cellphone");
				String email_addr = rs.getString("email_addr");
				String national_code = rs.getString("national_code");
				String student_id = rs.getString("student_id");
				String photoName = rs.getString("photo_name");
				String photoName2 = rs.getString("photo_name2");
				
				users.add(new User(id, role, username, fname, lname, 
						cellphone, email_addr, national_code, student_id, photoName, photoName2));
			}
			rs.close();
			stmt.close();
			DBManager.getDBManager().closeConnection();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return users;
	}
	
	public static String getNewUserID() {
		
		int usersCount = -1;
		Connection conn = DBManager.getDBManager().getConnection();
		PreparedStatement stmt;
		try {
			stmt = conn.prepareStatement("SELECT count(*) AS total FROM users;");
			ResultSet rs = stmt.executeQuery();
			if(rs.next()) {
				usersCount = rs.getInt("total");
			}
			rs.close();
			stmt.close();
			DBManager.getDBManager().closeConnection();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if(usersCount == -1) {
			return null;
		}
		
		LocalDate date = LocalDate.now(ZoneId.systemDefault());
		JalaliCalendar calendar = new JalaliCalendar();


//		System.out.println(((long)(calendar.getYear() - 1300) )* 10000000);
		
		return "" + (((long)(calendar.getYear() - 1300) )* 10000000 + usersCount + 1);
	}
	
	
	public static User fetchUser(String username, String password) {
		
		User user = null;
		
		Connection conn = DBManager.getDBManager().getConnection();
		PreparedStatement stmt;
		try {
			stmt = conn.prepareStatement("SELECT * FROM users WHERE username=? AND password=MD5(?);");
			stmt.setString(1, username);
			stmt.setString(2, password);
			ResultSet rs = stmt.executeQuery();
			if(rs.next()) {
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
				String fname = rs.getString("fname");
				String lname = rs.getString("lname");
				String cellphone = rs.getString("cellphone");
				String email_addr = rs.getString("email_addr");
				String national_code = rs.getString("national_code");
				String student_id = rs.getString("student_id");
				String photoName = rs.getString("photo_name");
				String photoName2 = rs.getString("photo_name2");
				
				user = new User(id, role, username, fname, lname, 
						cellphone, email_addr, national_code, student_id, photoName, photoName2);
			}
			rs.close();
			stmt.close();
			DBManager.getDBManager().closeConnection();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return user;
	}
	
	public static User fetchUser(String username) {
		
		User user = null;
		
		Connection conn = DBManager.getDBManager().getConnection();
		PreparedStatement stmt;
		try {
			stmt = conn.prepareStatement("SELECT * FROM users WHERE username=?;");
			stmt.setString(1, username);
			ResultSet rs = stmt.executeQuery();
			if(rs.next()) {
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
				String fname = rs.getString("fname");
				String lname = rs.getString("lname");
				String cellphone = rs.getString("cellphone");
				String email_addr = rs.getString("email_addr");
				String national_code = rs.getString("national_code");
				String student_id = rs.getString("student_id");
				String photoName = rs.getString("photo_name");
				String photoName2 = rs.getString("photo_name2");
				
				user = new User(id, role, username, fname, lname, 
						cellphone, email_addr, national_code, student_id, photoName, photoName2);
			}
			rs.close();
			stmt.close();
			DBManager.getDBManager().closeConnection();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return user;
	}
	public static User fetchUser(int id) {
		
		User user = null;
		
		Connection conn = DBManager.getDBManager().getConnection();
		PreparedStatement stmt;
		try {
			stmt = conn.prepareStatement("SELECT * FROM users WHERE id=?;");
			stmt.setInt(1, id);
			ResultSet rs = stmt.executeQuery();
			if(rs.next()) {
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
				
				user = new User(id, role, username, fname, lname, 
						cellphone, email_addr, national_code, student_id, photoName, photoName2);
			}
			rs.close();
			stmt.close();
			DBManager.getDBManager().closeConnection();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return user;
	}
}
