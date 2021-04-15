package com.exam.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class JdbcUtils {
	public static Connection getConnection() throws Exception {
		
		Connection con = null;
		
		String url = "jdbc:mysql://localhost:3306/prodb?useUnicode=true&characterEncoding=utf8&allowPublicKeyRetrieval=true&useSSL=false&serverTimezone=Asia/Seoul";
		String user = "projectid"; // DB 계정 아이디
		String password = "pro1234"; // DB 계정 패스워드
		
		Class.forName("com.mysql.jdbc.Driver");
		// 2단계. 로딩된 드라이버 클래스를 이용해서
		// 특정 DB에 DB사용자 계정으로 로그인 해서 연결하기
		con = DriverManager.getConnection(url, user, password);
		
		
		return con;
	}//getConnection
	
	public static void close(Connection con, PreparedStatement pstmt) {close(con,pstmt,null);}
	
	public static void close(Connection con, PreparedStatement pstmt, ResultSet rs) {
		// 사용한 jdbc객체는 사용이 끝나면 닫아줘야 함
		// 사용의 역순으로 닫아줌.
		// 서버에서 안전하게 하기 위해
		
		if (rs != null) {
			try {
				rs.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		}
		
		if (pstmt != null) {
			try {
				pstmt.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		}

		if (con != null) {
			try {
				con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

	}
	
}
