package com.data.generator;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Random;

import com.msg.user.User;
import com.msg.user.UserService;
import com.msg.util.DB;


public class DataGenerator {
	public static void main( String[] args) {
//		1
		saveBatchUser();
//		2
//		saveBatchStatus();
//		3 这一步前先插入friends
//		generateNotice();
		//4
//		generateComment();
		//5
//		generateSonComment();
	}
	
	public  static void saveBatchUser() {
		int row = 0;
		Connection conn = DB.getConn();
		try {
			String sql = "insert into user values(null,?,?,?,? , default,?,?)";
			PreparedStatement ps = conn.prepareStatement(sql);
			Random random = new Random();
			for (int i = 1; i <= 20; i++) {
				ps.setString(1, "admin" + i);
				ps.setString(2, "admin" + i + "@qq.com");
				ps.setString(3, "admin" + i);
				ps.setString(4, "head.jpg");
				ps.setBoolean(5, random.nextBoolean());
				ps.setTimestamp(6, new Timestamp(new Date().getTime()));
				ps.addBatch();
			}
			int[] rows = ps.executeBatch();
			ps.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	

//	生成状态
	public static void saveBatchStatus() {
		int row = 0;
		Connection conn = DB.getConn();
		Time[] times = Time.values();
		try {
			String sql = "insert into status values(null,?,?,?,? , ? ,null,?)";
			PreparedStatement ps = conn.prepareStatement(sql);
			Random random = new Random();
			for (int i = 1; i <= 50; i++) {
				int userId = random.nextInt(21);
				int dt = random.nextInt(8);
				if(userId < 1 || dt < 1) continue;
				ps.setInt(1, userId);
				ps.setTimestamp(2, times[dt].date);
				ps.setInt(3, random.nextInt(10));
				
				ps.setString(4,"今天天氣很好  " + i);
				ps.setInt(5, random.nextInt(10));
				ps.setInt(6, 0);
				
				ps.addBatch();
			}
			int[] rows = ps.executeBatch();
			ps.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
//	状态与好友挂钩
	public static void generateNotice() {
		Connection conn = DB.getConn();
		String sql = "select * from status";
		Statement stmt = DB.getStatement(conn);
		ResultSet rs = null;
		UserService us = UserService.getInstance();
		try {
			rs  = stmt.executeQuery(sql);
			while(rs.next()) {
				User u = new User();
				u.setId(rs.getInt("user_id"));
				us.getUserFriends(u);
				Timestamp time = rs.getTimestamp("create_time");
				int id = rs.getInt("id");
				HashSet fs = (HashSet) u.getFriends();
				Iterator it = fs.iterator();
				while(it.hasNext()) {
					User tu = (User) it.next();
					String s = "insert into status_notice values(?,?,default,?)";
					PreparedStatement pst = DB.prepare(conn, s);
					pst.setInt(1, tu.getId());
					pst.setInt(2, id);
					pst.setTimestamp(3, time);
					pst.execute();
					DB.close(pst);
				}
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	
	
	
	public static void generateComment() {
		Connection conn = DB.getConn();
		String sql = "select * from status";
		Statement stmt = DB.getStatement(conn);
		ResultSet rs = null;
		UserService us = UserService.getInstance();
		try {
			CommentTime[] ts = CommentTime.values();
			Random r = new Random();
;			rs  = stmt.executeQuery(sql);
			while(rs.next()) {
				int id = rs.getInt("id");
				int userId = rs.getInt("user_id");
				int items = r.nextInt(5);
				for(int i = 0 ; i < items; i++) {
					String s = "insert into comment values(null , ? , ? ,?,?,?,?)";
					int uId = r.nextInt(21);
					int tidx = r.nextInt(8);
					if(uId < 1) continue;
					PreparedStatement pst = DB.prepare(conn, s);
					pst.setInt(1, id);
					pst.setInt(2, id);
					pst.setInt(3, uId);
					pst.setString(4, "是的" + i);
					pst.setTimestamp(5, ts[tidx].date);
					pst.setInt(6, userId);
					pst.execute();
					DB.close(pst);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	
	public static void generateSonComment() {
		Connection conn = DB.getConn();
		String sql = "select * from comment";
		Statement stmt = DB.getStatement(conn);
		ResultSet rs = null;
		UserService us = UserService.getInstance();
		try {
			CommentTime[] ts = CommentTime.values();
			Random r = new Random();
;			rs  = stmt.executeQuery(sql);
			while(rs.next()) {
				int id = rs.getInt("id");
				int cuId = rs.getInt("user_id");
				Timestamp time = rs.getTimestamp("comment_time");
				int sid = rs.getInt("status_id");
				int items = r.nextInt(5);
				for(int i = 0 ; i < items; i++) {
					String s = "insert into comment values(null , ? , ? ,?,?,?,?)";
					int uId = r.nextInt(21);
					int tidx = r.nextInt(8);
					if(ts[tidx].date.compareTo(time) < 0)  continue;
					if(uId < 1) continue;
					PreparedStatement pst = DB.prepare(conn, s);
					pst.setInt(1, sid);
					pst.setInt(2, id);
					pst.setInt(3, uId);
					pst.setString(4, "的确" + i);
					pst.setTimestamp(5, ts[tidx].date);
					pst.setInt(6, cuId);
					pst.execute();
					DB.close(pst);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	
	
	
	static enum CommentTime {
		DATE1("2015-6-27 13:14:10"),
		DATE2("2015-6-27 12:55:50"),
		DATE3("2015-6-27 14:34:20"),
		DATE4("2015-6-27 15:44:50"),
		DATE5("2015-6-27 16:38:35"),
		DATE6("2015-5-27 17:18:14"),
		DATE7("2015-6-27 18:52:22"),
		DATE9("2015-6-27 09:45:12"),
		DATE8("2015-6-27 10:52:22");
		
		private Timestamp date;
		
		CommentTime(String date) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Date d = null;
			try {
				d = sdf.parse(date);
			} catch (ParseException e) {
				e.printStackTrace();
			}
			System.out.println(d);
			this.date = new Timestamp(d.getTime());
		}
	}
	
	
	static enum Time {
		DATE1("2015-6-26 13:14:10"),
		DATE2("2015-6-26 12:55:50"),
		DATE3("2015-6-26 14:34:20"),
		DATE4("2015-6-26 15:44:50"),
		DATE5("2015-6-26 16:38:35"),
		DATE6("2015-5-26 17:18:14"),
		DATE7("2015-6-25 18:52:22"),
		DATE9("2015-6-24 09:45:12"),
		DATE8("2015-6-23 10:52:22");
		
		private Timestamp date;
		
		Time(String date) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Date d = null;
			try {
				d = sdf.parse(date);
			} catch (ParseException e) {
				e.printStackTrace();
			}
			System.out.println(d);
			this.date = new Timestamp(d.getTime());
		}
	}
	
}
