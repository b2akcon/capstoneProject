<%@ page import="java.sql.*"%>
<%@page import="java.util.regex.Pattern"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>게시판 만들기</title>
<style type="text/css">
 
    table, td, th   {
    border:1px solid purple;
    }
    th{
    background-color:purple;
    color:white;
    }

</style>
</head>
<%
try {
	 
    String driverName = "oracle.jdbc.driver.OracleDriver"; //데이터베이스에 접속하기위한 드라이버를 로드
    String url = "jdbc:oracle:thin:@localhost:1521:orcl";   //접속 URL정보와 포트번호(oracle포트), sid(oracle버전)
    ResultSet rs = null;
    Class.forName(driverName);
    Connection con = DriverManager.getConnection(url,"board","board");
    out.println("Oracle Database Connection Success.");
    Statement stmt = con.createStatement();        
    String sql = "select * from board order by idx desc";
    rs = stmt.executeQuery(sql);
%>

<body>
<h1>게시글</h1>
	<table>
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>날짜</th>
			<th>조회수</th>
		</tr>
<%
	while(rs.next()){
		out.print("<tr>");
		out.print("<td>" + rs.getString("idx") + "</td>");
		out.print("<td> <a href='content.jsp'>" + rs.getString("title") + "</a></td>");
		out.print("<td>" + rs.getString("writer") + "</td>");
		out.print("<td>" + rs.getString("regdate") + "</td>");
		out.print("<td>" + rs.getString("count") + "</td>");
		out.print("</tr>");
	}
%>		
	</table>
	<a href="write.jsp">글쓰기</a>
<%
con.close();

}catch (Exception e) {
    out.println("Oracle Database Connection Something Problem. <hr>");
    out.println(e.getMessage());
    e.printStackTrace();

}
%>
</body>
</html>
