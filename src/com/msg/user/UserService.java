package com.msg.user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.HashSet;

import com.msg.util.DB;


public class UserService {
	//静态变量 想想 我们只是要利用他来调用里面的方法... 
	private static UserService service;
	
	private UserService() {}
	
	public static UserService getInstance() {
		if(service == null) {
			service = new UserService();
		}
		return service;
	}
	
	/**
	 * 验证账号
	 * @param username
	 * @param password
	 * @return
	 * @throws UserNotFoundException
	 * @throws PasswordNotCorrectException
	 */
	public User check(String username, String password)
			throws UserNotFoundException, PasswordNotCorrectException {
		return check(username,password,true);
	}
	
//	(id,name,email,password,imgSrc,late_online)  
	public int  save(User u) {
		Connection conn = DB.getConn();
		int id = 0;
		String sql = "insert into user values(null, ?, ?, ?, ?,default,true,null)";
		PreparedStatement pstmt = DB.prepare(conn, sql);
		if(u.getName() == null || u.getEmail() == null 
				|| u.getPassword() == null || u.getImgSrc() == null) {
			throw (new FieldNullException("字段不能为空.."));
		}
		if(u.getName().trim().isEmpty() || u.getEmail().trim().isEmpty() 
				|| u.getPassword().trim().isEmpty()) 
			throw (new FieldNullException("字段不能为空.."));
		try {
			pstmt.setString(1, u.getName());
			pstmt.setString(2, u.getEmail());
			pstmt.setString(3, u.getPassword());
			pstmt.setString(4, u.getImgSrc());
//	System.out.println(new Timestamp(rdate.getTime()));
			//数据 过长 被截断了....
//			pstmt.setTimestamp(5, new Timestamp(rdate.getTime()));
			pstmt.executeUpdate();
			Statement stmt = DB.getStatement(conn);
			ResultSet rs = stmt.executeQuery("select last_insert_id()");
			rs.next();
			id = rs.getInt(1);
			DB.close(rs);
			DB.close(stmt);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(pstmt);
			DB.close(conn);
		}
		return id;

	}
	
	/**
	 * 根据名字查找用户
	 * @param name
	 * @return
	 */
	public User check(String name) {
		return check(name , null , false);
	}
	
	
	private User check(String username , String password, boolean flag) {
		User u = null;
		Connection conn = DB.getConn();
		String sql = "select * from user where name = '" + username + "'";
		Statement stmt = DB.getStatement(conn);
		ResultSet rs = DB.getResultSet(stmt, sql);
		try {
			if(!rs.next()) {
				if(!flag) {
					return null;
				} else 
					throw new UserNotFoundException("用户不存在:" + username);
			} else {
				if(flag && (password == null || !password.equals(rs.getString("password")))) {
					throw new PasswordNotCorrectException("密码不正确哦!");
				}
				u = new User();
				u.setId(rs.getInt("id"));
				u.setName(rs.getString("name"));
				u.setPassword(rs.getString("password"));
				u.setEmail(rs.getString("email"));
				u.setImgSrc(rs.getString("imgSrc"));
				u.setLateOnline(rs.getTimestamp("late_online"));
				u.setOnline(rs.getBoolean("is_online"));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(stmt);
			DB.close(conn);
		}
		return u;
	}
	
	
	/**
	 * 查找用户的好友
	 * @param user
	 */
	public void getUserFriends(User user) {
		Connection conn = DB.getConn();
		String sql = "select * from friends join user on "
				+ "friends.friend_id = user.id where friends.user_id = " + user.getId() + ";";
		Statement stmt = DB.getStatement(conn);
		ResultSet rs = null;
		HashSet<User> friends = new HashSet<User>();
		try {
			rs = stmt.executeQuery(sql);
			while(rs.next()) {
				User u = new User();
				u.setId(rs.getInt("id"));
				u.setName(rs.getString("name"));
				u.setEmail(rs.getString("email"));
				u.setPassword(rs.getString("password"));
				u.setImgSrc(rs.getString("imgSrc"));
				u.setLateOnline(rs.getTimestamp("late_online"));
				friends.add(u);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		user.setFriends(friends);
	}
	
	
	
	public User getUserById(int id) {
		User u = null;
		Connection conn = DB.getConn();
		String sql = "select * from user where id = " + id + ";";
		System.out.println(sql);
		Statement stmt = DB.getStatement(conn);
		ResultSet rs = DB.getResultSet(stmt, sql);
		try {
			if(!rs.next()) {
				return null;
			} else {
				u = new User();
				u.setId(rs.getInt("id"));
				u.setName(rs.getString("name"));
				u.setPassword(rs.getString("password"));
				u.setEmail(rs.getString("email"));
				u.setImgSrc(rs.getString("imgSrc"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(stmt);
			DB.close(conn);
		}
		return u;
	}
	
	
	/**
	 * 更新在线状态及时间 及 离线时间
	 * @param id
	 */
	public void updateOnline(User user , boolean isLogin)  {
		Connection conn = DB.getConn();
		String sql = "";
		Timestamp t = null;
		if(isLogin) {
			sql = "update user set is_online = ? , late_online = ? where id= ?";
			t = user.getLateOnline();
		} else {
			sql = "update user set is_online = ? , logout_time = ? where id= ?";
			t = user.getLogoutTime();
		}
		PreparedStatement pst = DB.prepare(conn, sql);
		try {
			pst.setBoolean(1, user.isOnline());
			pst.setTimestamp(2, t);
			pst.setInt(3, user.getId());
			pst.execute();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	
	/**
	 * 统计在线人数
	 * @param time
	 * @return
	 */
	public int countOnlineNum() {
		Connection conn = DB.getConn();
		Statement stmt = DB.getStatement(conn);
		String sql = "select count(*) from user where is_online = 1";
		ResultSet rs = DB.getResultSet(stmt, sql);
		int num = 0;
		try {
			if(!rs.next()) {
				System.out.println("统计在线人数出错");
			} else {
				num = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return num;
	}
	
	
	/**
	 * friends表中插入
	 */
	public void addFriend(User u , User f) {
		Connection conn = DB.getConn();
		String sql = "insert into friends values(?,?)";
		PreparedStatement pst = DB.prepare(conn, sql);
		try {
			pst.setInt(1, u.getId());
			pst.setInt(2, f.getId());
			pst.execute();
		} catch (SQLException e) {
			System.out.println("插入friends失败...");
			e.printStackTrace();
		} finally {
			DB.close(pst);
			DB.close(conn);
		}
	}
	
	
	
	public static void main (String[] args) {
		UserService s = new UserService();
		User u = new User();
//		u.setId(1);
//		s.getUserFriends(u);
//		System.out.println(u.getFriends());
		
//		u = s.getUserById(1);
//		System.out.println(u);
		u.setEmail("user1@qq.com");
		u.setImgSrc("head.jpg");
		u.setName("user1");
		u.setPassword("user1");
		
		int id = s.save(u);
		System.out.println(id);
	}
}
