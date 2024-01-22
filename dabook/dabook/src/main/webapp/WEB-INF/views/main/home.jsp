<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<%@ include file="../default/style.jsp" %>
<head>
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
    <title>home</title>
</head>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="/css/main/home.css"/>
<link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
<script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>

<style>
    .mySlides {display: none;}
</style>
<body>
<jsp:include page="header.jsp" />
<div class="wholeSpace">
<div class="w3-content w3-section">
    <img class="mySlides" src="/images/mainBanner/banner1.jpg">
    <img class="mySlides" src="/images/mainBanner/banner2.jpg">
    <img class="mySlides" src="/images/mainBanner/banner3.jpg">
</div>
    <div class="nowBookSpace">
        <div class="title">요즘 이 책</div>
<%--        <button type="button" class="prev-arrow" style=""> &lt; </button>--%>
        <div class="nowBookContent">
            <c:forEach var="books" items="${books}">
            <div class="bookCard">
                <a href="/dabook/book?no=${books.no}" class="nowBookInfo">
                    <img class="nowSlides" src="/images/bookImage/book${books.no}.jpg" alt="nowBook"></a>
                <div class="bookInfo"><a href="/dabook/book?no=${books.no}" class="nowBookInfo">${books.bookName} · ${books.author}</a></div>
            </div>
            </c:forEach>
        </div>
    </div>
</div>
<jsp:include page="footer.jsp" />
</body>
<script>
    var myIndex =0;
    carousel();

    function carousel(){
        var i;
        var x =document.getElementsByClassName("mySlides");
        for(i=0;i<x.length;i++){
            x[i].style.display = "none";
        }
        myIndex++;
        if(myIndex > x.length){
            myIndex =1
        }
        x[myIndex-1].style.display ="block";
        setTimeout(carousel,3000); //4초마다 이미지 변경
    }
</script>
<script>
  $('.nowBookContent').slick({
      prevArrow: '<button type="button" class="prev-arrow"> < </button>',
      nextArrow: '<button type="button" class="next-arrow"> > </button>',
      slidesToShow: 3,
      slidesToScroll :1,
      autoplay:true,
      autoplaySpeed: 3000,
  });
</script>
</html>