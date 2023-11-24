package com.quickmed.backend.repositories;

import com.quickmed.backend.entities.PlanoDeSaude;

import org.springframework.data.jpa.repository.JpaRepository;

public interface PlanoSaudeRepository extends JpaRepository<PlanoDeSaude, Long> {
}
