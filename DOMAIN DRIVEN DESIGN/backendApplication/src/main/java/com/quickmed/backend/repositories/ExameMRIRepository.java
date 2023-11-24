package com.quickmed.backend.repositories;

import com.quickmed.backend.entities.ExameMRI;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ExameMRIRepository extends JpaRepository<ExameMRI, Long> {
}

//    Optional<ExameMRI> findById(Long id);
//
//    List<ExameMRI> findAll();
//
//    ExameMRI save(ExameMRI exameMRI);
//
//    boolean existsById(Long id);
//
//    void deleteById(Long id);