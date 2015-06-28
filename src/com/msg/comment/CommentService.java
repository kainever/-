package com.msg.comment;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.sql.Types;
import java.util.Iterator;
import java.util.LinkedList;

import com.msg.status.Status;
import com.msg.user.User;
import com.msg.user.UserService;
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
	
	
	public static void main(String[] args) {
//		CommentService cs = new CommentService();
//		int id = cs.insert(com);
	}
}
