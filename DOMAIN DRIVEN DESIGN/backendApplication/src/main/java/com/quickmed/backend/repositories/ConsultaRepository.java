package com.quickmed.backend.repositories;

import com.quickmed.backend.entities.Consulta;

import java.util.List;
import java.util.Optional;

public interface ConsultaRepository {
    Optional<Consulta> findById(Long id);

    List<Consulta> findAll();

    Consulta save(Consulta consulta);
}
