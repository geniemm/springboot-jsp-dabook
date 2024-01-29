<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<jsp:include page="header.jsp" />

        <div class="nav justify-content-center mb-5 mt-5">
            <h3>아이디 찾기</h3>
        </div>

        <div class="nav justify-content-center">
            <h5>회원님의 ID는 "${id}"입니다</h5>
        </div>

        <br><br>

        <div class="nav justify-content-center">
            <div class="nav justify-content-center mb-4">
                <button type="button" class="btn btn-outline-secondary" style="width: 8rem; margin-right: 15px;" onclick="location.href='/dabook/main/login'">로그인</button>
                <button type="button" class="btn btn-outline-secondary" style="width: 8rem" onclick="location.href='/dabook/main/idpwFind'">비밀번호 찾기</button>
            </div>
        </div>

<br><br>


<jsp:include page="footer.jsp" />

