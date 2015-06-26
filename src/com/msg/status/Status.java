package com.msg.status;

// default package

import java.sql.Timestamp;
import java.util.HashSet;
import java.util.Set;

import com.msg.user.User;

/**
 * Status entity. @author MyEclipse Persistence Tools
 */

@SuppressWarnings("rawtypes")
public class Status implements java.io.Serializable {

	private static final long serialVersionUID = 1L;
	// Fields

	private Integer id;
	private User user;
	private Timestamp createTime;
	private Integer views;
	private String content;
	private Integer praises;
	private Integer friendId;
	private Set notifications = new HashSet(0);
	private Set comments = new HashSet(0);

	// Constructors

	/** default constructor */
	public Status() {
	}

	/** minimal constructor */
	public Status(String content) {
		this.content = content;
	}

	/** full constructor */
	public Status(User user, Timestamp createTime, Integer views,
			String content, Integer praises, Integer friendId,
			Set notifications, Set comments) {
		this.user = user;
		this.createTime = createTime;
		this.views = views;
		this.content = content;
		this.praises = praises;
		this.friendId = friendId;
		this.notifications = notifications;
		this.comments = comments;
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

	public Timestamp getCreateTime() {
		return this.createTime;
	}

	public void setCreateTime(Timestamp createTime) {
		this.createTime = createTime;
	}

	public Integer getViews() {
		return this.views;
	}

	public void setViews(Integer views) {
		this.views = views;
	}

	public String getContent() {
		return this.content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Integer getPraises() {
		return this.praises;
	}

	public void setPraises(Integer praises) {
		this.praises = praises;
	}

	public Integer getFriendId() {
		return this.friendId;
	}

	public void setFriendId(Integer friendId) {
		this.friendId = friendId;
	}

	public Set getNotifications() {
		return this.notifications;
	}

	public void setNotifications(Set notifications) {
		this.notifications = notifications;
	}

	public Set getComments() {
		return this.comments;
	}

	public void setComments(Set comments) {
		this.comments = comments;
	}

}