package com.dabook.dabook.repository;

import com.dabook.dabook.dto.AddressDTO;
import com.dabook.dabook.entity.Address;
import jakarta.persistence.EntityManager;
import lombok.RequiredArgsConstructor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@RequiredArgsConstructor
public class AddressRepositoryImpl {

    private final EntityManager em;

    @Query
    public List<Address> addressList(Long no){
        return em.createQuery(
                "select a from Address a " +
                "left join a.users " +
                "where a.users.no = :no", Address.class)
                .setParameter("no", no)
                .getResultList();
    }

    @Modifying
    @Query
    public void addrAdd(AddressDTO data){
        em.createQuery(
                        "insert into Address(user_no, zipcode, city, street) " +
                                "values(:userNo, :zipcode, :address, :detail)", Address.class)
                .setParameter("userNo", data.getUserNo())
                .setParameter("zipcode", data.getZipcode())
                .setParameter("zipcode", data.getAddress())
                .setParameter("detail", data.getAddressDetail())
                .executeUpdate();
    }

}
