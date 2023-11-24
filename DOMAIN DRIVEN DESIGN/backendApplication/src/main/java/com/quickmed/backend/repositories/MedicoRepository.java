package com.quickmed.backend.repositories;


import com.quickmed.backend.entities.Medico;
import org.springframework.data.jpa.repository.JpaRepository;


public interface MedicoRepository extends JpaRepository<Medico, Long> {
}
