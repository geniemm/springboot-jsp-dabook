<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<%@ include file="../default/style.jsp"%>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>지금 이 책</title>
</head>
<body>
<jsp:include page="../main/header.jsp" />
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="/css/book/nowBook.css"/>
<div class="topSpace">
<h3 class="pageTitle"><b class="title">지금 이 책</b><br>
새롭게 등록된 신상품 중 추천하는 리스트입니다.</h3></div>
<div class="wholeSpace">
    <div class="w3-content">
        <c:forEach var="book" items="${books}" varStatus="b" begin="0" end="2">
            <div class="mainContent">
                <c:if test="${b.index == 0}">
                    <a href="/dabook/book?no=${book.no}" class="nowBookInfo">
                        <img class="mySlides" src="/images/bookImage/book${book.no}.jpg"></a>
                    <div class="bookInfoSpace">
                        <div class="bookName"><b>${book.bookName}</b></div>
                        <div class="authorAndPublisher">${book.author} · ${book.publisher}</div>
                        <div class="bookPrice">${book.price}원</div>
                        <div class="bookReference"><b>내마음에도 체력이 필요해</b><br>
                        <p>정신과 전문의 윤횽균저자가 어쩌고저쩌고 추천하는책!</p></div>
                    </div>
                </c:if>
                <c:if test="${b.index != 0}">
                <a href="/dabook/book?no=${book.no}" class="nowBookInfo">
                    <img class="mySlides" src="/images/bookImage/book${book.no}.jpg" style="display: none"></a>
                <div class="bookInfoSpace" style="display: none">
                    <div class="bookName"><b>${book.bookName}</b></div>
                    <div class="authorAndPublisher">${book.author} · ${book.publisher}</div>
                    <div class="bookPrice">${book.price}원</div>
                    <div class="bookReference"><b>내마음에도 체력이 필요해</b><br>
                        <p>정신과 전문의 윤횽균저자가 어쩌고저쩌고 추천하는책!</p></div>
                </div>
                </c:if>
            </div>
        </c:forEach>
        <div class="w3-row-padding w3-section">
            <c:forEach var="book" items="${books}" varStatus="b" begin="0" end="2">
                <div class="w3-col s4">
                    <img class="demo w3-opacity w3-hover-opacity-off" src="/images/bookImage/book${book.no}.jpg" style="height: 200px; width: 140px" onclick="currentDiv(${b.index + 1})">
                </div>
            </c:forEach>
        </div>
    </div>
</div>
<div class="nowBookRow">
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
                            <button type="submit" onclick="location.href=`/dabook/book?no=${books.no}`"> ${books.bookName}</button>
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
<jsp:include page="../main/footer.jsp" />
</body>
<script>
    function currentDiv(n) {
        showDivs(slideIndex = n);
    }

    function showDivs(n) {
        var i;
        var x = document.getElementsByClassName("mySlides");
        var dots = document.getElementsByClassName("demo");
        var bookInfo = document.getElementsByClassName("bookInfoSpace");

        if (n > x.length) { slideIndex = 1 }
        if (n < 1) { slideIndex = x.length }

        for (i = 0; i < x.length; i++) {
            x[i].style.display = "none";
            bookInfo[i].style.display = "none"; // 숨기기
        }

        for (i = 0; i < dots.length; i++) {
            dots[i].className = dots[i].className.replace(" w3-opacity-off", "");
        }

        x[slideIndex-1].style.display = "block";
        dots[slideIndex-1].className += " w3-opacity-off";
        bookInfo[slideIndex-1].style.display = "block"; // 선택된 책 정보 표시
    }
</script>
</html>