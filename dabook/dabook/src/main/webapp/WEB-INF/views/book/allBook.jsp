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
</script>
<body>
<jsp:include page="../main/header.jsp" />
<div class="topSpace">
    <h3 class="pageTitle"><b class="title">BOOK</b><br>
        DABOOK에 등록된 모든책을 보여드립니다.</h3></div>
<div class="wholeSpace">
    <div class="bookSpace">
        <div class="row">
            <c:forEach var="books" items="${books}" varStatus="rowStatus">
                <c:if test="${rowStatus.index % 5 ==0}">
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
                    <c:if test="${rowStatus.index % 5 == 4 or rowStatus.last}">
                        </div>
                    </c:if>
            </c:forEach>
        </div>
    </div>
        <!-- Pagination -->
        <div class="bottomSpace">
        <div class="pagination" style="text-align:center; margin-left: 15px" >
            <c:if test="${currentPage > 1}">
                <a href="/dabook/allBook?page=${currentPage - 2}&size=${size}" style="border: none">&laquo;</a>
            </c:if>
            <c:forEach var="i" begin="1" end="${totalPages}">
                <c:choose>
                    <c:when test="${currentPage eq i}">
                        <a class="active" href="#">${i}</a>
                    </c:when>
                    <c:otherwise>
                        <a href="/dabook/allBook?page=${i-1}&size=${size}">${i}</a>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
            <c:if test="${currentPage < totalPages}">
                <a href="/dabook/allBook?page=${currentPage}&size=${size}" style="border: none">&raquo;</a>
            </c:if>
        </div>
        </div>
</div>

<jsp:include page="../main/footer.jsp" />
</body>
<script>
    // 좌측 화살표 클릭 시 이전 페이지로 이동
    document.querySelector('.pagination a[href*="page=' + (currentPage - 1) + '"]').onclick = function () {
        if (currentPage >= 0) {
            window.location.href = '/dabook/allBook?page=' + (currentPage - 1) + '&size=' + ${size};
        }
    };

    // 우측 화살표 클릭 시 다음 페이지로 이동
    document.querySelector('.pagination a[href*="page=' + (currentPage + 1) + '"]').onclick = function () {
        if (currentPage <= totalPages - 1) {
            window.location.href = '/dabook/allBook?page=' + (currentPage + 1) + '&size=' + ${size};
        }
    };
</script>
</html>