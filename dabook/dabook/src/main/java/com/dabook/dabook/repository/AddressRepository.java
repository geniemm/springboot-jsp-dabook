package com.dabook.dabook.repository;

import com.dabook.dabook.entity.Address;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface AddressRepository extends JpaRepository<Address, Long> {

    @Modifying
    @Query("delete from Address a where a.no in :noList")
    void chkAddrDel(@Param("noList") List<Long> noList);

    @Modifying
    @Query("delete from Address a where a.no = :no")
    void addrDel(@Param("no") Long no);

    @Modifying
    @Query(value = "insert into Address (user_no, zipcode, city, street) " +
            "values (:userNo, :zipcode, :address, :detail)", nativeQuery = true)
    void addrAdd(@Param("userNo") Long userNo, @Param("zipcode") String zipcode,
                 @Param("address") String address, @Param("detail") String detail);

    @Modifying
    @Query("update Address a set a.zipcode= :zipcode, a.city= :address, a.street= :detail " +
            "where a.no = :no")
    void addrModi(@Param("no") Long no, @Param("zipcode") String zipcode,
                  @Param("address") String address, @Param("detail") String detail);
}