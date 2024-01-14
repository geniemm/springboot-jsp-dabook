<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="/css/cart.css" />
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>장바구니</title>
</head>
<body>

<script>
    bookInfo = [{price : 8000, count: 1, totalPrice: 0}, {price : 10000, count: 1, totalPrice: 0}];

    window.onload = function() {
        initCart();

        var initPrice = firstPrice(); //18000
        var productPayElement = document.querySelector('.productPay');
        productPayElement.textContent = initPrice + '원';

        var chkbox = document.querySelectorAll('.chbox');

        chkbox.forEach(function(checkbox){
            checkbox.addEventListener('change', function(){
                updateCart();
            });
        });
    }

    function initCart(){
        updateCart();
    }

    function updateCart(){
        var totalPrice = 0;
        var totalProductCount = 0;

        for(var i=0; i<bookInfo.length; i++){
            if(document.querySelectorAll('.chbox')[i].checked){
                totalProduct(i);
                totalPrice += bookInfo[i].count * bookInfo[i].price;
                totalProductCount++;
            }
        }

        var productPayElement = document.querySelector('.productPay');
        var feeElement = document.querySelector('.fee');
        var allPriceElement = document.querySelector('.allPrice');

        productPayElement.textContent = totalPrice + '원';
        var fee = delivery(totalPrice);
        feeElement.textContent = fee + '원';

        var allPrice = totalPrice + fee;
        allPriceElement.textContent = allPrice + '원';

        updateProductCount(totalProductCount);
    }

    function minus(button, index){
        var countElement = button.nextElementSibling;
        var count = parseInt(countElement.textContent);

        if(count >= 2){
            count --;
            countElement.textContent = ' ' + count + ' ';

            bookInfo[index].count = count;
            var totalPrice =  bookInfo[index].count * bookInfo[index].price;
            bookInfo[index].totalPrice = totalPrice;

            var pay = document.querySelectorAll(".total-price")[index];
            pay.textContent = totalPrice + '원'

            totalProduct(index);
            updateCart();

            return pay;
        }else{
            alert("최소 구매 수량은 한개 입니다.");
        }
    }

    function plus(button, index){
        var countElement = button.previousElementSibling;
        var count = parseInt(countElement.textContent);

        count++;
        countElement.textContent =  ' ' + count + ' ';

        bookInfo[index].count = count;
        var totalPrice =  bookInfo[index].count * bookInfo[index].price;
        bookInfo[index].totalPrice = totalPrice;

        var pay = document.querySelectorAll(".total-price")[index];
        pay.textContent = totalPrice + '원';

        totalProduct(index);
        updateCart();

        return pay;
    }

    function totalProduct(index) { //총 금액

        var div = document.querySelectorAll('.a-div')[index];

        var chkbox = div.querySelector('.chbox');
        var totalPriceElement = div.querySelector('.total-price');
        var productPay = document.querySelector('.productPay');

        if (chkbox.checked) {
            var nowPay = 0;
            for(var i = 0; i <= index; i++){
                nowPay += bookInfo[i].price * bookInfo[i].count;
            }
            productPay.textContent = nowPay + '원'; //nowPay:18000

            delivery(nowPay);
            return nowPay;
        }
    }

    function delivery(nowPay){ //배송비
        var fee = 0;
        if(nowPay >= 30000) fee = 0;
        else fee = 3000;

        return fee;
    }

    function updateProductCount(count){ //상품 개수
        var text = document.querySelector('.productCount');
        text.innerHTML = '총 주문상품' + count + '개';
    }

    function firstPrice(){ //처음 상품금액
        var initPrice = 0;
        for(var i = 0; i< bookInfo.length; i++){
            initPrice += bookInfo[i].count * bookInfo[i].price;
        }
        return initPrice;
    }





</script>

    <div class="cart-goods-div">
        <h2>장바구니</h2>

        <div class="goods-div">

            <div class="a-div">
                <input type="checkbox" class="chbox" checked >
                <div>
                    <img class="img-class" src="/images/cartImage/곰돌이.jpg" alt="">
                </div>
                <div class="goods-title">
                    <span class="title-fontsize">책이름</span><br><br>
                    <span class="price" data-price="8000">8000원</span>
                </div>
                <div class="volume-div">
                    <span class="total-price">8000원</span><br><br>
                    <div class="volume">
                        <button class="volume-btn" onclick="minus(this, 0)" >-</button>
                        <span class="count" >&nbsp;1&nbsp;</span>
                        <button class="volume-btn" onclick="plus(this, 0)" >+</button>
                    </div>
                </div>
            </div>

            <div class="a-div">
                <input type="checkbox" class="chbox" checked  >
                <div>
                    <img class="img-class" src="/images/cartImage/곰돌이.jpg" alt="">
                </div>
                <div class="goods-title">
                    <span class="title-fontsize">책이름</span><br><br>
                    <span class="price" data-price="10000">10000원</span>
                </div>
                <div class="volume-div">
                    <span class="total-price">10000원</span><br><br>
                    <div class="volume">
                        <button class="volume-btn" onclick="minus(this, 1)" >-</button>
                        <span class="count" >&nbsp;1&nbsp;</span>
                        <button class="volume-btn" onclick="plus(this, 1)" >+</button>
                    </div>
                </div>
            </div>

        </div>


        <div class="free-delivery">
            <span>3만원 이상 구매시 무료배송</span>
        </div>

        <div class="goods-count">
            <span class="productCount"></span>
        </div>

        <div class="pay-count">
            <div class="pay-count-div">
                <div class="pay-number">
                    <span class="productPay">0원</span>
                    <span>+</span>
                    <span class="fee">0원</span>
                    <span>=</span>
                    <span class="allPrice">0원</span>
                </div>
                <div class="pay-text">
                    <span>상품금액</span>
                    <span></span>
                    <span>배송비</span>
                    <span></span>
                    <span>총 금액</span>
                </div>
            </div>
        </div>
    </div>

    <div class="order-btn">
        <button class="order-button" onclick="location.href='/user/pay'">주문하기</button>
    </div>


</body>
</html>