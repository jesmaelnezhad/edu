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
public class Content {
	public int id ;
	public String content;
	
	public Content(int id, String content) {
		this.id = id;
		this.content = content;
	}

	public static Content saveNewContent(String content_) {
		
		Content content = null;
		
		Connection conn = DBManager.getDBManager().getConnection();
		try {
			PreparedStatement stmt = conn.prepareStatement("INSERT INTO contents (content) "
					+ "VALUE (?);", Statement.RETURN_GENERATED_KEYS);
			stmt.setString(1, content_);
			stmt.executeUpdate();
			ResultSet rs = stmt.getGeneratedKeys();
			if(rs.next()) {
				int id = rs.getInt(1);
				content = new Content(id, content_);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return content;
	}
	
	public static List<Content> fetchAllContents(){
		List<Content> contentsList = new ArrayList<>();
		
		Connection conn = DBManager.getDBManager().getConnection();
		try {
			PreparedStatement stmt = conn.prepareStatement("SELECT * FROM contents;");

			ResultSet rs = stmt.executeQuery();
			while(rs.next()) {
				int id = rs.getInt("id");
				String content = rs.getString("content");
				contentsList.add(new Content(id, content));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return contentsList;
	}
	
	public static Content fetchContent(int id){
		Content result = null;
		
		Connection conn = DBManager.getDBManager().getConnection();
		try {
			PreparedStatement stmt = conn.prepareStatement("SELECT * FROM contents WHERE id=?;");
			stmt.setInt(1, id);
			ResultSet rs = stmt.executeQuery();
			if(rs.next()) {
				String content = rs.getString("content");
				result = new Content(id, content);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}
	
	public static void deleteContent(int id) {
		Connection conn = DBManager.getDBManager().getConnection();
		PreparedStatement stmt;
		try {
			stmt = conn.prepareStatement("DELETE FROM contents WHERE id=?;");
			stmt.setInt(1, id);
			stmt.executeUpdate();
			stmt.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public static void updateContent(Content content) {
		Connection conn = DBManager.getDBManager().getConnection();
		PreparedStatement stmt;
		try {
			stmt = conn.prepareStatement("UPDATE contents SET content=? WHERE id=?;");
			stmt.setString(1, content.content);
			stmt.setInt(2, content.id);
			stmt.executeUpdate();
			stmt.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
