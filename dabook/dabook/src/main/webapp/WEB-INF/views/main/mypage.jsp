<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:include page="header.jsp" />


<div class="nav justify-content-center mb-5 mt-5">
    <h1>내 정보</h1>
</div>

<div class="nav justify-content-center">
    <form style="width: 25rem">
        <div class="form-floating mb-3">
            <input type="text" class="form-control" id="floatingId" value="가지고 온 값" disabled />
            <label for="floatingId">ID</label>
        </div>
        <div class="form-floating mb-3">
            <input type="text" class="form-control" id="floatingName" value="가지고 온 값" disabled />
            <label for="floatingName">Name</label>
        </div>
        <div class="form-floating mb-3">
            <input type="email" class="form-control" id="floatingEmail" value="가지고 온 값" disabled/>
            <label for="floatingEmail">Email</label>
        </div>
        <div class="form-floating mb-3">
            <input type="text" class="form-control" id="zipcode" value="가지고 온 값" disabled/>
            <label for="zipcode">zipcode</label>
        </div>

        <div class="form-floating mb-3">
            <input type="text" class="form-control" id="address" value="가지고 온 값" disabled />
            <label for="address">Address</label>
        </div>
        <div class="form-floating mb-5">
            <input type="text" class="form-control" id="addressDetail" value="가지고 온 값" disabled/>
            <label for="addressDetail">AddressDetail</label>
        </div>

        <div class="nav justify-content-end mb-5">
            <button
                type="button"
                class="btn btn-outline-secondary"
                style="width: 13rem"
                onclick="location.href='/dabook/modifyInfo'"
            >
                정보 수정
            </button>
        </div>
    </form>

</div>
<jsp:include page="footer.jsp" />
