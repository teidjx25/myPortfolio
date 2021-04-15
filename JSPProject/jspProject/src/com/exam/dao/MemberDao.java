package com.exam.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import com.exam.vo.MemberVo;
import com.exam.vo.MemberVo;

public class MemberDao {
	
	public int searchcountAll(String word) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		int count = 0;

		try {
			//JdbcUtils.getConnection() 메서드 호출
			con = JdbcUtils.getConnection();
			
			if(word!=null) {
				// 3단계. SQL문을 가지는 문장객체 준비
				sql = "SELECT COUNT(*) FROM member";
				sql += "where id LIKE '%"+word+"%' and lockState=0" ;
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				}else {
					sql = "SELECT COUNT(*) FROM member";
					pstmt = con.prepareStatement(sql);
					rs = pstmt.executeQuery();
				}
			
			
			if(rs.next()) {
				count = rs.getInt(1);
			}
			
		} catch (Exception e) {
			
			e.printStackTrace();

		} finally {
			// 사용한 jdbc객체는 사용이 끝나면 닫아줘야 함
			// 사용의 역순으로 닫아줌.
			// 서버에서 안전하게 하기 위해
			
			JdbcUtils.close(con,pstmt,rs);
		}

		return count;
	}// countAll
	
	
	
	public int countAll() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		int count = 0;

		try {
			//JdbcUtils.getConnection() 메서드 호출
			con = JdbcUtils.getConnection();
			
			
			// 3단계. sql 문장객체 준비
			sql = "SELECT COUNT(*) FROM member";
			pstmt = con.prepareStatement(sql);

			// 4단계. 문장객체로 sql문 실행
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt(1);
			}
			
		} catch (Exception e) {
			
			e.printStackTrace();

		} finally {
			// 사용한 jdbc객체는 사용이 끝나면 닫아줘야 함
			// 사용의 역순으로 닫아줌.
			// 서버에서 안전하게 하기 위해
			
			JdbcUtils.close(con,pstmt,rs);
		}

		return count;
	}// countAll

	public void deleteAll() {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "";



		try {
			//JdbcUtils.getConnection() 메서드 호출
			con = JdbcUtils.getConnection();
			// 3단계. sql 문장객체 준비
			sql = "DELETE FROM member";
			pstmt = con.prepareStatement(sql);

			// 4단계. 문장객체로 sql문 실행
			pstmt.executeUpdate();

		} catch (Exception e) {
			
			e.printStackTrace();

		} finally {
			JdbcUtils.close(con,pstmt);
		}

	}// deleteAll

	public void addMember(MemberVo memberVo){										//데이터를 추가하는 메서드
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "";



		try {
			//JdbcUtils.getConnection() 메서드 호출
			con = JdbcUtils.getConnection();
			// 3단계. sql 문장객체 준비

			sql = "INSERT INTO member(id,passwd,name,age,email,regDate,address,tel,gm_lev,gm_area) ";
			sql +="values(?,?,?,?,?,?,?,?,?,?) ";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, memberVo.getId());
			pstmt.setString(2, memberVo.getPassword());
			pstmt.setString(3, memberVo.getName());
			pstmt.setInt(4, memberVo.getAge());
			pstmt.setString(5, memberVo.getEmail());
			pstmt.setTimestamp(6, memberVo.getRegDate());
			pstmt.setString(7, memberVo.getAddress());
			pstmt.setString(8, memberVo.getTel());
			pstmt.setInt(9, memberVo.getGm_lev());
			pstmt.setInt(10, memberVo.getGm_area());
			// 4단계. 문장객체로 sql문 실행
			pstmt.executeUpdate();
			System.out.println("insert 성공!");
		} catch (Exception e) {
			
			e.printStackTrace();

		} finally {
			JdbcUtils.close(con,pstmt);
		}

	}//addMember

	public List<MemberVo> getMembers(){												//Select All을 하는 구현하는 메서드
		
			List<MemberVo> list = new ArrayList<MemberVo>();
			
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = "";
		

			try {
				//JdbcUtils.getConnection() 메서드 호출
				con = JdbcUtils.getConnection();
				
				
				// 3단계. sql 문장객체 준비
				sql = "SELECT * FROM member ORDER BY id";
				pstmt = con.prepareStatement(sql);

				// 4단계. 문장객체로 sql문 실행
				rs = pstmt.executeQuery();
				
				while(rs.next()) {		//행단위를 담는 함수
					MemberVo mv = new MemberVo();
					mv.setId(rs.getString("id"));
					mv.setPassword(rs.getString("passwd"));
					mv.setAge(rs.getInt("age"));
					mv.setName(rs.getString("name"));
					mv.setEmail(rs.getString("email"));
					mv.setRegDate(rs.getTimestamp("regDate"));
					mv.setAddress(rs.getString("address"));
					mv.setTel(rs.getString("tel"));
					
					mv.setGm_lev(rs.getInt("gm_lev"));
					mv.setGm_area(rs.getInt("gm_area"));
					list.add(mv);
				}
		
			} catch (Exception e) {
				e.printStackTrace();

			} finally {
				// 사용한 jdbc객체는 사용이 끝나면 닫아줘야 함
				// 사용의 역순으로 닫아줌.
				// 서버에서 안전하게 하기 위해
				
				JdbcUtils.close(con,pstmt,rs);
			}

			
			
		return list;
	}

	public MemberVo getMemberById(String id) {
		MemberVo mv = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		try {
			con = JdbcUtils.getConnection();
			
			sql = "SELECT * FROM member WHERE id = ? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				mv = new MemberVo();
				mv.setId(rs.getString("id"));
				mv.setPassword(rs.getString("passwd"));
				mv.setAge(rs.getInt("age"));
				mv.setName(rs.getString("name"));
				mv.setEmail(rs.getString("email"));
				mv.setRegDate(rs.getTimestamp("regDate"));
				mv.setAddress(rs.getString("address"));
				mv.setTel(rs.getString("tel"));
				
				mv.setGm_lev(rs.getInt("gm_lev"));
				mv.setGm_area(rs.getInt("gm_area"));

			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt, rs);
		}
		return mv;
	} // getMemberById
	
	public int getCountById(String id) {
		
		int count=0;
		
		
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		try {
			con = JdbcUtils.getConnection();
			
			sql = "SELECT COUNT(*) FROM member WHERE id = ? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			if (rs.next()) {	//mysql의 다음열 즉,제목열 다음 처음값을 읽어옴
				count = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt, rs);
		}
		return count;
	} // getMemberById

	
	public void updateMember(MemberVo memberVo) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "";
		
		try {
			con = JdbcUtils.getConnection();
			
			sql = "UPDATE member ";
			sql +="SET name = ? , passwd = ?, age = ? , email = ?";
			sql +="WHERE id =? ";
			

			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, memberVo.getName());
			pstmt.setString(2, memberVo.getPassword());
			pstmt.setInt(3, memberVo.getAge());
			pstmt.setString(4, memberVo.getEmail());

			
			pstmt.setString(5, memberVo.getId());
			
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		}
	} // updateMember
	public void updatePromotionMember(MemberVo memberVo) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "";
		
		try {
			con = JdbcUtils.getConnection();
			
			sql = "UPDATE member ";
			sql +="SET gm_lev = ? ";
			sql +="WHERE id =? ";
			

			pstmt = con.prepareStatement(sql);
			

			pstmt.setInt(1, memberVo.getGm_lev());
			
			
			pstmt.setString(2, memberVo.getId());
			
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		}
	} // updateMember
	
	public void deleteById(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "";
		
		try {
			con = JdbcUtils.getConnection();
			
			sql = "DELETE FROM member WHERE id = ? ";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		}
	} // deleteById
	
	public List<MemberVo> getMembers(String word,int startRow, int pageSize) {
		List<MemberVo> list = new ArrayList<MemberVo>();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		try {
			con = JdbcUtils.getConnection();
			if(word!=null) {
			sql  = "SELECT * ";
			sql += "FROM member ";
			sql += "where id LIKE '%"+word+"%' ";
			sql += "ORDER BY id DESC ";
			sql += "LIMIT ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, pageSize);
			rs = pstmt.executeQuery();
			}else {
				sql  = "SELECT * ";
				sql += "FROM member ";
				sql += "ORDER BY id DESC ";
				sql += "LIMIT ?,?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, startRow);
				pstmt.setInt(2, pageSize);
				rs = pstmt.executeQuery();
			}
			while (rs.next()) {
				MemberVo mv = new MemberVo();
				mv.setId(rs.getString("id"));
				mv.setPassword(rs.getString("passwd"));
				mv.setAge(rs.getInt("age"));
				mv.setName(rs.getString("name"));
				mv.setEmail(rs.getString("email"));
				mv.setRegDate(rs.getTimestamp("regDate"));
				mv.setAddress(rs.getString("address"));
				mv.setTel(rs.getString("tel"));
				
				mv.setGm_lev(rs.getInt("gm_lev"));
				mv.setGm_area(rs.getInt("gm_area"));

				
				list.add(mv); // 리스트에 vo 한개 추가
			} // while
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt, rs);
		}
		return list;
	} // getOpenboards
	
public static void main(String[] args) {
		
		MemberDao memberDao = new MemberDao();
		Random random = new Random();
		
		memberDao.deleteAll();
		
		for (int i=0; i<600; i++) {
			MemberVo memberVo = new MemberVo();
			memberVo.setId("associate_user" + i);
			memberVo.setPassword("1234");
			memberVo.setName("준회원" + i);
			
			// 나이값은 8세이상 100세이하의 임의의 정수로 설정
			int age = random.nextInt(93) + 8; // (0 ~ 92) + 8 -> (8 ~ 100)
			memberVo.setAge(age);
			
			memberVo.setAddress("부산광역시 동래구");
			memberVo.setTel("010-1111-1111");
			memberVo.setEmail("user" + i + "@naver.com");
			memberVo.setRegDate(new Timestamp(System.currentTimeMillis()));
			
			memberVo.setGm_lev(0);
			memberVo.setGm_area(1);
			
			memberDao.addMember(memberVo);
		} // for
		for (int i=0; i<400; i++) {
			MemberVo memberVo = new MemberVo();
			memberVo.setId("regular_user" + i);
			memberVo.setPassword("1234");
			memberVo.setName("정회원" + i);
			
			// 나이값은 8세이상 100세이하의 임의의 정수로 설정
			int age = random.nextInt(93) + 8; // (0 ~ 92) + 8 -> (8 ~ 100)
			memberVo.setAge(age);
			
			memberVo.setAddress("부산광역시 동래구");
			memberVo.setTel("010-1111-1111");
			memberVo.setEmail("user" + i + "@naver.com");
			memberVo.setRegDate(new Timestamp(System.currentTimeMillis()));
			
			memberVo.setGm_lev(1);
			memberVo.setGm_area(1);
			
			memberDao.addMember(memberVo);
		} // for
		
		for (int i=0; i<5; i++) {
			MemberVo memberVo = new MemberVo();
			memberVo.setId("Master" + i);
			memberVo.setPassword("1234");
			memberVo.setName("관리자" + i);
			
			// 나이값은 8세이상 100세이하의 임의의 정수로 설정
			int age = random.nextInt(93) + 8; // (0 ~ 92) + 8 -> (8 ~ 100)
			memberVo.setAge(age);
			
			memberVo.setAddress("부산광역시 동래구");
			memberVo.setTel("010-1111-1111");
			memberVo.setEmail("user" + i + "@naver.com");
			memberVo.setRegDate(new Timestamp(System.currentTimeMillis()));
			
			memberVo.setGm_lev(2);
			memberVo.setGm_area(1);
			
			memberDao.addMember(memberVo);
		} // for
		
		List<MemberVo> list = memberDao.getMembers();
		for (MemberVo memberVo : list) {
			System.out.println(memberVo.toString());
		} // for
		
		
		int count = memberDao.countAll();
		System.out.println("count = " + count);
		
		
		String testId = "user0";
		MemberVo memberVo = memberDao.getMemberById(testId);
		System.out.println("getMemberById(" + testId + ") : " + memberVo);
		
		// update 메서드 테스트
		memberVo.setName("성춘향");
		memberVo.setAge(33);
		memberDao.updateMember(memberVo);
		
		MemberVo memberVo2 = memberDao.getMemberById(testId);
		System.out.println("memberVo2 : " + memberVo2);
		
		// delete 메서드 테스트
		memberDao.deleteById(testId);
		
		MemberVo memberVo3 = memberDao.getMemberById(testId);
		System.out.println("testId " + testId + " 삭제 후 : " + memberVo3);
	} // main

}
