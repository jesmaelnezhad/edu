package db_handlers;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * @author jam
 *
 *	Singleton class used for maintaining db connection
 */
public class DBManager {
	private static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";  
	private static final String DB_URL="jdbc:mysql://localhost:3306/zabansara_db?useUnicode=yes&characterEncoding=utf-8";
	private static final String USER = "zabansara_admin";
	private static final String PASS = "zabansaraadminpassword";
	//
	private Connection conn = null;
	//
	private DBManager() {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			// Open a connection
			conn = DriverManager.getConnection(DB_URL, USER, PASS);
			Statement stmt = conn.createStatement();
			stmt.executeQuery("SET NAMES utf8");
			stmt.close();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public Connection getConnection() {
		if(conn == null) {
			try {
				Class.forName("com.mysql.jdbc.Driver");
				// Open a connection
				conn = DriverManager.getConnection(DB_URL, USER, PASS);
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return conn;
	}
	
	
	private static DBManager manager = null;;
	public static DBManager getDBManager() {
		if(manager == null) {
			manager = new DBManager();
		}
		return manager;
	}
	
	
}