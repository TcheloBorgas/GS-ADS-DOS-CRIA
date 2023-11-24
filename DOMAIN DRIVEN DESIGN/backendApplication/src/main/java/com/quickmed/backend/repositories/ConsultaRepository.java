package com.quickmed.backend.repositories;

import com.quickmed.backend.entities.Consulta;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ConsultaRepository extends JpaRepository<Consulta, Long> {
}

//    Optional<Consulta> findById(Long id);
//
//    List<Consulta> findAll();
//
//    Consulta save(Consulta consulta);