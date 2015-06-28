/**
 * 
 */
package com.msg.listener;

import java.sql.Timestamp;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import com.msg.user.User;
import com.msg.user.UserService;

/**
 * @author slave_1
 * 会话监听器，当会话失效的时候采取相应的动作
 */
public class SessionListener implements HttpSessionListener{

	@Override
	public void sessionCreated(HttpSessionEvent arg0) {
		
	}

	@Override
	public void sessionDestroyed(HttpSessionEvent event) {
		HttpSession session = event.getSession();
		User u = (User) session.getAttribute("user");
		u.setOnline(false);
		u.setLogoutTime(new Timestamp(new java.util.Date().getTime()));
		UserService us = UserService.getInstance();
		us.updateOnline(u , false);
	}

}
