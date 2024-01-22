<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="C" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:include page="header.jsp" />


<div class="nav justify-content-center mb-5 mt-5">
    <h1>Join</h1>
</div>

<div class="nav justify-content-center">
    <form  style="width: 25rem" method="post" action="/dabook/main/join">

        <div class="form-floating mb-2">
            <input type="text" class="form-control"  name="userId" id="floatingId" placeholder="Id" required="required" />
            <label for="floatingId">Id</label>
        </div>
        <div class="nav justify-content-end mb-2">
            <%--ID 중복검사--%>
            <div class="message">
                <label id="idResult">&emsp;</label>
            </div>

        </div>
        <div class="form-floating mb-3">
            <input type="password" class="form-control" name="password" id="floatingPassword" placeholder="Password"  required="required" />
            <label for="floatingPassword">Password</label>
        </div>

        <div class="form-floating mb-3">
            <input type="text" class="form-control" name="userName" id="floatingName" placeholder="name"  required="required" />
            <label for="floatingName">Name</label>
        </div>
        <div class="form-floating mb-3">
            <input type="text" class="form-control" name="phone" id="floatingPhone" placeholder="Phone( - 없이 숫자만 입력 )" oninput="onlyNumber(this)" maxlength="11"  required="required"/>
            <label for="floatingPhone">Phone( - 없이 숫자만 입력 )</label>
        </div>
        <div class="form-floating mb-3">
            <input type="email" class="form-control" name="email" id="floatingEmail" placeholder="email"  required="required" />
            <label for="floatingEmail">Email</label>

        </div>
        <div class="nav justify-content-end mb-2">
            <%--email 중복검사--%>
            <div class="message">
                <label id="emailResult">&emsp;</label>
            </div>
        </div>


        <div class="nav justify-content-end mb-5">
            <button type="submit" class="btn btn-outline-success" style="width: 25rem">join</button>
        </div>



    </form>

</div>
<br/>
<br/>
<br/>
<jsp:include page="footer.jsp" />

<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script>

    const onlyNumber = (target) => {
        target.value = target.value
            .replace(/[^0-9]/g, '')
            .replace(/^(\d{3})(\d{4})(\d{4})$/, `$1-$2-$3`);
    }


    $(document).ready(function() {
        //ID 중복 확인
        $("#floatingId").on("focusout",function() {

            var id = $("#floatingId").val();
            console.log("id: " + id);

            if(id === '' ||  id.length === 0 || !/^[a-zA-Z0-9]+$/.test(id) ){
                    $("#idResult").css("color", "red").text("한글 및 공백은 ID로 사용할 수 없습니다.");
                    $("#floatingId").val('');
                    return false;
            }

            //Ajax 전송
            $.ajax({
                url : '/dabook/main/idCheck',
                data : {
                    id : id
                },
                type : 'POST',
                dataType : 'json',
                success : function(result){
                    if(result === true){
                        $("#idResult").css("color", "black").text("사용 가능한 ID 입니다.");
                    } else{
                        $("#idResult").css("color", "red").text("사용 불가능한 ID 입니다.");
                        $("#floatingId").val('');
                    }
                }
            });

        });


    })

    $(document).ready(function() {
        //이메일 중복 확인
        $("#floatingEmail").on("focusout", function(){

            var email = $("#floatingEmail").val();
            console.log("email: " + email);

            $.ajax({
                url : '/dabook/main/emailCheck',
                data : {
                    email : email
                },
                type : 'POST',
                dataType: 'json',
                success : function(result){
                    if(result == true){
                        $("#emailResult").css("color", "black").text("사용 가능한 email 입니다.");
                    }else{
                        $("#emailResult").css("color", "red").text("사용 불가능한 email 입니다.");
                        $("#floatingEmail").val('');
                    }
                }

            });

        });
    })

</script>

