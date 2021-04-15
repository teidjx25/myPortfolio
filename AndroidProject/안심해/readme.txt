본 프로젝트는 스프링 boot로 작성되었음
자바 ver 1.8
사용 DB :MYSQL

프로젝트 실행하는 법

1.mysql 계정 생성 sql문 실행 
1-1. 해당계정에 csv파일 전부 import해서 테이블을 생성한다


2. 스프링 부트 프로젝트 실행 (android_conn)


3. 안드로이드 : MySQLLoadActivity에서 final String ip값 본인의 아이피로 수정


4. 현재 안된 작업->등급 테이블 부재로 안전 등급 안불러옴, 취약지점 좌표 테이블 부재로 랜덤으로 값 찍음
