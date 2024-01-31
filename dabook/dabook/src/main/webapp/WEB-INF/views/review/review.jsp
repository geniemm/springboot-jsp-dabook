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
            <c:choose>
                <c:when test="${empty reviews}">
                    <p class="nothingReview"><b>등록된 리뷰가 없습니다! 첫번째 리뷰를 등록해보세요</b></p>
                </c:when>
                <c:otherwise>
                    <c:forEach var="reviews" items="${reviews}" varStatus="loop">
                        <div class="review-item">
                            <div class="user-info-box">
                                <div class="left-info">
                                    <span class="info-item" id="userIdSpan-${loop.index}">${reviews.users.userId}</span>
                                    <span class="info-item">&nbsp;|&nbsp;</span>
                                    <span class="info-item"
                                          id="reviewDateSpan-${loop.index}">${reviews.reviewDate}</span>
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
                                    <c:if test="${reviews.users.userId eq uId}">
                                        <div class="delModSpace">
                                                <%--                                    <button class="modBtn" type="button" data-bs-backdrop="static"--%>
                                                <%--                                            onclick="openEditModal('${reviews.reviewContent}', ${reviews.rating}, ${reviews.no})">수정--%>
                                                <%--                                    </button>--%>
                                            <button class="delBtn" type="button" onclick="delReview(${reviews.no})">삭제
                                            </button>
                                        </div>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
    <div class="write-review">
        <input type="hidden" id="uId" name="uId" value="${uId}">
        <input type="hidden" id="orderedCheck" name="orderedCheck" value="${orderedCheck}">
            <button type="button" class="reviewBtn" data-bs-toggle="modal" data-bs-target="#WriteReview" onclick="openWriteReviewModal('${param.no}')">
                리뷰작성
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
                            <i class="rating__star far fa-star"></i>
                            <i class="rating__star far fa-star"></i>
                            <i class="rating__star far fa-star"></i>
                            <i class="rating__star far fa-star"></i>
                            <i class="rating__star far fa-star"></i>
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
    for (var i = 0; i < ${reviews.size()}; i++) {
        var userIdSpan = document.getElementById('userIdSpan-' + i);

        if (userIdSpan) {
            var userId = userIdSpan.innerText;
            var maskedUserId = userId.substring(0, userId.length - 3) + '***';
            userIdSpan.innerText = maskedUserId;
        } else {
            console.error('userIdSpan을 찾을 수 없다');
        }
    }

    for (var i = 0; i < ${reviews.size()}; i++) {
        var reviewDateSpan = document.getElementById('reviewDateSpan-' + i);
        if (reviewDateSpan) {
            var reviewDate = reviewDateSpan.innerText;
            var datePart = reviewDate.split('T')[0];
            reviewDateSpan.innerText = datePart;
        } else {
            console.error('오류발생');
        }
    }


    /*리뷰 작성*/
    const ratingStars = [...document.getElementsByClassName("rating__star")];
    let selectedStarts = 0;

    function executeRating(stars) {
        const starClassActive = "rating__star fas fa-star";
        const starClassInactive = "rating__star far fa-star";

        stars.forEach((star, i) => {
            star.onclick = () => {
                selectedStarts = i + 1;
                for (let j = 0; j < stars.length; ++j) {
                    stars[j].className = j <= i ? starClassActive : starClassInactive;
                }
            };
        });
    }

    executeRating(ratingStars);

    function openWriteReviewModal(bookNo) {
        var userId = $("#uId").val();

        console.log("아이디:" + userId);

        if (${empty userId}) {
            alert("로그인 먼저 해주세요");
            location.href = "/dabook/main/login";
        } else {
            // 여기에 모달을 열기 위한 코드를 추가
            $.ajax({
                type: 'GET',
                url: '/dabook/review/checkByUser',
                contentType: "application/x-www-form-urlencoded",
                data: {no: bookNo},
                success: function (response) {
                    if (response.hasReview) {
                        alert("등록된 리뷰가 있습니다.");
                        location.reload(true);
                    }else if(!response.hasOrderedBook){
                        alert("구매이력이 없습니다. 먼저 책을 구매해주세요!");
                        location.reload(true);
                    }
                    else {
                        var myModal = new bootstrap.Modal(document.getElementById('WriteReview'));
                        myModal.show();
                    }
                },
                error: function (error) {
                    console.error("리뷰 확인 실패", error);
                }
            });
        }
    }

    function submitReview() {
        var no = $("#bookNo").val();
        var reviewContent = $("#reviewContent").val();

        console.log("no:" + no);
        console.log("리뷰:" + reviewContent);
        console.log("별점:" + selectedStarts);

        // 리뷰 등록 AJAX 호출
        var url = '/dabook/review';

        $.ajax({
            type: "POST",
            url: url,
            data: {
                no: no,
                reviewContent: reviewContent,
                rating: selectedStarts
            },
            success: function (response) {
                closeModalReload();

                console.log("리뷰 등록 성공", response);
            },
            error: function (error) {
                console.error("리뷰 등록 실패", error);
                // 실패 시 수행할 동작 추가
            }
        });
    }

    function closeModalReload() {

        $('#WriteReview').modal('hide');

        location.reload(true);
    }

    /*삭제 버튼*/
    function delReview(reviewNo) {
        var result = confirm("리뷰를 삭제하시겠습니까?");

        if (result) {
            $.ajax({
                type: 'DELETE',
                url: '/dabook/review',
                data: {no: reviewNo},
                success: function (response) {
                    console.log('리뷰 삭제 완료', response)
                    window.location.reload();
                },
                error: function (error) {
                    console.error('리뷰 삭제 실패', error)
                }
            });
        } else {
            console.log("리뷰 삭제 취소")
        }
    }

    // /*수정 버튼*/
    // /* 수정 및 새 리뷰 작성 모달 열기 */
    // function openEditModal(existingContent, existingStars, reviewNo) {
    //     // 모달 창의 리뷰 내용과 별점 업데이트
    //     $("#editReviewContent").val(existingContent || ''); // 기존 내용이 있으면 가져오고, 없으면 빈 문자열로 초기화
    //
    //     // 선택된 별점 업데이트
    //     for (let i = 0; i < ratingStars.length; ++i) {
    //         ratingStars[i].className = i < existingStars ? "rating__star fas fa-star" : "rating__star far fa-star";
    //     }
    //     selectedStarts = existingStars || 0; // 기존 별점이 있으면 가져오고, 없으면 0으로 초기화
    //
    //     // 리뷰 번호를 모달에 저장
    //     $("#editReviewNo").val(reviewNo);
    //
    //     // 부트스트랩 5에서 모달 초기화
    //     var editReviewModal = new bootstrap.Modal(document.getElementById('EditReview'), {
    //         backdrop: 'static', // 뒷배경 클릭시 모달이 닫히지 않도록 설정
    //     });
    //     editReviewModal.show();
    // }


</script>
</html>
