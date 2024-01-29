<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>구매내역정보</title>
</head>
<%@ include file="../default/style.jsp" %>
<link rel="stylesheet" href="/css/main/historyDetail.css"/>
<body>
<jsp:include page="../main/header.jsp"/>
<div class="wholeSpace">
    <h3><b>구매내역정보</b></h3>
    <div class="detailSpace">
        <c:forEach var="orderHistory" begin="0" end="0" items="${orderHistories}" varStatus="loop">
            <div class="detailTitle">
                <span class="title" id="orderDateSpan-${loop.index}">${orderHistory.orders.orderDate}</span>
                <span class="title" id="orderNo">${orderHistory.orders.no}</span>
            </div>
        </c:forEach>
        <c:forEach var="orderHistory" items="${orderHistories}" varStatus="loop">
            <div class="detailContent">
                <span class="content" id="imgContent"><a href="/dabook/book?no=${orderHistory.books.no}">
                    <img src="/images/bookImage/book${orderHistory.books.no}.jpg" alt="책사진" class="content" id="bookImg"></a></span>
                <div class="content" id="bookName">
                    <a href="/dabook/book?no=${orderHistory.books.no}">
                    <b>${orderHistory.books.bookName}</b>
                    </a>
                <br>
             <span class="content" id="bookInfo">${orderHistory.books.author} / ${orderHistory.books.publisher}</span>
            </div>
                <span class="content" id="price">${orderHistory.books.price}원</span>
            </div>
        </c:forEach>
    </div>
</div>
<jsp:include page="../main/footer.jsp"/>
</body>
<script>
    for (var i = 0; i <${orderHistories.size()}; i++) {
        var orderDateSpan = document.getElementById('orderDateSpan-' + i);
        if (orderDateSpan) {
            var orderDate = orderDateSpan.innerText;
            var datePart = orderDate.split('T')[0].replace(/-/g, '.');
            orderDateSpan.innerText = datePart;
        } else {
            console.error('오류발생');
        }
    }
</script>
</html>