package com.dabook.dabook.repository;

import com.dabook.dabook.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<User,Long> {
}
