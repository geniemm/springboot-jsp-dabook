<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title> 베스트 셀러 </title>
</head>
<script>

</script>
<link rel="stylesheet" href="/css/book/bestSeller.css" />
<body>
<h4>베스트 셀러</h4><div class="wholeSpace">
    <div class="bookSpace">
        <div class="row">
            <c:forEach var="books" items="${books}">
                <div class="oneBookSpace">
                    <button type="submit" onclick="location.href=`/dabook/book?no=${books.no}`">
                        <img src="/images/bookImage/book${books.no}.jpg" alt="${books.bookName}"></button>
                    <div id="bookTitle">
                        <button type="submit" onclick="location.href=`/dabook/book?no=${books.no}`"> ${books.bookName}</button>
                    </div>
                    <div id="author">
                            ${books.author}
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</div>
</body>
</html>