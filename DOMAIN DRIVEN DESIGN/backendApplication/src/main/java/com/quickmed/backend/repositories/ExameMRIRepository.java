package com.quickmed.backend.repositories;

import com.quickmed.backend.entities.ExameMRI;

import java.util.List;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ExameMRIRepository extends JpaRepository<ExameMRI, Long> {
}
