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
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return newsList;
	}
}
