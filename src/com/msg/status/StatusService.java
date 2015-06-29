package com.msg.status;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Set;

import com.msg.comment.Comment;
import com.msg.comment.CommentService;
import com.msg.notification.NoticeService;
import com.msg.user.User;
import com.msg.user.UserService;
import com.msg.util.DB;

public class StatusService {

	private final static int PAGE_SIZE = 8;
	
	public static void main(String[] args) {
		User user = new User();
		user.setId(1);
//		Time[] ts = Time.values();
//		user.setLateOnline(ts[0].DATE1.date);
//		String sql = "select status.id,status.user_id,status.content,status.praises,status.views,status.create_time from status join status_notice on "
//				+ "status.id = status_notice.notice_id where status_notice.user_id="
//				+user.getId()+" and status.create_time > '" + user.getLateOnline() + "' order by status.create_time desc limit 0 , 5";
//		System.out.println(sql);
//		int id = 1;
//		String sql = "select comment.id as com_id , comment.status_id , comment.content,comment.comment_time,"
//				+ " user.id , user.name,user.email,user.password,user.imgSrc ,user.late_online "
//				+ "from comment join user on comment.user_id = user.id where comment_id=" + id + ";";
//		
//		System.out.println(sql);
		
		StatusService ss  = new StatusService();
		Status st = new Status();
		st.setId(1);
		Comment c = new Comment();
		c.setId(1);
//		LinkedList<Comment> cs = ss.getComments(st, c , true);
//		int count = ss.getCommentTime(cs, 0);
//		System.out.println(count);
	}
	
	
	
	
	private static StatusService service;
	
	private StatusService() {}
	
	public static StatusService getInstance() {
		if(service == null) {
			service = new StatusService();
		}
		return service;
	}
	
	
	/**
	 * 找到该用户有关的所有动态
	 * @param user
	 * @param page
	 * @return
	 */
	public List<Status> getNewStatus(User user , int page){
		Connection conn = DB.getConn();
		String sql = "select status.id,status.user_id,status.content,status.praises,status.views,status.create_time from status join status_notice on "
				+ "status.id = status_notice.notice_id where status_notice.user_id="
				+user.getId()+"  order by status.create_time desc limit " + (page-1)*8 + ",8";
//System.out.println("status " + sql);
		PreparedStatement pst = DB.prepare(conn, sql);
		ResultSet rs = null;
		UserService us = UserService.getInstance();
		CommentService cs = CommentService.getInstance();
		List<Status> list = new ArrayList<Status> ();
		try {
			rs = pst.executeQuery(sql);
			while(rs.next()) {
				Status st = new Status();
				int id = rs.getInt("id");
				st.setId(id);
				st.setContent(rs.getString("content"));
				st.setCreateTime(rs.getTimestamp("create_time"));
				st.setPraises(rs.getInt("praises"));
				st.setViews(rs.getInt("views"));
//				获得status的作者信息
				User u = us.getUserById(rs.getInt("user_id"));
				st.setUser(u);
//				获得他的评论
				Comment com = new Comment();
				com.setId(st.getId());
				LinkedList<Comment> coms = cs.getComments(st,com,true);
				st.setComments(coms);
				int count = 0;
//				评论数
				count = cs.getCommentTime(coms , count);
//				更新评论数... 测试数据使用....
				this.updateCommentTime(st.getId(), count);
				
				st.setComment_time(count);
				list.add(st);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return list;
	}
	
	
	
	
	/**
	 * 插入动态
	 * @param s
	 * @return
	 */
	public int insert(Status s) {
		Connection conn = DB.getConn();
		String sql = "insert into status values(null,?,?,?,? , ? ,null,default)";
		PreparedStatement ps = DB.prepare(conn, sql);
		int id = 0;
		try {
			ps.setInt(1, s.getUser().getId());
			ps.setTimestamp(2, new Timestamp(new Date().getTime()));
			ps.setInt(3, 0);
			ps.setString(4,s.getContent());
			ps.setInt(5, 0);
			ps.execute();
			Statement stmt = DB.getStatement(conn);
			ResultSet rs = stmt.executeQuery("select last_insert_id()");
			rs.next();
			id = rs.getInt(1);
			DB.close(rs);
			DB.close(stmt);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return id;
	}
	
	/**
	 * 发布新的状态后，向status_notice中注册
	 * @param friends
	 */
	public void registerNoticeToFriends(Set<User> friends ,Status s , boolean isMsg) {
		Iterator it = friends.iterator();
		while(it.hasNext()) {
			User f = (User) it.next();
			NoticeService.insert(f , s , isMsg);
		}
	}
	
	/**
	 * 根据id查找动态
	 * @param id
	 * @return
	 */
	public Status searchById(int id) {
		Connection conn = DB.getConn();
		String sql = "select * from status where id= " + id +";";
		Statement stmt = DB.getStatement(conn);
		ResultSet rs = DB.getResultSet(stmt, sql);
		Status st = null;
		try {
			if(!rs.next()) {
				System.out.println("不存在改用户");
			} else {
				st = new Status();
				st.setComment_time(rs.getInt("comment_time"));
				st.setId(rs.getInt("id"));
				st.setViews(rs.getInt("views"));
				st.setPraises(rs.getInt("praises"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(stmt);
			DB.close(conn);
		}
		return st;
	}
	
	/**
	 * 更新评论次数
	 * @param id
	 * @return
	 */
	public boolean updateCommentTime(int id , int times) {
		Connection conn = DB.getConn();
		String sql = "update status set comment_time = " + times + " where id = " + id + ";";
		Statement stmt = DB.getStatement(conn);
		DB.executeUpdate(stmt, sql);
		DB.close(stmt);
		DB.close(conn);
		return true;
	}
	
	
}
