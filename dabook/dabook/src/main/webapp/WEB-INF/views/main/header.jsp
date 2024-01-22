<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!Doctype html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://getbootstrap.com/docs/5.3/assets/css/docs.css" rel="stylesheet">

    <title>DABOOK</title>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</head>

<div class="text-center mt-3 mb-5">
    <a href="/">
        <img src="/images/DABOOK.jpg" class="rounded" alt="asdf" width="15%" >
    </a>
</div>

<div>
    <nav class="navbar navbar-expand-lg mt-3 mb-5">
        <div class="container-xl">
            <a class="navbar-brand" href="/dabook">DABOOK</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
                    aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="/dabook/allBook">모든 책</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="/dabook/bestSeller">베스트셀러</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="/dabook/nowBook">요즘 이 책</a>
                    </li>

                    <li class="nav-item">
                        <c:if test="${not empty userId}">
                            <a class="nav-link" href="/dabook/main/logout">LOGOUT</a>
                        </c:if>
                        <c:if test="${empty userId}">
                            <a class="nav-link" href="/dabook/main/login">LOGIN</a>
                        </c:if>
                    </li>
                    <li class="nav-item">
                        <c:if test="${not empty userId}">
                            <a class="nav-link" href="/dabook/user/cart?id=${userId}">CART</a>
                        </c:if>
                        <c:if test="${empty userId}">
                            <a class="nav-link" onclick="infoAlert()">CART</a>
                        </c:if>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            Mypage
                        </a>
                        <ul class="dropdown-menu">
                            <c:choose>
                                <c:when test="${empty userId}">
                                    <li><a class="dropdown-item" href="/dabook/main/login" onclick="infoAlert()">회원정보</a></li>
                                </c:when>
                                <c:otherwise>
                                    <li><a class="dropdown-item" href="/dabook/user/mypage?id=${userId}">회원정보</a></li>
                                </c:otherwise>
                            </c:choose>
                            <li><a class="dropdown-item" href="#">배송조회</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item" href="/dabook/mypage/address">주소 관리</a></li>
                        </ul>
                    </li>

                </ul>
                SEARCH &nbsp;
                <form class="d-flex" role="search">
                    <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
                    <button class="btn btn-outline-success" type="submit">Search</button>
                </form>
            </div>
        </div>
    </nav>
</div>

<script>
    function infoAlert(){
        alert("로그인 먼저 해주세요");
        window.location = '/dabook/main/login';
    }
</script>
