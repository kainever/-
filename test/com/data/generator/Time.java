package com.data.generator;

import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public enum Time {
	DATE1("2016-6-26 12:14:10"),
	DATE2("2016-6-26 12:14:10"),
	DATE3("2016-6-26 12:14:10"),
	DATE4("2016-6-26 12:14:10"),
	DATE5("2016-6-26 12:14:10"),
	DATE6("2016-6-26 12:14:10"),
	DATE7("2016-6-26 12:14:10");
	
	private Timestamp date;
	
	Time(String date) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-mm-dd hh24:mm:ss");
		Date d = null;
		try {
			d = sdf.parse(date);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		this.date = new Timestamp(d.getTime());
	}
}
