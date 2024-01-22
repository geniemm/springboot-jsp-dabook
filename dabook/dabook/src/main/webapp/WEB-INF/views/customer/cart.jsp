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
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script>

    var CartData = ${list};


    // 페이지 로드시 바로 적용
    window.onload = function (){
        itemAll();
    }

    // doc checked 상품 정보 (수량,가격,배송비)
    function itemAll(){
        var count = 0;
        var price = 0;
        var fee = 0;

        for(var i=0; i < CartData.length; i++){
            if(document.querySelectorAll('.chkBuy')[i].checked) {
                count += CartData[i].bookCount;
                price += CartData[i].total;
            }
        }
        if (price < 30000){
            fee = 3000;
        }

        var chkCount = document.querySelector('.productCount');
        chkCount.textContent = '총 주문 수량 ' + count + ' 개';

        var chkPrice = document.querySelector('.productPay');
        chkPrice.textContent = price + ' 원';

        var delivery = document.querySelector('.fee');
        delivery.textContent = fee + '원';

        var allPrice = price + fee;

        var itemAllPrice = document.querySelector('.allPrice');
        itemAllPrice.textContent = allPrice + ' 원';
    }

    // 상품 전체 선택/해제
    function checkedAll(){
        var checkboxes = document.querySelectorAll('.chkBuy');
        var status = document.querySelector('.checkedAll').checked;

        checkboxes.forEach(function(checkbox) {
            checkbox.checked = status;
        });
        itemAll();
    }

    // (-)버튼 눌렸을 시 수량 check
    function docCount(index, action) {
        let isCount = CartData[index].bookCount;
        if (action == 'decrease') {
            return isCount >= 2;
        } else {
            return true;
        }
    }

    // 수량 업데이트 db에 저장
    function countUpdate(cartNo, action, index){
        if(docCount(index, action)){
            $.ajax({
                url: '/countUpdate/' + cartNo,
                type: 'put',
                data: {
                    cartNo : cartNo,
                    action: action
                },
                success: function (){
                    console.log('업데이트 성공');
                    reloadUpdate(index);
                },
                error: function (err){
                    console.log('업데이트 실패: ', err);
                }
            });
        }else {
            alert('최소 구매 수량은 1개 입니다.');
        }
    }

    // 수량 update 후 data reload
    function reloadUpdate(index) {
        $.ajax({
            url: '/cart/data/1',
            type: 'get',
            success: function (data) {
                console.log('리로드 성공: ', data);
                CartData = data;
                docUpdate(index);
            },
            error: function (err){
                console.log('리로드 실패', err);
            }
        });
    }

    // doc 해당 수량 및 상품 총 가격 변경
    function docUpdate(index){

        itemAll();

        console.log('실행: ', index);
        var cartItem = document.querySelectorAll('.a-div')[index];

        let updateTotal = cartItem.querySelector('.total-price');
        updateTotal.textContent = CartData[index].total + ' 원';
        console.log("docUpdateTotal: ", CartData[index].total);

        let updateCount = cartItem.querySelector('.count');
        updateCount.textContent = ' ' + CartData[index].bookCount + ' ';
    }



    // checked 상품 번호 가져오기
    function docChkItems(){
        var del = document.querySelectorAll('.chkBuy');
        var list = [];
        for(var i=0; i<CartData.length; i++){
            if (del[i].checked){
                list.push(CartData[i].cartNo);
            }
        }
        console.log(list);
        return list;
    }

    // 해당 상품 삭제 confirm
    function delItem(cartNo, index){
        confirm('정말로 삭제하시겠습니까?') && delCart(cartNo, index);
    }

    // DB 해당 상품 삭제
    function delCart(cartNo, index){
        console.log("삭제할 cartNo: ", cartNo);
        $.ajax({
            url: '/delCartItem/' + cartNo,
            type: 'delete',
            data: cartNo,
            success: function (data) {
                console.log('삭제 성공 : ', data);
                reloadDelelte(index);                // 데이터 리로드
            },
            error: function (xhr, status, error){
                console.error('실패: ', error);
            }
        });
    }

    // 삭제 후 데이터 reload
    function reloadDelelte(index) {
        $.ajax({
            url: '/cart/data/1',
            type: 'get',
            success: function (data) {
                console.log('리로드 성공');
                CartData = data;
                docItemDelete(index);           // doc 삭제
            },
            error: function (err){
                console.log('리로드 실패', err);
            }
        });
    }

    // doc 삭제
    function  docItemDelete(index){
        console.log('해당 doc index: ', index);
        var cartItem = document.querySelectorAll('.a-div')[index];
        if (cartItem) {
            cartItem.remove();
            console.log('doc 삭제 성공');
            itemAll();                      // chk 된 상품 정보
        }else {
            console.log('doc 존재 안함');
        }
    }

    // checked 상품 db에서 삭제
    function chkDel(){
        var delList = docChkItems();

        $.ajax({
            url: '/cart/chkDel',
            type: 'delete',
            contentType: 'application/json',
            data: JSON.stringify({
                data: delList
            }),
            success: function (data){
                console.log('성공: ', data);
                reloadChkDel(delList);
            },
            error: function (err){
                console.log('실패: ', err);
            }
        })
    }

    // checked 상품 삭제 후 data,page reload
    function reloadChkDel(){
        $.ajax({
            url: '/cart/data/1',
            type: 'get',
            success: function (data) {
                console.log('리로드 성공');
                CartData = data;
                location.reload();  // 선택 삭제 후 페이지 리로드
            },
            error: function (err){
                console.log('리로드 실패', err);
            }
        });
    }

</script>

<jsp:include page="../main/header.jsp" />

    <div class="cart-goods-div">
        <h2 class="mb-5 mt-5">장바구니</h2>

        <div class="goods-div">

            <div class="emptyline"></div>

            <div class="selectBy mt-1 mb-1">
                <div class="chkAll">
                    <input type="checkbox" class="checkedAll" onclick="checkedAll()" checked> 전체 선택
                </div>
                <div class="chkDel">
                    <button class="btn btn-secondary" onclick="chkDel()"> 선택 삭제 </button>
                </div>
            </div>

            <c:if test="${not empty data}">
                <c:forEach var="data" items="${data}" varStatus="status">

                    <div class="line"></div>

                <div class="a-div">
                    <input type="checkbox" class="chkBuy" onclick="itemAll()" checked >
                    <div>
                        <img class="img-class" src="/images/cartImage/곰돌이.jpg" alt="- 이미지 -">
                    </div>
                    <div class="goods-title">
                        <span class="title-fontsize">${data.bookName}</span><br><br>
                        <span class="price">${data.bookPrice}</span>
                    </div>
                    <div class="volume-div">
                        <span class="total-price">${data.total} 원</span><br><br>

                        <div class="volume">
                            <button class="btn btn-secondary volume-btn"
                                    onclick="countUpdate(${data.cartNo}, 'decrease', ${status.index})">-</button>

                                <span class="count">&nbsp;${data.bookCount}&nbsp;</span>

                            <button class="btn btn-secondary volume-btn"
                                    onclick="countUpdate(${data.cartNo}, 'increase', ${status.index})">+</button>
                        </div>

                        <button class="btn btn-outline-secondary delete mt-3" onclick="delItem(${data.cartNo}, ${status.index})">삭제</button>
                    </div>
                </div>
                </c:forEach>
            </c:if>
            <c:if test="${empty data}">

                <div class="emptyline"></div>
                <div class="a-div">
                    <div class="emptyCart">
                        <span> 텅 ~ </span>
                    </div>
                </div>
            </c:if>
        </div>

        <div class="isLine">
            <div class="goods-count">
                <span class="productCount"></span>
            </div>
            <div class="free-delivery">
                <span class="feePrice">※ 3만원 이상 구매시 무료배송 ※</span>
            </div>
        </div>


        <div class="pay-count">
            <div class="pay-count-div">
                <div class="pay-number">
                    <span class="productPay"></span>
                    <span>+</span>
                    <span class="fee"></span>
                    <span>=</span>
                    <span class="allPrice"></span>
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
        <button class="btn btn-outline-success order-button mt-5" onclick="location.href='/user/pay'">주문하기</button>
    </div>
<br />
<br />
<br />
<br />
<jsp:include page="../main/footer.jsp" />


</body>
</html>