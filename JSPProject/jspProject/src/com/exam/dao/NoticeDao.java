package com.exam.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.exam.vo.noticeboardVo;

public class NoticeDao {
	
	
	
	public int countnotice() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = "";
		int count = 0;

		try {
			con = JdbcUtils.getConnection();

				sql = "SELECT COUNT(*) FROM noticeboard where state=1";
				pstmt = con.prepareStatement(sql);
				// 4단계. 문장객체로 SQL문 실행
				rs = pstmt.executeQuery();

			
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
			sql = "SELECT COUNT(*) FROM noticeboard ";
			sql += "where subject LIKE '%"+word+"%'" ;
			pstmt = con.prepareStatement(sql);
		
			//pstmt.setString(1, word);
			// 4단계. 문장객체로 SQL문 실행
			rs = pstmt.executeQuery();
			
			}else {
				sql = "SELECT COUNT(*) FROM noticeboard";
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
			sql = "DELETE FROM noticeboard";
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
			
			sql = "SELECT IFNULL(MAX(num), 0) + 1 AS next_num FROM noticeboard";
			
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
	public void add(noticeboardVo vo) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "";
		
		try {
			con = JdbcUtils.getConnection();
			
			sql  = "INSERT INTO noticeboard (num, name, subject, content, readcount, reg_date, filename, re_ref, re_lev, re_seq,state) ";
			sql += "VALUES (?, ?, ?, ?, ?,?, ?, ?, ?, ?,?) ";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, vo.getNum());
			pstmt.setString(2, vo.getName());
			pstmt.setString(3, vo.getSubject());
			pstmt.setString(4, vo.getContent());
			pstmt.setInt(5, vo.getReadcount());
			pstmt.setTimestamp(6, vo.getRegDate());
			pstmt.setString(7, vo.getFilename());
			pstmt.setInt(8, vo.getReRef());
			pstmt.setInt(9, vo.getReLev());
			pstmt.setInt(10, vo.getReSeq());
			pstmt.setInt(11, vo.getState());

			
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		} 
	} // add
	
	public List<noticeboardVo> getOpenNotice() {
		List<noticeboardVo> list = new ArrayList<noticeboardVo>();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		try {
			con = JdbcUtils.getConnection();

				sql  = "SELECT * ";
				sql += "FROM noticeboard ";
				sql += "WHERE state=1";
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
			
			while (rs.next()) {
				noticeboardVo vo = new noticeboardVo();
				vo.setNum(rs.getInt("num"));
				vo.setName(rs.getString("name"));
				vo.setSubject(rs.getString("subject"));
				vo.setContent(rs.getString("content"));
				vo.setReadcount(rs.getInt("readcount"));
				vo.setRegDate(rs.getTimestamp("reg_date"));
				vo.setFilename(rs.getString("filename"));
				vo.setReRef(rs.getInt("re_ref"));
				vo.setReLev(rs.getInt("re_lev"));
				vo.setReSeq(rs.getInt("re_seq"));
			
				
				list.add(vo); // 리스트에 vo 한개 추가
			} // while
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt, rs);
		}
		return list;
	} // getnoticeboards
	
	
	public List<noticeboardVo> getnoticeboards(String word,int startRow, int pageSize) {
		List<noticeboardVo> list = new ArrayList<noticeboardVo>();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		try {
			con = JdbcUtils.getConnection();
			if(word!=null) {
			sql  = "SELECT * ";
			sql += "FROM noticeboard ";
			sql += "where subject LIKE '%"+word+"%' ";
			sql += "ORDER BY re_ref DESC, re_seq ASC ";
			sql += "LIMIT ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, pageSize);
			rs = pstmt.executeQuery();
			}else {
				sql  = "SELECT * ";
				sql += "FROM noticeboard ";
				sql += "ORDER BY re_ref DESC, re_seq ASC ";
				sql += "LIMIT ?,?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, startRow);
				pstmt.setInt(2, pageSize);
				rs = pstmt.executeQuery();
			}
			while (rs.next()) {
				noticeboardVo vo = new noticeboardVo();
				vo.setNum(rs.getInt("num"));
				vo.setName(rs.getString("name"));
				vo.setSubject(rs.getString("subject"));
				vo.setContent(rs.getString("content"));
				vo.setReadcount(rs.getInt("readcount"));
				vo.setRegDate(rs.getTimestamp("reg_date"));
				vo.setFilename(rs.getString("filename"));
				vo.setReRef(rs.getInt("re_ref"));
				vo.setReLev(rs.getInt("re_lev"));
				vo.setReSeq(rs.getInt("re_seq"));
			
				
				list.add(vo); // 리스트에 vo 한개 추가
			} // while
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt, rs);
		}
		return list;
	} // getnoticeboards
	
	//조회수 1 증가 시키기
	public void updateReadcountByNum(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		String sql = "";
		
		try {
			con = JdbcUtils.getConnection();
			
			sql= "UPDATE noticeboard SET readcount= readcount+1 WHERE num =?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
				
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		}
	
	}
	
	
	
	public noticeboardVo getnoticeboardByNum(int num) {
		noticeboardVo vo = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		try {
			con = JdbcUtils.getConnection();
			
			sql  = "SELECT * FROM noticeboard  WHERE num=? ";

			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);

			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				vo = new noticeboardVo();
				
				vo.setNum(rs.getInt("num"));
				vo.setName(rs.getString("name"));
				vo.setSubject(rs.getString("subject"));
				vo.setContent(rs.getString("content"));
				vo.setReadcount(rs.getInt("readcount"));
				vo.setRegDate(rs.getTimestamp("reg_date"));
				vo.setFilename(rs.getString("filename"));
				vo.setReRef(rs.getInt("re_ref"));
				vo.setReLev(rs.getInt("re_lev"));
				vo.setReSeq(rs.getInt("re_seq"));
				vo.setState(rs.getInt("state"));
				
			} // while
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt, rs);
		}
		return vo;
	} // getnoticeboardByNum
	
	public boolean isPasswdCorrect(int num, String passwd) {
		boolean isCorrect =false;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		try {
			con = JdbcUtils.getConnection();
			
			sql  = "SELECT count(*) ";
			sql += "FROM noticeboard ";
			sql += " WHERE num=? ";

			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);

			
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
			
			sql  = " DELETE FROM noticeboard WHERE num = ? ";
			
			
			
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
	public void update(noticeboardVo vo) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "";
		
		try {
			con = JdbcUtils.getConnection();
			
			sql  = " UPDATE noticeboard ";
			sql  += " SET name= ?,subject=?,content =?,filename=? " ;
			sql  +=	"WHERE num =?";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, vo.getName());
			pstmt.setString(2, vo.getSubject());
			pstmt.setString(3, vo.getContent());
			pstmt.setString(4, vo.getFilename());
			pstmt.setInt(5, vo.getNum());
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
			
			sql = "UPDATE noticeboard ";
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
	
	public void updateStateByNum(int num,int state) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		String sql = "";
		
		try {
			con = JdbcUtils.getConnection();
			
			sql= "UPDATE noticeboard SET state=? WHERE num =?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, state);
			pstmt.setInt(2, num);
			pstmt.executeUpdate();
				
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		}
	
	}
	
	
	public static void main(String[] args) {
		
		NoticeDao dao = new NoticeDao();


		dao.deleteAll();
		
		// 주글 1000개 insert하기
		for (int i=0; i<12; i++) {
			noticeboardVo vo = new noticeboardVo();
			
			int num = dao.getNextNum();
			vo.setNum(num);
			vo.setName("운영자");
			vo.setSubject("2020년 "+ (i+1) +"월 소식지");
			vo.setContent((i+1) +"월 소식지 내용 입니다.");
			vo.setReadcount(0);
			vo.setRegDate(new Timestamp(System.currentTimeMillis()));
			vo.setReRef(num);
			vo.setReLev(0);
			vo.setReSeq(0);
			vo.setState(0);
			
			dao.add(vo); // insert
			System.out.println("입력!");
		} // for
		
		

		System.out.println("입력끝");
		//System.out.println("전체 레코드 갯수 : " + dao.countAll());
		
	} // main

}






