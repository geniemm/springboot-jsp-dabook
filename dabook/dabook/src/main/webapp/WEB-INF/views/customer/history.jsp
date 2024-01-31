<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>구매내역</title>
</head>
<%@ include file="../default/style.jsp" %>
<link rel="stylesheet" href="/css/main/history.css"/>

<body>
<jsp:include page="../main/header.jsp"/>
<div class="wholeSpace">
    <h3><b>구매내역</b></h3>
    <div class="historySpace">
        <div class="historyTitle">
            <span class="title" id="title1">주문일</span>
            <span class="title" id="title2">주문내역</span>
            <span class="title" id="title3">주문번호</span>
            <span class="title" id="title4">주문상태</span>
            <span class="title" id="title5">결제금액</span>
        </div>
        <c:choose>
            <c:when test="${empty orders}">
                <div class="historyContent">
                    <span class="noContent"><b>구매내역이 없습니다</b></span>
                </div>
            </c:when>
            <c:otherwise>
                <c:forEach var="order" items="${orders}" varStatus="loop">
                    <div class="historyContent">
        <span class="content" id="orderDateSpan-${loop.index}">
                ${order.orderDate}</span>
                        <span class="content" id="content2">
            <a href="/dabook/user/order/historyDetail?no=${order.no}">
                <b>${order.orderHistory.get(0).getBooks().getBookName()} 외 ${order.orderHistory.size() - 1} 건</b>
        </a></span>
                        <span class="content" id="content3">${order.no}</span>
                        <span class="content" id="content4"> <c:choose>
                            <c:when test="${order.orderStatus eq 'READY'}">
                                상품준비
                            </c:when>
                            <c:when test="${order.orderStatus eq 'CANCEL'}">
                                주문취소
                            </c:when>
                            <c:when test="${order.orderStatus eq 'COMP'}">
                                주문완료
                            </c:when>
                            <c:otherwise>기타 상태

                            </c:otherwise>
                        </c:choose></span>
                        <span class="content" id="content5">
                            ${order.totalPrice}원
                        </span>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>
</div>
<jsp:include page="../main/footer.jsp"/>
</body>
<script>
    for (var i = 0; i <${orders.size()}; i++) {
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