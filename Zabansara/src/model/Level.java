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
public class Level {
	public int id ;
	public String title;
	
	public Level(int id, String title) {
		this.id = id;
		this.title = title;
	}

	public static Level addLevel(String title) {
		
		Level news = null;
		
		Connection conn = DBManager.getDBManager().getConnection();
		try {
			PreparedStatement stmt = conn.prepareStatement("INSERT INTO levels (title) "
					+ "VALUE (?);", Statement.RETURN_GENERATED_KEYS);
			stmt.setString(1, title);
			stmt.executeUpdate();
			ResultSet rs = stmt.getGeneratedKeys();
			if(rs.next()) {
				int id = rs.getInt(1);
				news = new Level(id, title);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return news;
	}
	
	public static void deleteLevel(int id) {
		Connection conn = DBManager.getDBManager().getConnection();
		PreparedStatement stmt;
		try {
			stmt = conn.prepareStatement("DELETE FROM levels WHERE id=?;");
			stmt.setInt(1, id);
			stmt.executeUpdate();
			stmt.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public static void updateLevel(Level level) {
		Connection conn = DBManager.getDBManager().getConnection();
		PreparedStatement stmt;
		try {
			stmt = conn.prepareStatement("UPDATE levels SET title=? WHERE id=?;");
			stmt.setString(1, level.title);
			stmt.setInt(2, level.id);
			stmt.executeUpdate();
			stmt.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public static List<Level> fetchAllLevels(){
		List<Level> levelsList = new ArrayList<>();
		
		Connection conn = DBManager.getDBManager().getConnection();
		try {
			PreparedStatement stmt = conn.prepareStatement("SELECT * FROM levels;");

			ResultSet rs = stmt.executeQuery();
			while(rs.next()) {
				int id = rs.getInt("id");
				String title = rs.getString("title");
				levelsList.add(new Level(id, title));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return levelsList;
	}
	
	public static Level fetchLevel(int levelId){
		Level level = null;
		
		Connection conn = DBManager.getDBManager().getConnection();
		try {
			PreparedStatement stmt = conn.prepareStatement("SELECT * FROM levels WHERE id=?;");
			stmt.setInt(1, levelId);
			ResultSet rs = stmt.executeQuery();
			while(rs.next()) {
				int id = rs.getInt("id");
				String title = rs.getString("title");
				level = new Level(id, title);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return level;
	}
}
