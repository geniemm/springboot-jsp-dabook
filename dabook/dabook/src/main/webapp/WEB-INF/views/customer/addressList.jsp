<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="/css/customer/addressList.css" />

<div ><!--모달창 밑에 깔릴 화면 -->

        <jsp:include page="../main/header.jsp" />

        <div class="nav justify-content-center mb-5 mt-5">
            <h1>배송주소록</h1>
            <button class="plus" > <!--모달창 열기 -->
                <img class="plus-button" src="/images/addressList/plusButton.jpg" alt="">
                <!--모달창 열기 -->
            </button>
        </div>


        <!--모달창-->
        <div id="modelContent">
            <div class="nav justify-content-center">
                <form style="width: 25rem" method="post" action="/addressList">
                    <div class="nav justify-content-end mb-2">
                        <button class="btn btn-outline-secondary" type="button" onclick="DaumPost()" >우편번호 찾기</button>
                    </div>
                    <div class="form-floating mb-3">
                        <input type="text" class="form-control" name="zipcode" id="zipcode" placeholder="zipcode" disabled/>
                        <label for="zipcode">Zipcode</label>
                    </div>

                    <div class="form-floating mb-3">
                        <input type="text" class="form-control" name="city" id="address" placeholder="address" disabled />
                        <label for="address">Address</label>
                    </div>
                    <div class="form-floating mb-4">
                        <input type="text" class="form-control" name="street" id="addressDetail" placeholder="addressDetail" />
                        <label for="addressDetail">AddressDetail</label>
                    </div>

                    <div class="nav justify-content-end mb-5">
                        <button type="submit" class="addressSave">주소 저장하기</button>
                        <!--모달창 닫기-->
                    </div>
                </form>
                </div>
            </div>
            <!--모달창-->


        <br/>
        <br/>
        <br/>
        <jsp:include page="../main/footer.jsp" />

</div>


<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>




    function DaumPost(){
        new daum.Postcode({
            oncomplete: function(data) {
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
        onclose: function(state) {
            //state는 우편번호 찾기 화면이 어떻게 닫혔는지에 대한 상태 변수 이며, 상세 설명은 아래 목록에서 확인하실 수 있습니다.
            if(state === 'FORCE_CLOSE'){
                //사용자가 브라우저 닫기 버튼을 통해 팝업창을 닫았을 경우, 실행될 코드를 작성하는 부분입니다.

            } else if(state === 'COMPLETE_CLOSE'){
                //사용자가 검색결과를 선택하여 팝업창이 닫혔을 경우, 실행될 코드를 작성하는 부분입니다.
                //oncomplete 콜백 함수가 실행 완료된 후에 실행됩니다.
            }
        }
    });
</script>

<!--


////모달창
<div id="modelContent">
    <div class="nav justify-content-center">
        <form style="width: 25rem" method="post" action="/addressList">
            <div class="nav justify-content-end mb-2">
                <button class="btn btn-outline-secondary" type="button" onclick="DaumPost()" >우편번호 찾기</button>
            </div>
            <div class="form-floating mb-3">
                <input type="text" class="form-control" name="zipcode" id="zipcode" placeholder="zipcode" disabled/>
                <label for="zipcode">Zipcode</label>
            </div>

            <div class="form-floating mb-3">
                <input type="text" class="form-control" name="city" id="address" placeholder="address" disabled />
                <label for="address">Address</label>
            </div>
            <div class="form-floating mb-4">
                <input type="text" class="form-control" name="street" id="addressDetail" placeholder="addressDetail" />
                <label for="addressDetail">AddressDetail</label>
            </div>

            <div class="nav justify-content-end mb-5">
                <button type="submit" id="closeModal" class="btn btn-outline-success" style="width: 25rem">주소 저장하기</button>
                ////모달창 닫기
            </div>



-->
