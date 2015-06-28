package com.msg.notification;

import java.sql.Timestamp;

import com.msg.status.Status;
import com.msg.user.User;

// default package

/**
 * Notification entity. @author MyEclipse Persistence Tools
 */

public class Notification implements java.io.Serializable {

	// Fields

	private static final long serialVersionUID = 1L;
	private User user;
	private Status status;
	private boolean isMsg;
	private Timestamp registerTime;

	// Constructors

	/** default constructor */
	public Notification() {
	}

	/** full constructor */
	public Notification(User user, Status status) {
		this.user = user;
		this.status = status;
	}

	// Property accessors


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

	public Timestamp getRegisterTime() {
		return registerTime;
	}

	public void setRegisterTime(Timestamp registerTime) {
		this.registerTime = registerTime;
	}

	public boolean isMsg() {
		return isMsg;
	}

	public void setMsg(boolean isMsg) {
		this.isMsg = isMsg;
	}


}