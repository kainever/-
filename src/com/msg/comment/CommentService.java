package com.msg.comment;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.sql.Types;

import com.msg.util.DB;



public class CommentService {
	private static CommentService service;
	
	private CommentService() {}
	
	public static CommentService getInstance() {
		if(service == null) {
			service = new CommentService();
		}
		return service;
	}
	
//	status comment user content create_time puser
	public int insert(Comment com) {
		Connection conn = DB.getConn();
		String s = "insert into comment values(null , ? , ? ,?,?,?,?)";
		PreparedStatement pst = DB.prepare(conn, s);
		int id = 0;
//		1 1 193 6
/*System.out.println(com.getUser().getId() + " " + com.getStatus().getId() + " "
		+ com.getComment().getId() + " " + com.getpUser().getId());*/
		try {
			pst.setInt(1, com.getStatus().getId());
			if(com.getComment() != null)
				pst.setInt(2, com.getComment().getId());
			else 
				pst.setInt(2, com.getStatus().getId());
			pst.setInt(3, com.getUser().getId());
			pst.setString(4, com.getContent());
			pst.setTimestamp(5, new Timestamp(new java.util.Date().getTime()));
			if(com.getpUser() != null)
				pst.setInt(6, com.getpUser().getId());
			else 
				pst.setNull(6, Types.INTEGER);
			pst.execute();
			Statement stmt = DB.getStatement(conn);
			ResultSet rs = stmt.executeQuery("select last_insert_id()");
			rs.next();
			id = rs.getInt(1);
			DB.close(rs);
			DB.close(stmt);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(pst);
			DB.close(conn);
		}
		return id;
	}
	
	
	public static void main(String[] args) {
//		CommentService cs = new CommentService();
//		int id = cs.insert(com);
	}
}
