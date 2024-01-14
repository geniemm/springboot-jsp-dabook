<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title> 전체 보기 </title>
</head>

<link rel="stylesheet" href="/css/book/allBook.css"/>
<script>
    // $.ajax({
    //     url:"dabook/allBook",
    //     type:"get",
    //     dataType:"json",
    //     success: viewBookList,
    //     error: function (){alert("오류가 발생했습니다.");}
    // });
    // }
    // function loadBookList(){

</script>
<body>
<h4>책 전체보기</h4>
<div class="wholeSpace">
    <div class="bookSpace">
        <div class="row">
            <c:forEach var="books" items="${books}" varStatus="rowStatus">
                <c:if test="${rowStatus.index % 6 ==0}">
                    <div class="oneBookLine">
                </c:if>
                <div class="oneBookSpace">
                    <button type="submit" onclick="location.href=`/dabook/book?no=${books.no}`">
                        <img src="/images/bookImage/book${books.no}.jpg" alt="${books.bookName}"></button>
                    <div id="bookTitle">
                        <button type="submit"
                                onclick="location.href=`/dabook/book?no=${books.no}`"> ${books.bookName}</button>
                    </div>
                    <div id="author">
                            ${books.author}
                    </div>
                </div>
                    <c:if test="${rowStatus.index % 6 == 5 or rowStatus.last}">
                        </div>
                    </c:if>
            </c:forEach>
        </div>
    </div>
</div>


</body>
</html>