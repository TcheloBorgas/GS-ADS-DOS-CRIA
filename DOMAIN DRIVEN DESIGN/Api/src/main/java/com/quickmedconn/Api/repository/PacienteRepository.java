package com.quickmedconn.Api.repository;

import com.quickmedconn.Api.models.Paciente;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PacienteRepository extends JpaRepository<Paciente, Long> {

}
