<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<jsp:include page="header.jsp" />


<div class="nav justify-content-center mb-5 mt-5">
    <h3>비밀번호 변경</h3>
</div>
<div class="nav justify-content-center">
    <!-- id로 pw 찾기-->
    <form style="width: 20rem" action="/dabook/user/changePw" method="post">
        <input hidden="hidden" type="text"  name="userId" value="${userId}"  />

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

