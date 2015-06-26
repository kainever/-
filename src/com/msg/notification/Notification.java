package com.msg.notification;

import com.msg.comment.Comment;
import com.msg.status.Status;
import com.msg.user.User;

// default package

/**
 * Notification entity. @author MyEclipse Persistence Tools
 */

public class Notification implements java.io.Serializable {

	// Fields

	private static final long serialVersionUID = 1L;
	private Integer id;
	private User user;
	private Status status;
	private Comment comment;

	// Constructors

	/** default constructor */
	public Notification() {
	}

	/** full constructor */
	public Notification(User user, Status status, Comment comment) {
		this.user = user;
		this.status = status;
		this.comment = comment;
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

	public Status getStatus() {
		return this.status;
	}

	public void setStatus(Status status) {
		this.status = status;
	}

	public Comment getComment() {
		return this.comment;
	}

	public void setComment(Comment comment) {
		this.comment = comment;
	}

}