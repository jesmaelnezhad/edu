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
public class News {
	public int id ;
	public String title;
	public String content;
	public String photoName;
	
	public News(int id, String title, String content, String photoName) {
		this.id = id;
		this.title = title;
		this.content = content;
		this.photoName = photoName;
	}

	public static News saveNews(String title, String content, String photoName) {
		
		News news = null;
		
		Connection conn = DBManager.getDBManager().getConnection();
		try {
			PreparedStatement stmt = conn.prepareStatement("INSERT INTO news (title, content, photo_name) "
					+ "VALUE (?, ?, ?);", Statement.RETURN_GENERATED_KEYS);
			stmt.setString(1, title);
			stmt.setString(2, content);
			stmt.setString(3, photoName);
			stmt.executeUpdate();
			ResultSet rs = stmt.getGeneratedKeys();
			if(rs.next()) {
				int id = rs.getInt(1);
				news = new News(id, title, content, photoName);
			}
			rs.close();
			stmt.close();
			DBManager.getDBManager().closeConnection();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return news;
	}
	
	public static List<News> fetchAllNews(){
		List<News> newsList = new ArrayList<>();
		
		Connection conn = DBManager.getDBManager().getConnection();
		try {
			PreparedStatement stmt = conn.prepareStatement("SELECT * FROM news;");

			ResultSet rs = stmt.executeQuery();
			while(rs.next()) {
				int id = rs.getInt("id");
				String title = rs.getString("title");
				String content = rs.getString("content");
				String photoName = rs.getString("photo_name");
				newsList.add(new News(id, title, content, photoName));
			}
			rs.close();
			stmt.close();
			DBManager.getDBManager().closeConnection();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return newsList;
	}
	
	public static News fetchNews(int id){
		News result = null;
		
		Connection conn = DBManager.getDBManager().getConnection();
		try {
			PreparedStatement stmt = conn.prepareStatement("SELECT * FROM news WHERE id=?;");
			stmt.setInt(1, id);
			ResultSet rs = stmt.executeQuery();
			if(rs.next()) {
				String title = rs.getString("title");
				String content = rs.getString("content");
				String photoName = rs.getString("photo_name");
				result = new News(id, title, content, photoName);
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
	
	public static void deleteNews(int id) {
		Connection conn = DBManager.getDBManager().getConnection();
		PreparedStatement stmt;
		try {
			stmt = conn.prepareStatement("DELETE FROM news WHERE id=?;");
			stmt.setInt(1, id);
			stmt.executeUpdate();
			stmt.close();
			DBManager.getDBManager().closeConnection();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public static void updateNews(News news) {
		Connection conn = DBManager.getDBManager().getConnection();
		PreparedStatement stmt;
		try {
			stmt = conn.prepareStatement("UPDATE news SET title=?, content=?, photo_name=? WHERE id=?;");
			stmt.setString(1, news.title);
			stmt.setString(2, news.content);
			stmt.setString(3, news.photoName);
			stmt.setInt(4, news.id);
			stmt.executeUpdate();
			stmt.close();
			DBManager.getDBManager().closeConnection();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
