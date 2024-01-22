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


}
