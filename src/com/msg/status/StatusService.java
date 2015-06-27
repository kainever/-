package com.msg.status;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;

import com.data.generator.Time;
import com.msg.comment.Comment;
import com.msg.user.User;
import com.msg.user.UserService;
import com.msg.util.DB;

public class StatusService {

	private final static int PAGE_SIZE = 8;
	
	public static void main(String[] args) {
		User user = new User();
		user.setId(1);
		Time[] ts = Time.values();
		user.setLateOnline(ts[0].DATE1.date);
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
		LinkedList<Comment> cs = ss.getComments(st, c , true);
		int count = ss.getCommentTime(cs, 0);
		System.out.println(count);
	}
	
	private static StatusService service;
	
	private StatusService() {}
	
	public static StatusService getInstance() {
		if(service == null) {
			service = new StatusService();
		}
		return service;
	}
	
	
	public List<Status> getNewStatus(User user , int page){
		Connection conn = DB.getConn();
		String sql = "select status.id,status.user_id,status.content,status.praises,status.views,status.create_time from status join status_notice on "
				+ "status.id = status_notice.notice_id where status_notice.user_id="
				+user.getId()+" and status.create_time > '" + user.getLateOnline() + "' order by status.create_time desc limit " + (page-1)*8 + ",8";
//System.out.println(sql);
		PreparedStatement pst = DB.prepare(conn, sql);
		ResultSet rs = null;
		UserService us = UserService.getInstance();
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
				LinkedList<Comment> coms = getComments(st,com,true);
				st.setComments(coms);
				int count = 0;
//				评论数
				count = getCommentTime(coms , count);
				st.setComment_time(count);
				list.add(st);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return list;
	}
	
	
	/**
	 * 树中怎么求节点的个数
	 * @param coms
	 * @param st
	 * @return
	 */
	public int getCommentTime(LinkedList<Comment> coms ,int count) {
		Iterator it = coms.iterator();
		count += coms.size();
		while(it.hasNext()) {
			Comment com = (Comment) it.next();
			count = getCommentTime(com.getComments() , count);
		}
		return count;
	}

//	DFS
	public LinkedList<Comment> getComments(Status st ,Comment comment , boolean first) {
		int id = 0;
		id = comment.getId();
		Connection conn = DB.getConn();
		String sql = "select comment.id as com_id , comment.p_user_id,comment.status_id , comment.content,comment.comment_time,"
				+ " user.id , user.name,user.email,user.password,user.imgSrc ,user.late_online "
				+ "from comment join user on comment.user_id = user.id where comment_id=" + id + " and status_id = " + st.getId() +";";
//System.out.println(sql);
		Statement stmt = DB.getStatement(conn);
		ResultSet rs = null;
		LinkedList<Comment> list = new LinkedList<Comment> ();
		try {
			rs = stmt.executeQuery(sql);
			while(rs.next()) {
				User u = new User();
				Comment com = new Comment();
				u.setId(rs.getInt("id"));
				u.setName(rs.getString("name"));
				u.setPassword(rs.getString("password"));
				u.setEmail(rs.getString("email"));
				u.setImgSrc(rs.getString("imgSrc"));
				u.setLateOnline(rs.getTimestamp("late_online"));
				com.setId(rs.getInt("com_id"));
				com.setCommentTime(rs.getTimestamp("comment_time"));
				com.setUser(u);
				com.setContent(rs.getString("content"));
				com.setStatus(st);
				if(!first) {
					User pu = UserService.getInstance().getUserById(rs.getInt("p_user_id"));
//	System.out.println("pu ====" + pu);
					com.setpUser(pu);
				}
//				递归查找子评论
				LinkedList<Comment> comments = getComments(st , com , false);
				com.setComments(comments);
				list.add(com);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(stmt);
			DB.close(conn);
		}
//		System.out.println(list);
		return list;
	}

}
