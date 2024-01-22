<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:include page="header.jsp" />


<div class="nav justify-content-center mb-5 mt-5">
    <h1>정보 수정</h1>
</div>

<div class="nav justify-content-center">
    <form style="width: 25rem" method="post" action="/dabook/user/modifyInfo">
        <div class="form-floating mb-2">
            <input type="text" class="form-control" id="floatingId" name="userId" value="${info.userId}" disabled />
            <label for="floatingId">ID</label>
        </div>
        <div class="form-floating mb-3">
            <input type="text" class="form-control" id="floatingName" name="userName" value="${info.username}" />
            <label for="floatingName">Name</label>
        </div>
        <div class="form-floating mb-3">
            <input type="text" class="form-control" id="floatingPhone" name="phone" value="${info.phone}" oninput="onlyNumber(this)" maxlength="11">
            <label for="floatingPhone">Phone</label>
        </div>
        <div class="form-floating mb-3">
            <input type="email" class="form-control" id="floatingEmail" name="email" value="${info.email}" />
            <label for="floatingEmail">Email</label>
        </div>


        <div class="d-flex gap-5 justify-content-center">
            <button type="button" class="btn btn-outline-secondary" style="width: 10rem" onclick="window.history.back();">취소</button>
            <button type="submit" class="btn btn-outline-success" style="width: 10rem" onclick="location.href='/dabook/user/modiInfo?id=${userId}'">완료</button>
        </div>
    </form>

</div>
<br/>
<br/>
<br/>
<jsp:include page="footer.jsp" />

<script>

    const onlyNumber = (target) => {
        target.value = target.value
            .replace(/[^0-9]/g, '')
            .replace(/^(\d{3})(\d{4})(\d{4})$/, `$1-$2-$3`);
    }

</script>