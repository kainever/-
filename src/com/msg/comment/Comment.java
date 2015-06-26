package com.msg.comment;

// default package

import java.sql.Timestamp;
import java.util.HashSet;
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
	private Set comments = new HashSet(0);
	private Set notifications = new HashSet(0);

	// Constructors

	/** default constructor */
	public Comment() {
	}

	/** minimal constructor */
	public Comment(String content) {
		this.content = content;
	}

	/** full constructor */
	public Comment(User user, Comment comment, Status status, String content,
			Timestamp commentTime, Set comments, Set notifications) {
		this.user = user;
		this.comment = comment;
		this.status = status;
		this.content = content;
		this.commentTime = commentTime;
		this.comments = comments;
		this.notifications = notifications;
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

	public Set getComments() {
		return this.comments;
	}

	public void setComments(Set comments) {
		this.comments = comments;
	}

	public Set getNotifications() {
		return this.notifications;
	}

	public void setNotifications(Set notifications) {
		this.notifications = notifications;
	}

}