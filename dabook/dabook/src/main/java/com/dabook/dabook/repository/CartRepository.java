package com.dabook.dabook.repository;

import com.dabook.dabook.entity.Cart;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;


public interface CartRepository extends JpaRepository<Cart, Long> {

    // cartPage 데이터 가져오기
    @Query("select c from Cart c " +
            "join fetch c.users u " +
            "join fetch c.books b " +
            "where u.userId = :userId")
    List<Cart> cartList(@Param("userId") String userId);

    // 아이디값으로 장바구니 가져오기
    @Transactional(readOnly = true)
    @Query("select c from Cart c where c.users.userId = :userId")
    Cart findByUserId(@Param("userId")String userId);

    // 회원번호로 장바구니 가져오기
    @Transactional(readOnly = true)
    @Query("select c from Cart c where c.users.no = :no")
    Optional<Cart> findByUserNo(@Param("no") Long userNo);

    // 상품 수량 변경
    @Modifying
    @Query("update Cart c set c.count = c.count + :count where c.no = :no")
    int editCount(@Param("no") String no, @Param("count") int count);

    // 선택 상품 삭제
    @Modifying
    @Query("delete from Cart c where c.no in :noList")
    void delCartItems(@Param("noList") List<Long> noList);

    // 주문 상품 리스트 저장
    @Query("select c from Cart c " +
            "join fetch c.users u " +
            "join fetch c.books b " +
            "where c.no in :noList")
    List<Cart> orderItems(@Param("noList") List<Long> noList);

    @Query("select c from Cart c " +
            "where c.users.no = :userNo " +
            "and c.books.no = :bookNo")
    List<Cart> ifBook(@Param("userNo") Long userNo, @Param("bookNo") Long bookNo);

    @Modifying
    @Query(value = "insert into Cart(user_no, book_no, count) " +
            "values(:userNo, :bookNo, :bookCount)", nativeQuery = true)
    int insertBook(@Param("userNo") Long userNo, @Param("bookNo") Long bookNo, @Param("bookCount") int bookCount);

    @Modifying
    @Query("update Cart c set c.count = c.count + :count where c.users.no = :userNo and c.books.no = :bookNo")
    void setCount(@Param("userNo") Long userNo, @Param("bookNo") Long booksNo, @Param("count") int count);
}