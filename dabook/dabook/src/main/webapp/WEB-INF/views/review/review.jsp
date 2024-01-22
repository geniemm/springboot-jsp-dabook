<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<%@ include file="../default/style.jsp" %>
<head>
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
    <title>Document</title>
</head>
<link rel="stylesheet" href="/css/review/review.css"/>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css">
<link rel="stylesheet" href="/css/dafault/icon.css"/>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<body>
<div class="content-review">
    <span class="sub-title"> REVIEW</span>
    <div class="review-wrap">
        <div class="review-list">
                <c:forEach var="reviews" items="${reviews}" varStatus="loop">
                    <div class="review-item">
                        <div class="user-info-box">
                            <div class="left-info">
                                <span class="info-item" id="userIdSpan-${loop.index}">${reviews.users.userId}</span>
                                <span class="info-item">&nbsp;|&nbsp;</span>
                                <span class="info-item" id="reviewDateSpan-${loop.index}">${reviews.reviewDate}</span>
                            </div>
                            <div class="right-info">
                                <div class="rating">
                                    <c:forEach var="i" begin="1" end="${reviews.rating}">
                                       <span class="material-icons">star</span>
                                    </c:forEach>
                                    <c:forEach var="i" begin="${reviews.rating + 1}" end="5">
                                       <span class="material-icons">star_outline</span>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                        <div class="review-content" id="review-${reviews.no}">
                            <div class="review-text">${reviews.reviewContent}</div>
                            <div class="userSpace">
                                <div class="delModSpace"><button class="modBtn" type="button" onclick="modReview(${reviews.no})">수정</button>
                                <button class="delBtn" type="button" onclick="delReview(${reviews.no})">삭제</button> </div>
                            </div>
                        </div>
                        <div id="editModal" class="modal">
                            <div class="modal-content">
                                <span class="close" onclick="closeEditModal()">&times;</span>
                                <textarea id="editedReviewContent"></textarea>
                                <button onclick="saveEditedReview(${reviews.no})">저장</button>
                            </div>
                        </div>
                    </div>
                </c:forEach>
        </div>
    </div>
    <div class="write-review">
        <button type="button" class="reviewBtn"
                data-bs-toggle="modal" data-bs-target="#WriteReview">리뷰작성
        </button>
    </div>
    <!--Modal -->
    <div class="modal fade" id="WriteReview" tabindex="-1"
         aria-labelledby="WriteReviewLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <!-- Modal Header -->
                <div class="modal-header">
                    <h5 class="modal-title" id="WriteReviewLabel"><b>리뷰 작성</b></h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"
                            aria-label="Close"></button>
                </div>
                <!-- Modal Body -->
                <div class="modal-body">
                    <div class="form-group">
                        <div class="rating_box">
                            <label>별점</label> &nbsp;
                            <span class="rating__result"></span>
                            <i class="rating__star far fa-star" ></i>
                            <i class="rating__star far fa-star" ></i>
                            <i class="rating__star far fa-star" ></i>
                            <i class="rating__star far fa-star" ></i>
                            <i class="rating__star far fa-star" ></i>
                        </div>
                        <label>리뷰 내용<span class="reviewContent"></span></label><br>
                        <textarea class="form-control" id="reviewContent" name="reviewContent" rows="3"></textarea>
                        <input type="hidden" id="bookNo" name="bookNo" value="${param.no}">
                </div>
                    </div>
                <!-- Modal Footer -->
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary"
                            data-bs-dismiss="modal">닫기
                    </button>
                    <button type="button" onclick="submitReview()" class="btn btn-primary">등록하기</button>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
<script>
    for(var i =0; i<${reviews.size()};i++){
        var userIdSpan = document.getElementById('userIdSpan-'+i);

        if (userIdSpan) {
            var userId = userIdSpan.innerText;
            var maskedUserId = userId.substring(0, userId.length - 3) + '***';
            userIdSpan.innerText = maskedUserId;
        } else {
            console.error('userIdSpan을 찾을 수 없다');
        }
    }
</script>
<script>
    for(var i =0; i<${reviews.size()};i++) {
        var reviewDateSpan = document.getElementById('reviewDateSpan-' + i);
        if (reviewDateSpan) {
            var reviewDate = reviewDateSpan.innerText;
            var datePart = reviewDate.split('T')[0];
            reviewDateSpan.innerText = datePart;
        } else {
            console.error('오류발생');
        }
    }
</script>
<script>
    var reviewNo;
    function modReview(reviewNo){
        var modal = document.getElementById("editModal");
        modal.style.display = "block";
        // 기존 내용 모달에 표시
        var originalReviewContent = $(`#review-${reviewNo} .review-text`).text();
        $("#editedReviewContent").val(originalReviewContent);
        window.reviewNo = reviewNo;
    }
        function closeEditModal() {
            var modal = document.getElementById("editModal");
            modal.style.display = "none";
        }
        function saveEditedReview(reviewNo) {
            var editedReviewContent = $("#editedReviewContent").val();

            $.ajax({
                type: 'PUT',
                url: `/dabook/review/${window.reviewNo}`,
                data: JSON.stringify({ reviewContent: editedReviewContent}),
                success: function (response) {
                    console.log('리뷰 수정 완료', response);
                    // 수정된 내용을 화면에 반영
                    $(`#review-${window.reviewNo} .review-text`).text(editedReviewContent);
                    // 모달 닫기
                    closeEditModal();
                },
                error: function (error) {
                    console.error('리뷰 수정 실패', error);
                }
            });
    }
    function delReview(reviewNo) {
        var result = confirm("리뷰를 삭제하시겠습니까?");

        if (result) {
            $.ajax({
                type: 'DELETE',
                url: '/dabook/review',
                data: {no: reviewNo},
                success: function (response) {
                    console.log('리뷰 삭제 완료',response)
                    window.location.reload();
                },
                error: function (error) {
                    console.error('리뷰 삭제 실패',error)
                }
            });
        }else{
            console.log("리뷰 삭제 취소")
        }
    }
</script>
<script>
    const ratingStars = [...document.getElementsByClassName("rating__star")];
    let selectedStarts = 0;

    function executeRating(stars) {
        const starClassActive = "rating__star fas fa-star";
        const starClassInactive = "rating__star far fa-star";

        stars.forEach((star,i)=>{
            star.onclick=()=>{
                selectedStarts = i+1;
                for (let j = 0; j < stars.length; ++j) {
                    stars[j].className = j <= i ? starClassActive : starClassInactive;
                }
            };
        });
    }
    executeRating(ratingStars);

    function submitReview() {
        var no = $("#bookNo").val();
        var reviewContent = $("#reviewContent").val();

        console.log("no:" + no);
        console.log("리뷰:" + reviewContent);
        console.log("별점:" + selectedStarts);

        var reviewRequest = {
            no:no,
            reviewContent: reviewContent,
            rating: selectedStarts,

        };

        $.ajax({
            type: "POST",
            url: '/dabook/review?no='+no,
            contentType: "application/json",
            data: JSON.stringify(reviewRequest),
            success: function(response) {
                closeModalReload();
                console.log("리뷰 등록 성공", response);
            },
            error: function(error) {
                console.error("리뷰 등록 실패", error);
                // 실패 시 수행할 동작 추가
            }
        });
    }
    function closeModalReload(){
        $('#WriteReview').modal('hide');
        location.reload(true);
    }
</script>
</html>
