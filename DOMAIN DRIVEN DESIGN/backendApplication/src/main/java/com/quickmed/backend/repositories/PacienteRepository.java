package com.quickmed.backend.repositories;

import com.quickmed.backend.entities.Paciente;
import jakarta.persistence.metamodel.SingularAttribute;
import org.springframework.data.jpa.domain.AbstractPersistable;
import org.springframework.data.jpa.repository.JpaRepository;

import java.io.Serializable;
import java.util.Optional;

public interface PacienteRepository extends JpaRepository<Paciente, Long> {
    Optional<Paciente> findById(SingularAttribute<AbstractPersistable, Serializable> id);
}
