package com.quickmed.backend.repositories;

import com.quickmed.backend.entities.PreDiagnostico;

import java.util.List;
import java.util.Optional;

public interface PreDiagnosticoRepository {
    Optional<PreDiagnostico> findById(Long id);

    List<PreDiagnostico> findAll();

    PreDiagnostico save(PreDiagnostico preDiagnostico);

    boolean existsById(Long id);

    void deleteById(Long id);
}
