<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:include page="header.jsp" />


<div class="nav justify-content-center mb-5 mt-5">
    <h1>Login</h1>
</div>

<div class="nav justify-content-center">
    <form style="width: 20rem">
        <div class="form-floating mb-3">
            <input type="text" class="form-control" id="floatingInput" placeholder="Id" />
            <label for="floatingInput">Id</label>
        </div>
        <div class="form-floating mb-4">
            <input type="password" class="form-control" id="floatingPassword" placeholder="Password">
            <label for="floatingPassword">Password</label>
        </div>
        <div class="mb-3 form-check nav justify-content-center">
            <input type="checkbox" class="form-check-input" id="exampleCheck1">
            <label class="form-check-label" for="exampleCheck1">&nbsp;자동 로그인</label>
        </div>
        <div class="nav justify-content-center mb-4">
            <button type="submit" class="btn btn-outline-secondary" style="width: 20rem">login</button>
        </div>
        <div class="d-flex gap-5 justify-content-center mb-5">
            <a href="#" class="link-secondary link-underline link-underline-opacity-0">ID/Password 찾기</a>
            <a href="/join" class="link-secondary link-underline link-underline-opacity-0">Join</a>
        </div>
    </form>

</div>

<jsp:include page="footer.jsp" />
