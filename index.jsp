<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="core" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Dynamic CRUD</title>
<!-- <script type="text/javascript" src="/js/bootstrap.min.js"></script> -->
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

<script>
	var request;
	function sendInfo() {
		var v = document.getElementById("total").value;
		var url = "index.jsp?val=" + v;

		if (window.XMLHttpRequest) {
			request = new XMLHttpRequest();
		} else if (window.ActiveXObject) {
			request = new ActiveXObject("Microsoft.XMLHTTP");
		}

		try {
			request.onreadystatechange = getInfo;
			request.open("GET", url, true);
			request.send();
		} catch (e) {
			alert("Unable to connect to server");
		}
	}

	function getInfo() {
		if (request.readyState == 4) {
			// 			var val = "${pageContext.request.getAttribute('tot')}";
			var t1 = '${t1}';
			var t2 = '${pageContext.request.getContextPath()}';
			var t3 = '${request.getAttribute("t1")}';
			//document.myform.load();
			console.log("t1 = "+ t3);
			//document.getElementById('test').innerHTML = val;
		}
	}
</script>
</head>
<body>
	<sql:setDataSource var="mySqlDS" driver="com.mysql.jdbc.Driver"
		url="jdbc:mysql://localhost:3306/sakila" user="root" password="root" />
	<sql:query var="rs" dataSource="${mySqlDS}">show tables</sql:query>


	<core:set var="alphabet">A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z</core:set>

	<core:forTokens items="${alphabet}" delims="," var="letter">
		<%--     ${letter} --%>
	</core:forTokens>
	<form name="myform">
		No of Colors in Table : <input id="total" type="number"
			name="totalColors" min="1" max="5" onchange="sendInfo()"> <span
			id="test"></span>
	</form>
	<%-- 	<core:set var="color">"table-primary", "table-secondary", "table-success", "table-danger", "table-warning", --%>
	<%-- 				"table-info" </core:set> --%>
	<%
		String colors[] = { "table-primary", "table-success", "table-warning", "table-info", "table-danger",
				"table-secondary" };
		int i = 1;
		int noOfColours = 5;
		if (request.getParameter("val") != null) {
			System.out.println("val = " + request.getParameter("val"));
			noOfColours = Integer.parseInt(request.getParameter("val"));

		}
		pageContext.setAttribute("tableColors", colors);
		pageContext.setAttribute("tot", noOfColours);
		request.setAttribute("t1", noOfColours);
		System.out.println("noOfColours = " + noOfColours);
	%>
	<core:set var="count" value="0"></core:set>
	<%-- 	<core:set var="color1" value="table-primary"></core:set> --%>
	<%-- 	<core:set var="color2" value="table-secondary"></core:set> --%>
	<%-- 	<core:set var="color3" value="table-success"></core:set> --%>
	<%-- 	<core:set var="color4" value="table-danger"></core:set> --%>
	<%-- 	<core:set var="color5" value="table-warning"></core:set> --%>
	<%-- 	<core:set var="color6" value="table-info"></core:set> --%>

	<div class="table-responsive container">
		<h1>Welcome to Dynamic CRUD Application</h1>
		<core:out value="${tot}">
		</core:out>
		<core:set var="c1" value="${tot}"></core:set>
		<table class="table table-sm table-hover table-striped table-bordered">
			<thead class="table-dark">
				<tr>
					<th>Table Name</th>
					<th>Actions</th>
				</tr>
			</thead>
			<tbody>
				<core:forEach var="table" items="${rs.rows}">
					<core:if test="${count>tot}">
						<core:set var="count" value="0"></core:set>
					</core:if>

					<%-- <core:out value="${count}"></core:out> --%>
					<%-- <core:out value="${tableColors[count]}"></core:out> --%>

					<tr class="${tableColors[count]}">
						<core:set var="count" value="${count+1}"></core:set>

						<td><core:out value="${table.table_name}"></core:out></td>
						<td><a href="viewTable.jsp?tName=${table.table_name}">
								View </a> | <a href="dropTable.jsp?tName=${table.table_name}">
								Delete </a></td>
						<%-- 					
						// System.out.println("color:" + colors[5 % i]); // i++; // if (i
						> 5) { // i = 1; // }
										 --%>
					</tr>
				</core:forEach>
			</tbody>
		</table>
	</div>
</body>
</html>