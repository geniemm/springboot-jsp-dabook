<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<%@ include file="../default/style.jsp"%>
<head>
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
    <title> book </title>
</head>

<script>
    let quantity = 0;

    function changeQuantity(amount) {
        // 수량이 음수가 되지 않도록 체크
        if (quantity + amount >= 0) {
            quantity += amount;
            document.getElementById('quantity').innerText = quantity;
        }
    }

    $.ajax({
        url: "/cart",
        method: "POST",
        data: {
            quantity: parseInt($("#quantity").text())
        },
        success: function (response) {
            console.log("Ajax request successful:", response);
        },
        error: function (error) {
            console.error("Ajax request failed:", error);
        }
    });
</script>
<script>
    function detailAjax(no){
    console.log(no);
    const view = document.getElementById('bookDetail');
    $.ajax({
        type:'get',
        url:'detailAjax',
        data:{'no':no},
        dataType: 'json',
        success: function(result){
            let output = "<div>";
            output += "<img src='/images/bookContent/${book.bookDetail.content}.jpg' alt="${book.bookName}">";
            output += "</div>";
            view.innerHTML = output;
        },
        error: function (){
            console.log('오류발생');
        }
    });
    }
</script>
<link rel="stylesheet" href="/css/book/bookInfo.css" />
<body>
    <div class="bookInfoSpace">
        <div class="bookImg">
            <img src="/images/bookImage/${book.bookDetail.photo}.jpg" alt="${book.bookName}">
        </div>
        <div class="text">
            <div class="title">
                ${book.bookName}
            </div>
            <div class="info">
                ${book.author} | ${book.publisher} | ${book.publishDate}
            </div>
            <div class="price">
                ${book.price} 원
            </div>
            <div class="count">
                주문수량&nbsp;&nbsp;
                <button class="btn-count" onclick="changeQuantity(-1)">-</button>&nbsp;&nbsp;&nbsp;
                <span id="quantity">0</span>&nbsp;&nbsp;&nbsp;
                <button class="btn-count" onclick="changeQuantity(1)">+</button>
            </div>
            <div class="cart">
                <button class="btn btn-light" onclick="">장바구니</button>&nbsp;&nbsp;
                <button class="btn btn-primary" onclick="">바로구매</button>
            </div>
        </div>
    </div>
<div class="bookInfoContent">
    <button>리뷰</button>
    <button class="btn" onclick="detailAjax('${book.no}')">상세보기</button>
    <div id="bookDetail">

    </div>

</div>
</body>
</html>