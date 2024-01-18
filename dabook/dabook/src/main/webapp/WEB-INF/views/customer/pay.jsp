<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<%@ include file="../default/style.jsp"%>
<head>
    <link rel="stylesheet" href="/css/pay.css" />
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>결제</title>

    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script src="/js/daumPost.js"></script>

    <script>

    function check(chk){
        var buyerName = document.getElementById("buyerName"); //이재원
        var buyerPhone = document.getElementById("buyerPhone"); //010-4586-2667

        var deliveryName = document.getElementById("deliveryName"); //받는 사람
        var deliveryPhone = document.getElementById("deliveryPhone"); //전화번호

        if(chk.checked){
            deliveryName.value = buyerName.innerText;
            deliveryPhone.value = buyerPhone.innerText;
        }else{
            deliveryName.value = "";
            deliveryPhone.value = "";
        }

    }
    </script>

</head>
<body>

    <div class="pay">
        <h2>주문/결제하기</h2>
        <br>
        <div class="pay-div">

                <span class="font-span">주문 상품 정보</span>
                <div class="product-div">
                    <div class="product-name">
                        <div class="mini">책 이름1</div>
                    </div>
                    <div class="product-price">
                        <div class="mini">18000원</div>
                    </div>
                </div>
                <br><br>

                <input type="checkbox" name="chk" onclick="check(this)" >배송지 정보 동일
                <div>
                    <span class="font-span">구매자 정보</span> <br>
                    <div class="buyer-div">
                        <div class="buyer">
                            <div class="mini" >이름</div>
                            <div class="mini">전화번호</div>
                        </div>
                        <div class="buyer-info">
                            <div class="mini" name="buyerName" id="buyerName" value="이재원">이재원</div>
                            <div class="mini" name="buyerPhone" id="buyerPhone" value="010-4586-2667">010-4586-2667</div>
                        </div>
                    </div>
                </div>
                <br><br>

                <div>
                    <span class="font-span">배송지 정보</span>
                    <div class="delivery">
                        <div class="delivery-api">



                        </div>
                        <div class="delivery-div">
                            <div class="receiver">
                                <div class="mini">받는 사람</div>
                                <div class="mini">전화번호</div>
                                <div class="mini">우편번호</div>
                                <div class="mini">주소</div>
                                <div class="mini">상세주소</div>
                            </div>
                            <div class="receiver-info">
                                <div class="mini">
                                    <input type="text" class="inputC" name="deliveryName" id="deliveryName" placeholder="받는 사람 이름" >
                                </div>
                                <div class="mini">
                                    <input type="text" class="inputC" name="deliveryPhone"  id="deliveryPhone" placeholder="받는 사람 전화번호" >
                                </div>

                                <div class="postNum">
                                    <div >
                                        <input type="text" class="inputC" name="addr" readonly id="zipcode" placeholder="input post" required>
                                    </div>
                                    <div >
                                        <input type="button" onclick="daumPost()" value="우편번호 검색" required>
                                    </div>
                                </div>
                                <div class="mini">
                                    <input type="text" class="inputC" name="addr" readonly id="address" placeholder="input Addr" required>
                                </div>
                                <div class="mini">
                                    <input type="text" class="inputC" name="addr" id="addressDetail" placeholder="input extra Addr" required>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
                <br><br>

                <div>
                    <span class="font-span">결제수단</span>
                    <div class="pay-type">
                        <ul>
                            <li>Npay</li>
                            <li>Kakao pay</li>
                            <li>일반결제</li>
                        </ul>
                    </div>
                </div>
                <br>

                <div class="btn-div">
                    <button class="pat-btn">결제하기</button>
                </div>

        </div>
    </div>

</body>
</html>