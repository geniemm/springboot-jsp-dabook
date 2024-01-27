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

    @Modifying
    @Query("update Cart c set c.count = c.count + 1 where c.no = :no")
    int upCount(@Param("no") String no);

    @Modifying
    @Query("update Cart c set c.count = c.count - 1 where c.no = :no")
    int downCount(@Param("no") String no);

    @Modifying
    @Query("delete from Cart c where c.no in :noList")
    void delCartItems(@Param("noList") List<Long> noList);

    @Query("select c from Cart c " +
            "join fetch c.users u " +
            "join fetch c.books b " +
            "where c.no in :noList")
    List<Cart> orderItems(@Param("noList") List<Long> noList);

//    @Transactional(readOnly = true)
//    Optional<Cart> findByCartNoAndBookNo(Long cartNo,Long bookNo);

    @Modifying
    @Query("update Cart c set c.count = c.count + :count where c.no=:no")
    int editCount(@Param("count")int count,@Param("no")Long no);
}