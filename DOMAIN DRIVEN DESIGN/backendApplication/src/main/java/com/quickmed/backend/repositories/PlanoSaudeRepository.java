package com.quickmed.backend.repositories;

import com.quickmed.backend.entities.PlanoDeSaude;

import java.util.List;
import java.util.Optional;

public interface PlanoSaudeRepository {
    Optional<PlanoDeSaude> findById(Long id);

    boolean existsById(Long id);

    List<PlanoDeSaude> findAll();

    PlanoDeSaude save(PlanoDeSaude planoSaude);
}
