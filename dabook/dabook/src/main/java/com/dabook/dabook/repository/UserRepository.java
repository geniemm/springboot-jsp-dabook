package com.dabook.dabook.repository;

import com.dabook.dabook.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Map;
import java.util.Objects;

public interface UserRepository extends JpaRepository<User, Long> {

    List<User> findByUserId(String id);

    List<User> findByEmail(String email);

    User saveAndFlush(User user);
    List<User> findAllByUserId(String id);

    @Modifying
    @Query("update User u set u.username = :username, u.phone = :phone, u.email = :email where u.userId = :userId")
    void modiInfo(@Param("userId") String userId, @Param("username") String username, @Param("phone") String phone, @Param("email") String email);
}
