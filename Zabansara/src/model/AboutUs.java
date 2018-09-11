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
public class AboutUs {
	public int id ;
	public String menu_item;
	public String photoName;
	
	public AboutUs(int id, String menu_item, String photoName) {
		this.id = id;
		this.menu_item = menu_item;
		this.photoName = photoName;
	}

	public static AboutUs saveAboutUs(String menu_item, String photoName) {
		
		AboutUs aboutus = null;
		
		Connection conn = DBManager.getDBManager().getConnection();
		try {
			PreparedStatement stmt = conn.prepareStatement("INSERT INTO aboutus (menu_item, photo_name) "
					+ "VALUE (?, ?);", Statement.RETURN_GENERATED_KEYS);
			stmt.setString(1, menu_item);
			stmt.setString(2, photoName);
			stmt.executeUpdate();
			ResultSet rs = stmt.getGeneratedKeys();
			if(rs.next()) {
				int id = rs.getInt(1);
				aboutus = new AboutUs(id, menu_item, photoName);
			}
			rs.close();
			stmt.close();
			DBManager.getDBManager().closeConnection();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return aboutus;
	}
	
	public static List<AboutUs> fetchAllAboutUs(){
		List<AboutUs> aboutusList = new ArrayList<>();
		
		Connection conn = DBManager.getDBManager().getConnection();
		try {
			PreparedStatement stmt = conn.prepareStatement("SELECT * FROM aboutus;");

			ResultSet rs = stmt.executeQuery();
			while(rs.next()) {
				int id = rs.getInt("id");
				String menu_item = rs.getString("menu_item");
				String photoName = rs.getString("photo_name");
				aboutusList.add(new AboutUs(id, menu_item, photoName));
			}
			rs.close();
			stmt.close();
			DBManager.getDBManager().closeConnection();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return aboutusList;
	}
	
	public static AboutUs fetchAboutUs(int id){
		AboutUs result = null;
		
		Connection conn = DBManager.getDBManager().getConnection();
		try {
			PreparedStatement stmt = conn.prepareStatement("SELECT * FROM aboutus WHERE id=?;");
			stmt.setInt(1, id);
			ResultSet rs = stmt.executeQuery();
			if(rs.next()) {
				String menu_item = rs.getString("menu_item");
				String photoName = rs.getString("photo_name");
				result = new AboutUs(id, menu_item, photoName);
			}
			rs.close();
			stmt.close();
			DBManager.getDBManager().closeConnection();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}
	
	public static void deleteAboutUs(int id) {
		Connection conn = DBManager.getDBManager().getConnection();
		PreparedStatement stmt;
		try {
			stmt = conn.prepareStatement("DELETE FROM aboutus WHERE id=?;");
			stmt.setInt(1, id);
			stmt.executeUpdate();
			stmt.close();
			DBManager.getDBManager().closeConnection();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public static void updateAboutUs(AboutUs aboutus) {
		Connection conn = DBManager.getDBManager().getConnection();
		PreparedStatement stmt;
		try {
			stmt = conn.prepareStatement("UPDATE aboutus SET menu_item=?, photo_name=? WHERE id=?;");
			stmt.setString(1, aboutus.menu_item);
			stmt.setString(2, aboutus.photoName);
			stmt.setInt(3, aboutus.id);
			stmt.executeUpdate();
			stmt.close();
			DBManager.getDBManager().closeConnection();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
