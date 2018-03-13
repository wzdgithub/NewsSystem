package com.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class SimpleJDBCUtil {
	private static List<Connection> connPool;
	static{
		try {
			connPool = new ArrayList<Connection>();
			Class.forName("com.mysql.jdbc.Driver");
			for(int i = 0;i < 20;i++){
				Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/db_phoneshop", "root", "");
				connPool.add(conn);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	public static Connection getConnection() throws Exception{
		if(connPool.size() == 0){
			for(int i = 0;i < 20;i++){
				Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/newsmanage", "root", "");
				connPool.add(conn);
			}
		}
		return connPool.remove(0);
	}
	public static void putConnection(Connection conn) throws Exception{
		if(connPool.size() < 20)
			connPool.add(conn);
		else
			conn.close();
	}

	public static ResultSet executQuery(String sql,Object[] objects) throws Exception{

		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		for(int i=0;i<objects.length;i++) {
			pstmt.setObject(i + 1, objects[i]);
		}
		ResultSet resultSet = pstmt.executeQuery();
		putConnection(conn);
		return resultSet;
	}
	public static int executUpdate(String sql,Object[] objects) throws Exception{
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		for(int i=0;i<objects.length;i++)
			pstmt.setObject(i+1, objects[i]);
		int n = pstmt.executeUpdate();
		putConnection(conn);
		return n;
	}
}
