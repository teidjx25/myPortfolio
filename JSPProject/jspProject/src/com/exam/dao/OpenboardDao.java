package com.exam.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.exam.vo.OpenboardVo;

public class OpenboardDao {
	
	public int countAll(String word) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = "";
		int count = 0;

		try {
			con = JdbcUtils.getConnection();
		

			if(word!=null) {
			// 3단계. SQL문을 가지는 문장객체 준비
			sql = "SELECT COUNT(*) FROM openboard ";
			sql += "where subject LIKE '%"+word+"%' and lockState=0" ;
			pstmt = con.prepareStatement(sql);
		
			//pstmt.setString(1, word);
			// 4단계. 문장객체로 SQL문 실행
			rs = pstmt.executeQuery();
			
			}else {
				sql = "SELECT COUNT(*) FROM openboard";
				pstmt = con.prepareStatement(sql);
				// 4단계. 문장객체로 SQL문 실행
				rs = pstmt.executeQuery();
			}
			
			
			if (rs.next()) {
				count = rs.getInt(1);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt, rs);
		}
		return count;
	} // countAll

	public void deleteAll() {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "";

		try {
			con = JdbcUtils.getConnection();
			// 3단계. SQL문을 가지는 문장객체 준비
			sql = "DELETE FROM openboard";
			pstmt = con.prepareStatement(sql);
			// 4단계. 문장객체로 SQL문 실행
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		}
	} // deleteAll
	
	

	public int getNextNum() {
		int nextNum = 0;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		try {
			con = JdbcUtils.getConnection();
			
			sql = "SELECT IFNULL(MAX(num), 0) + 1 AS next_num FROM openboard";
			
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				nextNum = rs.getInt("next_num");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt, rs);
		}
		return nextNum;
	} // getNextNum
	
	//주글/답글 생성
	public void add(OpenboardVo vo) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "";
		
		try {
			con = JdbcUtils.getConnection();
			
			sql  = "INSERT INTO openboard (num, name, passwd, subject, content, readcount, reg_date, ip, filename, re_ref, re_lev, re_seq,mgLev,lockState) ";
			sql += "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?,?) ";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, vo.getNum());
			pstmt.setString(2, vo.getName());
			pstmt.setString(3, vo.getPasswd());
			pstmt.setString(4, vo.getSubject());
			pstmt.setString(5, vo.getContent());
			pstmt.setInt(6, vo.getReadcount());
			pstmt.setTimestamp(7, vo.getRegDate());
			pstmt.setString(8, vo.getIp());
			pstmt.setString(9, vo.getFilename());
			pstmt.setInt(10, vo.getReRef());
			pstmt.setInt(11, vo.getReLev());
			pstmt.setInt(12, vo.getReSeq());
			pstmt.setInt(13, vo.getMg_Lev());
			pstmt.setInt(14, vo.getLockState());
			
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		} 
	} // add
	
	
	
	public List<OpenboardVo> getOpenboards(String word,int startRow, int pageSize) {
		List<OpenboardVo> list = new ArrayList<OpenboardVo>();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		try {
			con = JdbcUtils.getConnection();
			if(word!=null) {
			sql  = "SELECT * ";
			sql += "FROM openboard ";
			sql += "where subject LIKE '%"+word+"%' ";
			sql += "ORDER BY re_ref DESC, re_seq ASC ";
			sql += "LIMIT ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, pageSize);
			rs = pstmt.executeQuery();
			}else {
				sql  = "SELECT * ";
				sql += "FROM openboard ";
				sql += "ORDER BY re_ref DESC, re_seq ASC ";
				sql += "LIMIT ?,?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, startRow);
				pstmt.setInt(2, pageSize);
				rs = pstmt.executeQuery();
			}
			while (rs.next()) {
				OpenboardVo vo = new OpenboardVo();
				vo.setNum(rs.getInt("num"));
				vo.setName(rs.getString("name"));
				vo.setPasswd(rs.getString("passwd"));
				vo.setSubject(rs.getString("subject"));
				vo.setContent(rs.getString("content"));
				vo.setReadcount(rs.getInt("readcount"));
				vo.setRegDate(rs.getTimestamp("reg_date"));
				vo.setIp(rs.getString("ip"));
				vo.setFilename(rs.getString("filename"));
				vo.setReRef(rs.getInt("re_ref"));
				vo.setReLev(rs.getInt("re_lev"));
				vo.setReSeq(rs.getInt("re_seq"));
				vo.setMg_Lev(rs.getInt("mgLev"));
				vo.setLockState(rs.getInt("lockState"));
				
				list.add(vo); // 리스트에 vo 한개 추가
			} // while
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt, rs);
		}
		return list;
	} // getOpenboards
	
	//조회수 1 증가 시키기
	public void updateReadcountByNum(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		String sql = "";
		
		try {
			con = JdbcUtils.getConnection();
			
			sql= "UPDATE openboard SET readcount= readcount+1 WHERE num =?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
				
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		}
	
	}
	
	public void updatelockstateByNum(int num,int decision) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		String sql = "";
		
		try {
			con = JdbcUtils.getConnection();
			
			sql= "UPDATE openboard SET lockState=? WHERE num =?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, decision);
			pstmt.setInt(2, num);
			pstmt.executeUpdate();
				
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		}
	
	}
	
	public OpenboardVo getOpenboardByNum(int num) {
		OpenboardVo vo = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		try {
			con = JdbcUtils.getConnection();
			
			sql  = "SELECT * FROM openboard  WHERE num=? ";

			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);

			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				vo = new OpenboardVo();
				
				vo.setNum(rs.getInt("num"));
				vo.setName(rs.getString("name"));
				vo.setPasswd(rs.getString("passwd"));
				vo.setSubject(rs.getString("subject"));
				vo.setContent(rs.getString("content"));
				vo.setReadcount(rs.getInt("readcount"));
				vo.setRegDate(rs.getTimestamp("reg_date"));
				vo.setIp(rs.getString("ip"));
				vo.setFilename(rs.getString("filename"));
				vo.setReRef(rs.getInt("re_ref"));
				vo.setReLev(rs.getInt("re_lev"));
				vo.setReSeq(rs.getInt("re_seq"));
				vo.setMg_Lev(rs.getInt("mgLev"));
				vo.setLockState(rs.getInt("lockState"));

				
			} // while
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt, rs);
		}
		return vo;
	} // getOpenboardByNum
	
	public boolean isPasswdCorrect(int num, String passwd) {
		boolean isCorrect =false;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		try {
			con = JdbcUtils.getConnection();
			
			sql  = "SELECT count(*) ";
			sql += "FROM openboard ";
			sql += " WHERE num=? ";
			sql += " AND passwd =?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setString(2, passwd);
			
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				
				int count =rs.getInt(1);
				
				if(count == 1) {
					isCorrect = true;
				}
				else {
					isCorrect = false;
				}

				
			} //rs.next()if
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt, rs);
		}

		
		return isCorrect;
	}
	
	public void deleteByNum(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "";
		
		try {
			con = JdbcUtils.getConnection();
			
			sql  = " DELETE FROM openboard WHERE num = ? ";
			
			
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		}
	}
	//글번호 해당하는 글 내용 수정하기 ***나중에 관리레벨 확인 해보기
	public void update(OpenboardVo vo) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "";
		
		try {
			con = JdbcUtils.getConnection();
			
			sql  = " UPDATE openboard ";
			sql  += " SET name= ?,passwd = ?,subject=?,content =?,filename=? " ;
			sql  +=	"WHERE num =?";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, vo.getName());
			pstmt.setString(2, vo.getPasswd());
			pstmt.setString(3, vo.getSubject());
			pstmt.setString(4, vo.getContent());
			pstmt.setString(5, vo.getFilename());
			pstmt.setInt(6, vo.getNum());
			pstmt.executeUpdate(); //실행
			
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		}
	}
	
	//같은 글그룹에 속하고 특정 순번보다 큰 글들에 대해서 순번 1 증가
	public void updateReSeqInReRef(int reRef,int reSeq) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "";
		
		try {
			con = JdbcUtils.getConnection();
			
			sql = "UPDATE openboard ";
			sql	+= "SET re_seq= re_seq +1 ";
			sql	+= "WHERE re_ref = ?";
			sql	+= " AND re_seq >?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, reRef);
			pstmt.setInt(2, reSeq);
			
			pstmt.executeUpdate();
			

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		}

		
	}
	
	public static void main(String[] args) {
		
		OpenboardDao dao = new OpenboardDao();


		dao.deleteAll();
		
		// 주글 1000개 insert하기
		for (int i=0; i<50; i++) {
			OpenboardVo vo = new OpenboardVo();
			
			int num = dao.getNextNum();
			vo.setNum(num);
			vo.setName("글쓴이" + num);
			vo.setPasswd("1234");
			vo.setSubject("준회원 글제목" + num);
			vo.setContent("준회원 글내용" + num);
			vo.setReadcount(0);
			vo.setRegDate(new Timestamp(System.currentTimeMillis()));
			vo.setIp("127.0.0.1");
			vo.setReRef(num);
			vo.setReLev(0);
			vo.setReSeq(0);
			vo.setMg_Lev(0);
			vo.setLockState(0);
			
			dao.add(vo); // insert
			
		} // for
		
		for (int i=0; i<30; i++) {
			OpenboardVo vo = new OpenboardVo();
			
			int num = dao.getNextNum();
			vo.setNum(num);
			vo.setName("글쓴이" + num);
			vo.setPasswd("1234");
			vo.setSubject("정회원 글제목" + num);
			vo.setContent("정회원 글내용" + num);
			vo.setReadcount(0);
			vo.setRegDate(new Timestamp(System.currentTimeMillis()));
			vo.setIp("127.0.0.1");
			vo.setReRef(num);
			vo.setReLev(0);
			vo.setReSeq(0);
			vo.setMg_Lev(1);
			vo.setLockState(2);
			
			dao.add(vo); // insert
			
		} // for
		
		for (int i=0; i<20; i++) {
			OpenboardVo vo = new OpenboardVo();
			
			int num = dao.getNextNum();
			vo.setNum(num);
			vo.setName("글쓴이" + num);
			vo.setPasswd("1234");
			vo.setSubject("관리자 글제목" + num);
			vo.setContent("관리자 글내용" + num);
			vo.setReadcount(0);
			vo.setRegDate(new Timestamp(System.currentTimeMillis()));
			vo.setIp("127.0.0.1");
			vo.setReRef(num);
			vo.setReLev(0);
			vo.setReSeq(0);
			vo.setMg_Lev(2);
			vo.setLockState(1);
			
			dao.add(vo); // insert
			
		} // for
		System.out.println("입력끝");
		//System.out.println("전체 레코드 갯수 : " + dao.countAll());
		
	} // main

}






