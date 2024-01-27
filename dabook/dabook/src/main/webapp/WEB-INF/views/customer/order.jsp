<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../default/style.jsp" %>
<link rel="stylesheet" href="/css/customer/order.css"/>



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
                            <div>${list.bookCount} 개</div>
                        </div>
                        <div class="product-price">
                            <div>${list.total} 원</div>
                        </div>
                    </div>
                </c:forEach>
            </c:if>
        </div>


        <div class="chkInfo">
            <div class="chkSame">
                <input type="checkbox" id="chk" name="chk" onclick="check(this)" disabled> 배송지 정보 동일
            </div>
            <div class="info">
                <span class="font-span">구매자 정보</span>
            </div>
            <div class="addrBtn">
                <button id="addrBtn" class="btn btn-secondary address" onclick="addrView()">주소 목록</button>
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
                <div class="mini" id="buyerName"></div>
                <div class="mini" id="buyerPhone"></div>
                <div class="mini" id="buyerZipcode"></div>
                <div class="mini" id="buyerAddress"></div>
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
                               oninput="formatPhone(this)"
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
                        <button class="btn btn-secondary" onclick="daumPost()">우편번호 검색</button>
                    </div>
                </div>
                <div class="delivery-div">
                    <label class="receiver">주소</label>
                    <div class="receiver-info">
                        <input type="text"
                               class="inputR"
                               name="addr"
                               id="address"
                               style="width: 500px"
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
                               style="width: 500px"
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
            <button class="btn btn-outline-success pay-btn">결제하기</button>
        </div>
    </div>

    <div id="myModal" class="modal">

        <!-- Modal content -->
        <div class="modal-content">
            <h2 class="mt-2 mb-2">주소 목록</h2>
            <c:if test="${not empty addrDto}">
                <c:forEach var="data" items="${addrDto}" varStatus="status">
                    <div class="dataAddr">
                        <div class="oneChk">
                            <input type="checkbox" class="chk">
                        </div>
                        <div class="addrList">
                            <span>(${data.zipcode})</span>
                            <span>${data.address}</span>
                            <div>${data.addressDetail}</div>
                        </div>
                        <div class="addrChoose">
                            <button class="btn btn-outline-success" onclick="addrChoose(${status.index})">선택</button>
                        </div>
                    </div>
                </c:forEach>
            </c:if>
            <span class="close" id="closeModalBtn">&times;</span>
        </div>

    </div>

</div>

<jsp:include page="../main/footer.jsp" />

<script>
    var infoList = ${info};
    var addList = ${addr};
    console.log(infoList);

    // 페이지 로드시 주문자 정보 넣기
    window.onload = function() {
        document.getElementById('buyerName').innerText = infoList[0].userName;
        document.getElementById('buyerPhone').innerText = infoList[0].phone;

        inputAddress();
    }

    // 주문자 배송지 정보 넣기
    function inputAddress(){
        var zipCode = document.getElementById('buyerZipcode');
        var fullAddr = document.getElementById('buyerAddress');
        var sameChk = document.getElementById('chk');
        var addrBtn = document.getElementById('addrBtn');

        if(addList.length) {
            sameChk.disabled = false;
            zipCode.innerText = addList[0].zipcode;
            fullAddr.innerText = addList[0].address +' '+ addList[0].addressDetail;
        }else{
            addrBtn.style.display = 'none';
            zipCode.innerText ='※ 저장된 정보가 없습니다 ※';
            fullAddr.innerText = '※ 배송지 정보를 입력해주세요 ※';
        }
    }

    // 주문자 = 배송지 (div 숨김)
    function check(chk) {
        let same = document.querySelector('.sameInfo');

        if (chk.checked) {
            same.style.display = 'none';
        } else {
            same.style.display = 'block';
        }
    }

    // 전화번호 (-)하이픈 넣기
    function formatPhone(input) {
        input.value = input.value
            .replace(/[^0-9]/g, '')
            .slice(0, 11)
            .replace(/^(\d{2,3})(\d{3,4})(\d{4})$/, `$1-$2-$3`)
            .replace(/-+/g, '-');
    }


    // Get the modal and buttons
    var modal = document.getElementById('myModal');
    var openModalBtn = document.getElementById('addrBtn');
    var closeModalBtn = document.getElementById('closeModalBtn');

    // Open the modal
    openModalBtn.onclick = function() {
        modal.style.display = 'block';
    }

    function addrChoose(index){
        var zipCode = document.getElementById('buyerZipcode');
        var fullAddr = document.getElementById('buyerAddress');

        zipCode.innerText = addList[index].zipcode;
        fullAddr.innerText = addList[index].address +' '+ addList[index].addressDetail;

        modal.style.display = 'none';

    }

    // Close the modal
    closeModalBtn.onclick = function() {
        modal.style.display = 'none';
    }

    // Close the modal if clicked outside of the modal content
    window.onclick = function(event) {
        if (event.target === modal) {
            modal.style.display = 'none';
        }
    }




</script>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function daumPost() {
        new daum.Postcode({
            oncomplete: function (data) {
                let fullAddress = data.address;
                let extraAddress = "";

                if (data.userSelectedType === "R") {
                    if (data.bname !== "") {
                        extraAddress += data.bname;
                    }
                    if (data.buildingName !== "") {
                        extraAddress +=
                            extraAddress !== ""
                                ? ", " + data.buildingName
                                : data.buildingName;
                    }
                    fullAddress += extraAddress !== ""
                        ? " (" + extraAddress + ")"
                        : "";
                }
                console.log(data);
                console.log(data.zonecode);
                console.log(fullAddress); // e.g. '서울 성동구 왕십리로2길 20 (성수동1가)'

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById("zipcode").value = data.zonecode;
                document.getElementById("address").value = fullAddress;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("addressDetail").focus();
            }
        }).open();
    }

    new daum.Postcode({
        onclose: function (state) {
            //state는 우편번호 찾기 화면이 어떻게 닫혔는지에 대한 상태 변수 이며, 상세 설명은 아래 목록에서 확인하실 수 있습니다.
            if (state === 'FORCE_CLOSE') {
                //사용자가 브라우저 닫기 버튼을 통해 팝업창을 닫았을 경우, 실행될 코드를 작성하는 부분입니다.

            } else if (state === 'COMPLETE_CLOSE') {
                //사용자가 검색결과를 선택하여 팝업창이 닫혔을 경우, 실행될 코드를 작성하는 부분입니다.
                //oncomplete 콜백 함수가 실행 완료된 후에 실행됩니다.
            }
        }
    });
</script>



/* Modal Styles */

<style>
    .modal {
        display: none; /* Hidden by default */
        position: fixed; /* Stay in place */
        z-index: 1; /* Sit on top */
        left: 0;
        top: 0;
        width: 100%; /* Full width */
        height: 100%; /* Full height */
        overflow: auto; /* Enable scroll if needed */
        background-color: rgb(0,0,0); /* Fallback color */
        background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
    }

    .modal-content {
        background-color: #fefefe;
        margin: 15% auto; /* 15% from the top and centered */
        padding: 20px;
        border: 1px solid #888;
        width: 60%; /* Could be more or less, depending on screen size */
    }

    .close {
        color: #aaa;
        float: right;
        font-size: 28px;
        font-weight: bold;
    }

    .close:hover,
    .close:focus {
        color: black;
        text-decoration: none;
        cursor: pointer;
    }

</style>