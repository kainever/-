package com.msg.comment;

// default package

import java.sql.Timestamp;
import java.util.LinkedList;
import java.util.Set;

import com.msg.status.Status;
import com.msg.user.User;

/**
 * Comment entity. @author MyEclipse Persistence Tools
 */
@SuppressWarnings("rawtypes")
public class Comment implements java.io.Serializable {

	// Fields

	private static final long serialVersionUID = -1702346689441894523L;
	private Integer id;
	private User user;
	private Comment comment;
	private Status status;
	private String content;
	private Timestamp commentTime;
	private LinkedList<Comment> comments = new LinkedList<Comment>();

	
	@Override
	public String toString() {
		return id + " comment_id = " +  comment.getId() + " comment_cont = " + content  +  "  son_comment_num = " + comments.size();
	}
	
	// Constructors

	public LinkedList<Comment> getComments() {
		return comments;
	}

	public void setComments(LinkedList<Comment> comments) {
		this.comments = comments;
	}

	/** default constructor */
	public Comment() {
	}

	/** minimal constructor */
	public Comment(String content) {
		this.content = content;
	}


	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public User getUser() {
		return this.user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Comment getComment() {
		return this.comment;
	}

	public void setComment(Comment comment) {
		this.comment = comment;
	}

	public Status getStatus() {
		return this.status;
	}

	public void setStatus(Status status) {
		this.status = status;
	}

	public String getContent() {
		return this.content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Timestamp getCommentTime() {
		return this.commentTime;
	}

	public void setCommentTime(Timestamp commentTime) {
		this.commentTime = commentTime;
	}


}