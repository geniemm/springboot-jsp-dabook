<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title> 전체 보기 </title>
</head>
<link rel="stylesheet" href="/css/book/allBook.css" />
<body>
<h4>책 전체보기</h4>
<div class="wholeSpace">
    <div>
        <c:forEach var="books" items="${sessionScope.Map}">
            <c:forEach var="book" items="${books.key}">
                <c:out value="${Map[book].value}" />
            </c:forEach>
        </c:forEach>

    </div>
</div>


</body>
</html>