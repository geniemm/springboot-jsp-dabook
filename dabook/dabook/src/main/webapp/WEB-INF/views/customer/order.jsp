<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<%@ include file="../default/style.jsp" %>
<head>
    <link rel="stylesheet" href="/css/order.css"/>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>결제</title>

    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script src="/js/daumPost.js"></script>

    <script>

        var itemList = ${list};

        function check(chk){
            let same = document.querySelector('.sameInfo');

            if (chk.checked) {
                same.style.display = 'none';
            } else {
                same.style.display = 'block';
            }
        }

    </script>

</head>
<body>

<jsp:include page="../main/header.jsp" />

    <div class="pay">
        <h2 class="mb-5 mt-5">주문/결제하기</h2>

        <div class="pay-div">

            <div class="mb-2">
                <span class="font-span">주문 상품 정보</span>
            </div>

            <div class="cartList mb-5 mt-3">
                <c:if test="${not empty items}">
                    <c:forEach var="list" items="${items}">
                        <div class="product-div">
                            <div class="product-name">
                                <div>${list.bookName}</div>
                            </div>
                            <div class="product-count">
                                <div>${list.bookCount}</div>
                            </div>
                            <div class="product-price">
                                <div>${list.total}</div>
                            </div>
                        </div>
                    </c:forEach>
                </c:if>
            </div>


            <div class="chkInfo mt-5">
                <div class="chkSame">
                    <input type="checkbox" name="chk" onclick="check(this)"> 배송지 정보 동일
                </div>
                <div class="info">
                    <span class="font-span">구매자 정보</span>
                </div>
                <div class="addrBtn">
                    <button class="btn btn-secondary address" onclick="addrView()">주소 변경</button>
                </div>
            </div>
            <div class="buyer-div mt-2 mb-5">
                <div class="buyer mt-2">
                    <div class="mini">이름</div>
                    <div class="mini">전화번호</div>
                    <div class="mini">우편번호</div>
                    <div class="mini">주소</div>
                </div>
                <div class="buyer-info mt-2">
                    <div class="mini" id="buyerName">이재원</div>
                    <div class="mini" id="buyerPhone">010-4586-2667</div>
                    <div class="mini" id="buyerZipcode">01667</div>
                    <div class="mini" id="buyerAddress">어디든 살고 있겠지~~~~~~~~~~~</div>
                </div>
            </div>


            <div class="sameInfo">
                <span class="font-span">배송지 정보</span>
                <div class="delivery mt-2 mb-5">
                    <div class="delivery-div mt-3">
                        <label class="receiver">받는 사람</label>
                        <div class="receiver-info">
                            <input type="text"
                                   class="inputR"
                                   name="deliveryName"
                                   id="deliveryName"
                                   placeholder="받는 사람 이름">
                        </div>
                    </div>
                    <div class="delivery-div">
                        <label class="receiver">전화 번호</label>
                        <div class="receiver-info">
                            <input type="text"
                                   class="inputR"
                                   name="deliveryPhone"
                                   id="deliveryPhone"
                                   placeholder="연락 받을 번호">
                        </div>
                    </div>
                    <div class="delivery-div">
                        <label class="receiver">우편 번호</label>
                        <div class="receiver-info">
                            <input type="text"
                                   class="inputR"
                                   name="addr"
                                   id="zipcode"
                                   disabled>
                        </div>
                        <div class="searchAddr">
                            <button class="btn btn-outline-secondary" onclick="daumPost()">우편번호 검색</button>
                        </div>
                    </div>
                    <div class="delivery-div">
                        <label class="receiver">주소</label>
                        <div class="receiver-info">
                            <input type="text"
                                   class="inputR"
                                   name="addr"
                                   id="address"
                                   disabled>
                        </div>
                    </div>
                    <div class="delivery-div">
                        <label class="receiver">상세주소</label>
                        <div class="receiver-info">
                            <input type="text"
                                   class="inputR"
                                   name="addr"
                                   id="addressDetail"
                                   placeholder="상세주소">
                        </div>
                    </div>
                </div>
            </div>

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

            <div class="btn-div mb-5">
                <button class="pat-btn">결제하기</button>
            </div>

        </div>
    </div>

<jsp:include page="../main/footer.jsp" />