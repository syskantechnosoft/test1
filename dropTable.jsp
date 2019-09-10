<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="core" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Drop Table</title>
</head>
<body>
	<sql:setDataSource var="mySqlDS" driver="com.mysql.jdbc.Driver"
		url="jdbc:mysql://localhost:3306/sakila" user="root" password="root" />
	<%
		String tableName = request.getParameter("tName");
		pageContext.setAttribute("tab_name", tableName);
	%>
	<sql:update var="count" dataSource="${mySqlDS}">drop table ${tab_name}</sql:update>
	<core:redirect url="index.jsp"></core:redirect>
</body>
</html>