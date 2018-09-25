/**
 * 
 */
package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import db_handlers.DBManager;

/**
 * @author jam
 *
 */
public class Order {
	public int id;
	public String refId;
	public long saleRefId;
	public int userId;
	public int price;
	public int resourceId ;
	public String type;


	public Order(int id, String ref_id, int userId, int price, int resourceId, String type, long saleRefId) {
		this.id = id;
		this.refId = ref_id;
		this.userId = userId;
		this.price = price;
		this.resourceId = resourceId;
		this.type = type;
		this.saleRefId = saleRefId;
	}

	public static Order addNewOrder(int userId, int price, int resourceId, String type) {
		Order order = null;
		Connection conn = DBManager.getDBManager().getConnection();
		PreparedStatement stmt;
		try {
			stmt = conn.prepareStatement("INSERT INTO orders "
					+ "(user_id, price, resource_id, type) VALUE (?,?,?,?);"
					, Statement.RETURN_GENERATED_KEYS);
			stmt.setInt(1, userId);
			stmt.setInt(2, price);
			stmt.setInt(3, resourceId);
			stmt.setString(4, type);
			stmt.executeUpdate();
			ResultSet rs = stmt.getGeneratedKeys();
			if(rs.next()) {
				int id = rs.getInt(1);
				order = new Order(id, null, userId, price, resourceId, type, 0);
			}
			rs.close();
			stmt.close();
			DBManager.getDBManager().closeConnection();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return order;	
	}
	
	public static void deleteOrder(int id) {
		Connection conn = DBManager.getDBManager().getConnection();
		PreparedStatement stmt;
		try {
			stmt = conn.prepareStatement("DELETE FROM orders WHERE id=?;");
			stmt.setInt(1, id);
			stmt.executeUpdate();
			stmt.close();
			DBManager.getDBManager().closeConnection();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public static void updateOrder(Order order) {
		Connection conn = DBManager.getDBManager().getConnection();
		PreparedStatement stmt;
		try {
			stmt = conn.prepareStatement("UPDATE users SET "
					+ "ref_id=?,sale_ref_id=?, user_id=?,price=?,resource_id=?,type=?"
					+ "WHERE id=?;");

			stmt.setString(1, order.refId);
			stmt.setLong(2, order.saleRefId);
			stmt.setInt(3, order.userId);
			stmt.setInt(4, order.price);
			stmt.setInt(5, order.resourceId);
			stmt.setString(6, order.type);
			stmt.executeUpdate();
			stmt.close();
			DBManager.getDBManager().closeConnection();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	

	
	public static Order fetchOrderById(int id) {
		
		Order order = null;
		
		Connection conn = DBManager.getDBManager().getConnection();
		PreparedStatement stmt;
		try {
			stmt = conn.prepareStatement("SELECT * FROM orders WHERE id=?;");
			stmt.setInt(1, id);
			ResultSet rs = stmt.executeQuery();
			if(rs.next()) {

				String RefId = rs.getString("ref_id");
				long saleRefId = rs.getLong("sale_ref_id");
				int userId = rs.getInt("user_id");
				int price = rs.getInt("price");
				int resourceId = rs.getInt("resource_id");
				String type = rs.getString("type");
				
				order = new Order(id, RefId, userId, price, resourceId, type, saleRefId);
			}
			rs.close();
			stmt.close();
			DBManager.getDBManager().closeConnection();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return order;
	}
	
}
	
