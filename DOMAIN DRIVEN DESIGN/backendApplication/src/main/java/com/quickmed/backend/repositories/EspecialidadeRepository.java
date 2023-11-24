package com.quickmed.backend.repositories;

import com.quickmed.backend.entities.Especialidade;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface EspecialidadeRepository extends JpaRepository<Especialidade, Long> {
    Optional<Especialidade> findById(Long id);

    List<Especialidade> findAll();
}
