<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<jsp:include page="header.jsp" />
<link rel="stylesheet" href="/css/main/login.css" />

<div class="nav justify-content-center mb-5 mt-5">
    <h1>Login</h1>
</div>

<div class="nav justify-content-center">
    <form style="width: 20rem" action="/dabook/main/login" method="post">
        <div class="form-floating mb-3">
            <input type="text" class="form-control" name="userId" id="floatingInput" placeholder="Id" />
            <label for="floatingInput">Id</label>
        </div>
        <div class="form-floating mb-4">
            <input type="password" class="form-control" name="password" id="floatingPassword" placeholder="Password">
            <label for="floatingPassword">Password</label>
        </div>
        <div>
            <c:if test="${error != null}">
                <p style="color: red">${error}</p>
            </c:if>
        </div>

        <div class="mb-3 form-check nav justify-content-center">
            <input type="checkbox" class="form-check-input" id="remember" name="remember">
            <label class="form-check-label" for="remember">&nbsp;자동 로그인</label>&emsp;&emsp;&emsp;
        </div>

        <div class="nav justify-content-center mb-4">
            <button type="submit" class="btn btn-outline-secondary" style="width: 20rem">login</button>
        </div>

        <div class="d-flex gap-5 justify-content-center mb-5">
            <a href="#" class="link-secondary link-underline link-underline-opacity-0">ID/Password 찾기</a>
            <a href="/dabook/main/joinForm" class="link-secondary link-underline link-underline-opacity-0">Join</a>
        </div>
    </form>

</div>

<jsp:include page="footer.jsp" />