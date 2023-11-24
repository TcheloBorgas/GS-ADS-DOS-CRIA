package com.quickmed.backend.repositories;

import com.quickmed.backend.entities.PreDiagnostico;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface PreDiagnosticoRepository extends JpaRepository<PreDiagnostico, Long> {
}

//    Optional<PreDiagnostico> findById(Long id);
//
//    List<PreDiagnostico> findAll();
//
//    PreDiagnostico save(PreDiagnostico preDiagnostico);
//
//    boolean existsById(Long id);
//
//    void deleteById(Long id);