package com.msg.notification;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.msg.status.Status;
import com.msg.user.User;
import com.msg.util.DB;

public class NoticeService {

	public static void main(String[] args) {
		// TODO Auto-generated method stub

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

}
