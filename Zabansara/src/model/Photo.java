/**
 * 
 */
package model;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.Part;

import db_handlers.DBManager;

/**
 * @author jam
 *
 */
public class Photo {
	public int id;
	public String photoName;
	public String photoCaption;
	public Photo(int id, String photoName, String photoCaption) {
		this.id = id;
		this.photoName = photoName;
		this.photoCaption = photoCaption;
	}
	
	public static Photo insertNewPhoto(String photoName, String photoCaption) {
		Photo photo = null;;
		Connection conn = DBManager.getDBManager().getConnection();
		PreparedStatement stmt;
		try {
			stmt = conn.prepareStatement("INSERT INTO photos "
					+ "(photo_name, caption) VALUE (?, ?);"
					, Statement.RETURN_GENERATED_KEYS);
			stmt.setString(1, photoName);
			stmt.setString(2, photoCaption);
			stmt.executeUpdate();
			ResultSet rs = stmt.getGeneratedKeys();
			if(rs.next()) {
				int id = rs.getInt(1);
				photo = new Photo(id, photoName, photoCaption);
			}
			rs.close();
			stmt.close();
			DBManager.getDBManager().closeConnection();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return photo;
	}
	
	public static void deletePhoto(int id) {
		Connection conn = DBManager.getDBManager().getConnection();
		PreparedStatement stmt;
		try {
			stmt = conn.prepareStatement("DELETE FROM photos WHERE id=?;");
			stmt.setInt(1, id);
			stmt.executeUpdate();
			stmt.close();
			DBManager.getDBManager().closeConnection();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public static List<Photo> fetchAllPhotos() {
		List<Photo> photos = new ArrayList<>();
		
		Connection conn = DBManager.getDBManager().getConnection();
		PreparedStatement stmt;
		try {
			stmt = conn.prepareStatement("SELECT * FROM photos ORDER BY id DESC;");
			ResultSet rs = stmt.executeQuery();
			while(rs.next()) {
				int id = rs.getInt("id");
				String photoName = rs.getString("photo_name");
				String caption = rs.getString("caption");
				photos.add(new Photo(id, photoName, caption));
			}
			rs.close();
			stmt.close();
			DBManager.getDBManager().closeConnection();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return photos;
	}
	
	
	public static void savePhoto(String group, int id, Part photoFile, ServletContext context) throws IOException {
		String photoName = photoFile.getSubmittedFileName();
		InputStream photoContent = photoFile.getInputStream();
	    byte[] buffer = new byte[photoContent.available()];
	    photoContent.read(buffer);
	    
//	    response.setContentType("text/html");
//	    response.setCharacterEncoding("UTF-8");
//	    PrintWriter out = response.getWriter();
//	    out.print("title : " + title + " content : " + newsContent);
	    String contextPath = context.getRealPath(File.separator);
	    File userImagesDir = new File(contextPath + "/"+group+"_images");
	    if(! userImagesDir.exists()) {
	    	userImagesDir.mkdir();
	    }
	    
	    File targetFile = new File(userImagesDir + "/" + id + "_" + photoName);
	    OutputStream outStream = new FileOutputStream(targetFile);
	    outStream.write(buffer);
	}
	
	public static String getPhotoPath(String group, int id, String photoName, ServletContext context) throws IOException {
		return "./"+group+"_images/" + "/" + id + "_" + photoName;
	}
}
