<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<jsp:include page="header.jsp" />

<div class="nav justify-content-center mb-5 mt-5">
    <h3>아이디 찾기</h3>
</div>

<div class="nav justify-content-center">
    <!-- email로 id 찾기-->
    <form style="width: 20rem" action="/dabook/main/searchId" method="post">
        <div class="form-floating mb-3">
            <input type="email" class="form-control" name="email" id="floatingEmail" placeholder="Email" required/>
            <label for="floatingEmail">Email</label>
        </div>
        <div class="nav justify-content-center mb-4">
            <button type="submit" class="btn btn-outline-secondary" style="width: 20rem">ID 찾기</button>
        </div>
    </form>
</div>


<div class="nav justify-content-center mb-5 mt-5">
    <h3>비밀번호 찾기</h3>
</div>
<div class="nav justify-content-center">
    <!-- id로 pw 찾기-->
    <form style="width: 20rem" action="/dabook/main/changePw" method="post">
        <div class="form-floating mb-3">
            <input type="text" class="form-control" name="userId" id="floatingUserId" placeholder="ID" required />
            <label for="floatingUserId">ID</label>
        </div>
        <div class="form-floating mb-4">
            <input type="password" class="form-control" name="password1" id="floatingPassword1" placeholder="Password" required>
            <label for="floatingPassword1">새 비밀번호</label>
        </div>
        <div class="form-floating mb-4">
            <input type="password" class="form-control" name="password2" id="floatingPassword2" placeholder="Password" required>
            <label for="floatingPassword2">새 비밀번호 확인</label>
        </div>

        <div class="nav justify-content-center mb-4">
            <button type="submit" class="btn btn-outline-secondary" style="width: 20rem">확인</button>
        </div>
    </form>
</div>


<jsp:include page="footer.jsp" />

