package com.dabook.dabook.repository;

import com.dabook.dabook.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

public interface UserRepository extends JpaRepository<User, Long> {


    @Query("select u from User u where u.userId = :userId")
    List<User> findByUserId(@Param("userId") String id);

    @Query("select u from User u where u.userId =:userId")
    User findOneUser(@Param("userId")String userId);

    @Query("select u.userId from User u where u.email = :email")
    List<String> findId(@Param("email") String email);

    @Modifying
    @Query("update User u set u.password = :password where u.userId = :userId")
    void updatePw(@Param("password") String password, @Param("userId") String userId);


    List<User> findByEmail(String email);

    User saveAndFlush(User user);

    List<User> findAllByUserId(String id);

    @Modifying
    @Query("update User u set u.username = :username, u.phone = :phone, u.email = :email where u.userId = :userId")
    void modiInfo(@Param("userId") String userId, @Param("username") String username, @Param("phone") String phone, @Param("email") String email);
}
