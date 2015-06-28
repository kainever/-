package com.msg.notification;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.msg.status.Status;
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
	
	public static void insert(User u , Status s , boolean isMsg) {
		Connection conn = DB.getConn();
		String sql = "insert into status_notice values(?,?,?,?)";
		PreparedStatement pst = DB.prepare(conn, sql);
		try {
			pst.setInt(1, u.getId());
			pst.setInt(2, s.getId());
			pst.setBoolean(3, isMsg);
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
	public int countStatus(User user , boolean isMsg) {
		Connection conn = DB.getConn();
		String sql = "select count(*) from status_notice where isMsg= ?"
				+ " and user_id = ?";
		PreparedStatement pst = DB.prepare(conn, sql);
		
		ResultSet rs = null;
		int count = 0;
		try {
			pst.setBoolean(1, isMsg);
			pst.setInt(2, user.getId());
			rs  = pst.executeQuery();
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
