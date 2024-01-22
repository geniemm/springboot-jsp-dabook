<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<%@ include file="../default/style.jsp" %>

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

<link rel="stylesheet" href="/css/book/bookInfo.css"/>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css">
<body>
<jsp:include page="../main/header.jsp" />
<div class="bookInfoSpace">
    <div class="bookImg">
        <img src="/images/bookImage/${book.bookDetail.photo}.jpg" alt="${book.bookName}">
    </div>
    <div class="text">
        <div class="title">
            <b>${book.bookName}</b>
        </div>
        <div class="info">
            ${book.author}  &nbsp;|&nbsp;  ${book.publisher}  &nbsp;|&nbsp;&nbsp;  <div id="publishDateSpan">${book.publishDate}</div>
        </div>
        <div class="price">
            <b>${book.price}</b>원
        </div>
        <div class="count">
            주문수량&nbsp;&nbsp;
            <button class="btn-count" onclick="changeQuantity(-1)">-</button>&nbsp;&nbsp;&nbsp;
            <span id="quantity">0</span>&nbsp;&nbsp;&nbsp;
            <button class="btn-count" onclick="changeQuantity(1)">+</button>
        </div>
        <div class="cart">
            <button class="cartBtn" onclick="">장바구니</button>&nbsp;&nbsp;
            <button class="payBtn" onclick="">바로구매</button>
        </div>
    </div>
</div>
<div class="bookInfoContent">
    <input type="radio" id="bookDetail" name="show" checked/>
    <input type="radio" id="bookReview" name="show"/>
    <div class="tab">
        <label for="bookDetail">상세내용</label>
        <label for="bookReview">REVIEW</label>
    </div>
    <div class="content">
        <div class="content-bookDetail">
            <img src="/images/bookContent/${book.bookDetail.content}.jpg" alt="${book.bookName}">
        </div>
        <div id="reviewContainer">
        </div>
    </div>
</div>
<jsp:include page="../main/footer.jsp" />
</body>
<script>
    var publishDateSpan = document.getElementById('publishDateSpan');
    if(publishDateSpan){
        var publishDate = publishDateSpan.innerText;
        var datePart = publishDate.split('T')[0];
        publishDateSpan.innerText = datePart;
    }else{
        console.error('오류발생');
    }
</script>
<script>
    $(document).ready(function() {
        $('input[name="show"]').change(function() {

            var selectedTabId = $('input[name="show"]:checked').attr('id');

            // bookReview가 선택되었을 때만 AJAX로 review.jsp를 불러옴
            if (selectedTabId === 'bookReview') {
                $.ajax({
                    url: '/dabook/review?no='+${book.no},
                    type: 'GET',
                    success: function(response) {
                        $('#reviewContainer').html(response);
                    },
                    error: function(error) {
                        console.error('Error loading review:', error);
                    }
                });
            } else {
                // 다른 탭이 선택되었을 때, reviewContainer를 비움
                $('#reviewContainer').empty();
            }
        });
    });
</script>
</html>