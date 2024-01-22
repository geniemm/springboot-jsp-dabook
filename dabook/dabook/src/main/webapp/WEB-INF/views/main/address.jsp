<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="header.jsp"/>

<div class="nav justify-content-center">
    <div class="all">
        <h2>주소 목록</h2>

        <div class="control mt-5">
            <div class="chkAll">
                <input type="checkbox" class="checkedAll" onclick="checkedAll()"> 전체 선택
            </div>

            <div class="chkDel">
                <button class="btn btn-secondary" onclick="chkDel()">선택 삭제</button>
            </div>
        </div>

        <c:if test="${not empty address}">
            <c:forEach var="data" items="${address}" varStatus="status">
                <div class="info">
                    <div class="oneChk">
                        <input type="checkbox" class="chk">
                    </div>
                    <div class="oneAddr">
                        <span>(${data.zipcode})</span>
                        <span>${data.address}</span>
                        <div>${data.addressDetail}</div>
                    </div>
                    <div class="twoBtn">
                        <button class="btn btn-outline-primary"
                                onclick="modiAddr(${status.index}, ${data.addressNo})"
                        > 수정
                        </button>

                        <button class="btn btn-outline-secondary"
                                onclick="delAddr(${data.addressNo})"> 삭제 </button>
                    </div>
                </div>
            </c:forEach>
        </c:if>
        <c:if test="${empty address}">
            <div class="emptyCart">
                <span> 저장된 정보가 없습니다. </span>
            </div>
        </c:if>

        <div class="addrAdd mt-3 mb-5">
            <button class="btn btn-primary" onclick="addrForm()">주소 추가</button>
        </div>


        <div class="nav justify-content-center">
            <div class="inputAddr">
                <div style="display: flex">
                    <div class="form-floating mb-3">
                        <input type="text" class="form-control" id="zipcode" placeholder="zipcode" disabled/>
                        <label for="zipcode">Zipcode</label>
                    </div>
                    <div class="postBtn">
                        <button
                                class="btn btn-outline-secondary"
                                type="button"
                                onclick="daumPost()"
                        >
                            우편번호 찾기
                        </button>
                    </div>
                </div>
                <div class="form-floating mb-3">
                    <input type="text" class="form-control" id="address" placeholder="address" disabled />
                    <label for="address">Address</label>
                </div>
                <div class="form-floating mb-4">
                    <input type="text" class="form-control" id="addressDetail" placeholder="addressDetail" />
                    <label for="addressDetail">AddressDetail</label>
                </div>
                <div class="buttonSubmit">
                    <button class="btn btn-outline-success" id="cancelBtn" onclick="hiddenForm()">취소</button>
                    <button class="btn btn-outline-success" id="submitBtn" onclick="putInfo()">저장</button>
                    <button class="btn btn-outline-success" id="modifyBtn" onclick="modiInfo()">수정</button>
                </div>
            </div>
        </div>
    </div>
</div>
<br>
<br>
<br>
<jsp:include page="footer.jsp"/>

<link rel="stylesheet" href="/css/main/address.css" />


<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script>
    var addrInfo =${addr};

    window.onload = function (){
        if (addrInfo){
            var userNo = addrInfo[0].userNo;
        }
    }

    // DB 해당 주소 삭제
    function delAddr(addressNo){
        console.log("삭제할 addressNo: ", addressNo);
        $.ajax({
            url: '/addressDel/' + addressNo,
            type: 'delete',
            data: addressNo,
            success: function (data) {
                console.log('삭제 성공 : ', data);
                location.reload();
            },
            error: function (xhr, status, error) {
                console.error('실패: ', error);
            }
        });
    }

    // 주소 전체 선택/해제
    function checkedAll() {
        var checkboxes = document.querySelectorAll('.chk');
        var status = document.querySelector('.checkedAll').checked;

        checkboxes.forEach(function (checkbox) {
            checkbox.checked = status;
        });
    }

    // checked 주소 번호 가져오기
    function docChkItems() {
        var del = document.querySelectorAll('.chk');
        var list = [];
        for (var i = 0; i < addrInfo.length; i++) {
            if (del[i].checked) {
                list.push(addrInfo[i].addressNo);
            }
        }
        console.log(list);
        return list;
    }

    // checked 주소 db에서 삭제
    function chkDel() {
        var delList = docChkItems();

        $.ajax({
            url: '/address/chkDel',
            type: 'delete',
            contentType: 'application/json',
            data: JSON.stringify({
                data: delList
            }),
            success: function (data) {
                console.log('성공: ', data);
                location.reload();          // 성공하면 reload
            },
            error: function (err) {
                console.log('실패: ', err);
            }
        })
    }

    // 주소 추가 form 보이게
    function addrForm(){
        var form = document.querySelector('.inputAddr');
        reset();
        document.getElementById('submitBtn').style.display = 'inline-block';
        document.getElementById('modifyBtn').style.display = 'none';
        form.style.display = 'block';
    }

    // 주소 추가 form 안보이게
    function hiddenForm(){
        var form = document.querySelector('.inputAddr');
        reset();
        form.style.display = 'none';
    }

    // 주소 form 데이터 reset
    function reset(){
        document.getElementById('zipcode').value = '';
        document.getElementById('address').value = '';
        document.getElementById('addressDetail').value = '';
    }

    // form에 작성된 주소정보 가져오기 (수정, 추가)
    function Data(){
        var zipcode = document.getElementById('zipcode').value;
        var address = document.getElementById('address').value;
        var detail = document.getElementById('addressDetail').value;

        console.log(zipcode, address, detail);

        return { zipcode: zipcode, address: address, detail: detail };
    }

    // 주소 추가 데이터 db로 보내기
    function putInfo(){
        var list = Data();

        $.ajax({
            url: '/address/add',
            type: 'post',
            contentType: 'application/json',
            data: JSON.stringify({
                zipcode: list.zipcode,
                address: list.address,
                addressDetail: list.detail
            }),
            success: function (data){
                console.log("저장 성공: ",data);
                location.reload();
            },
            error: function(err){
                console.log("실패: ", err);
            }
        })
    }

    // 주소 수정 기본 데이터 보여주고 해당 addressNo session에 저장
    function modiAddr(index){
        var form = document.querySelector('.inputAddr');
        document.getElementById('submitBtn').style.display = 'none';
        document.getElementById('modifyBtn').style.display = 'inline-block';
        form.style.display = 'block';

        var zipcode = document.getElementById('zipcode');
        var addr = document.getElementById('address');
        var detail = document.getElementById('addressDetail');

        zipcode.value = addrInfo[index].zipcode;
        addr.value = addrInfo[index].address;
        detail.value = addrInfo[index].addressDetail;
        let no = addrInfo[index].addressNo;

        console.log("session 저장: ", index);
        $.ajax({
            url: '/address/modiNo',
            type: 'post',
            data: {
                no : no
            },
            success: function (data){
                console.log("no session 성공", data);
            },
            error: function (err){
                console.log(err);
            }
        })
    }

    // 주소 수정 데이터 db로 보내기
    function modiInfo(){
        var list = Data();

        $.ajax({
            url: '/address/modi',
            type: 'post',
            contentType: 'application/json',
            data: JSON.stringify({
                zipcode: list.zipcode,
                address: list.address,
                addressDetail: list.detail
            }),
            success: function (data){
                console.log("저장 성공: ",data);
                location.reload();
            },
            error: function(err){
                console.log("실패: ", err);
            }
        })
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