<%@page import="java.io.PrintWriter"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSetMetaData"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>ViewTable</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
	crossorigin="anonymous">

<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
	integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
	crossorigin="anonymous"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
	integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
	crossorigin="anonymous"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
	integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
	crossorigin="anonymous"></script>
</head>
<body>
	<%
		String tableName = request.getParameter("tName");
		pageContext.setAttribute("table", tableName);
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		ResultSetMetaData rsmd = null;
		String query = "select * from ";
		response.setContentType("text/html");
		String colors[] = {  "table-danger", "table-warning","table-info", "table-success", "table-info",
				"table-secondary", "table-primary" };
		int a = 0;

		try {
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/sakila", "root", "root");
			stmt = conn.createStatement();
			rs = stmt.executeQuery(query + tableName);
			rsmd = rs.getMetaData();
			int columnCount = rsmd.getColumnCount();
			out.println("<div class='container'> <h3>" + tableName.toUpperCase() + " Table Contents </h3>");
			out.print(
					"<table border='1' class='table-sm table-striped table-hover'><thead class='table-dark'><tr>");
			for (int i = 1; i <= columnCount; i++) {
				out.print("<th>" + rsmd.getColumnName(i) + "</th>");
			}
			out.println("</tr> </thead><tbody>");
			while (rs.next()) {
				out.println("<tr class='" + colors[a] + "'>");
				if (a == 1)
					a = 0;
				else 
					a = 1;

				for (int i = 1; i <= columnCount; i++) {
					out.print("<td>" + rs.getString(i) + "</td>");
				}
				out.println("</tr>");
			}
			out.print("</tbody></table> </div>");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null)
				rs.close();
			if (stmt != null)
				stmt.close();
			if (conn != null)
				conn.close();
		}
	%>
	<core:set var="count" value="0"></core:set>

</body>
</html>