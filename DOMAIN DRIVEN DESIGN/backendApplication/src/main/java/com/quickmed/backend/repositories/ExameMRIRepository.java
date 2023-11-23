package com.quickmed.backend.repositories;

import com.quickmed.backend.entities.ExameMRI;

import java.util.List;
import java.util.Optional;

public interface ExameMRIRepository {
    Optional<ExameMRI> findById(Long id);

    List<ExameMRI> findAll();

    ExameMRI save(ExameMRI exameMRI);

    boolean existsById(Long id);

    void deleteById(Long id);
}
