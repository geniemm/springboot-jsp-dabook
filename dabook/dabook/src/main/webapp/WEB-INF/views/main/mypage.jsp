<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:include page="header.jsp" />


<div class="nav justify-content-center mb-5 mt-5">
    <h1>내 정보</h1>
</div>

<div class="nav justify-content-center">
    <c:choose>

        <c:when test="${info.provider eq null}">

            <form style="width: 25rem">
                <div class="form-floating mb-3">
                    <input type="text" class="form-control" id="floatingId" value="${info.userId}" disabled />
                    <label for="floatingId">ID</label>
                </div>
                <div class="form-floating mb-3">
                    <input type="password" class="form-control" id="floatingPassword" value="${info.password}" disabled/>
                    <label for="floatingEmail">Password</label>
                </div>
                <div class="nav justify-content-end mb-5">
                    <button type="button" class="btn btn-outline-secondary" style="width: 13rem" onclick="location.href='/dabook/user/pwCheck?id=${userId}'">
                        비밀번호 변경
                    </button>
                </div>
                <div class="form-floating mb-3">
                    <input type="text" class="form-control" id="floatingName" value="${info.username}" disabled />
                    <label for="floatingName">Name</label>
                </div>
                <div class="form-floating mb-3">
                    <input type="email" class="form-control" id="floatingEmail" value="${info.email}" disabled/>
                    <label for="floatingEmail">Email</label>
                </div>
                <div class="form-floating mb-3">
                    <input type="email" class="form-control" id="floatingPhone" value="${info.phone}" disabled/>
                    <label for="floatingEmail">Phone</label>
                </div>

                <div class="nav justify-content-end mb-5">
                    <button type="button" class="btn btn-outline-secondary" style="width: 13rem" onclick="location.href='/dabook/user/modifyInfo?id=${userId}'">
                        정보 수정
                    </button>
                </div>
            </form>

        </c:when>


        <c:otherwise>
        <form style="width: 25rem">
            <div class="form-floating mb-3">
                <input type="text" class="form-control" value="${info.username}" disabled />
                <label for="floatingName">Name</label>
            </div>
            <div class="form-floating mb-3">
                <input type="email" class="form-control" value="${info.email}" disabled/>
                <label for="floatingEmail">Email</label>
            </div>

                <c:if test="${info.provider == 'naver' }">
                    <div class="form-floating mb-3">
                        <input type="email" class="form-control" value="${info.phone}" disabled/>
                        <label for="floatingEmail">Phone</label>
                    </div>
                </c:if>

            <div class="form-floating mb-3">
                <input type="text" class="form-control" value="${info.provider}" disabled/>
                <label for="floatingEmail">소셜 로그인</label>
            </div>
        </form>

        </c:otherwise>

    </c:choose>


</div>
<jsp:include page="footer.jsp" />

<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', function() {
        showPartialPassword();
    });

    function showPartialPassword() {
        var passwordInput = document.getElementById('floatingPassword');
        var fullPassword = passwordInput.value;
        var partialPassword = fullPassword.substring(0, 10);
        passwordInput.value = partialPassword;
    }
</script>