package com.msg.notification;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.msg.status.Status;
import com.msg.status.StatusService;
import com.msg.user.User;
import com.msg.util.DB;

public class NoticeService {

	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}
	
	

	private static NoticeService service;
	
	private NoticeService() {}
	
	public static NoticeService getInstance() {
		if(service == null) {
			service = new NoticeService();
		}
		return service;
	}
	
	public static void insert(User u , Status s) {
		Connection conn = DB.getConn();
		String sql = "insert into status_notice values(?,?,?,?)";
		PreparedStatement pst = DB.prepare(conn, sql);
		try {
			pst.setInt(1, u.getId());
			pst.setInt(2, s.getId());
			pst.setBoolean(3, false);
			pst.setTimestamp(4, s.getCreateTime());
			pst.execute();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(pst);
			DB.close(conn);
		}
	}
	
	
	/**
	 * 计算状态数目
	 * @param user
	 * @return
	 */
	public int countStatus(User user) {
		Connection conn = DB.getConn();
		String sql = "select count(*) from status_notice "
				+ "where user_id = " + user.getId() +";";
		Statement stmt = DB.getStatement(conn);
		ResultSet rs = DB.getResultSet(stmt, sql);
		int count = 0;
		try {
			if(!rs.next()) {
				System.out.println("统计状态数目出错...");
			} else {
				count = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return count;
	}

}
