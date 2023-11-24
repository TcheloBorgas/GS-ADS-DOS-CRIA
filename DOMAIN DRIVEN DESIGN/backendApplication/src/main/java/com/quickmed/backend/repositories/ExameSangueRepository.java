package com.quickmed.backend.repositories;

import com.quickmed.backend.entities.ExameSangue;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface ExameSangueRepository extends JpaRepository<ExameSangue, Long> {
    Optional<ExameSangue> findById(Long id);

    List<ExameSangue> findAll();
}
