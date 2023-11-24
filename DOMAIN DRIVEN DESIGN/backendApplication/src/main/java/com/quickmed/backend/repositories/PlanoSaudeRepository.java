package com.quickmed.backend.repositories;

import com.quickmed.backend.entities.PlanoDeSaude;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface PlanoSaudeRepository extends JpaRepository<PlanoDeSaude, Long> {
}

//    Optional<PlanoDeSaude> findById(Long id);
//
//    boolean existsById(Long id);
//
//    List<PlanoDeSaude> findAll();
//
//    PlanoDeSaude save(PlanoDeSaude planoSaude);