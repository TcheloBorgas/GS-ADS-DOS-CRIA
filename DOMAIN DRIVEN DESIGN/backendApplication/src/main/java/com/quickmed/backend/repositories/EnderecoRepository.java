package com.quickmed.backend.repositories;

import com.quickmed.backend.entities.Endereco;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface EnderecoRepository extends JpaRepository<Endereco, Long> {
    Optional<Endereco> findById(Long id);

    List<Endereco> findAll();
}
