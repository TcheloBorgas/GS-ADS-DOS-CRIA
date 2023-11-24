package com.quickmed.backend.service;

import com.quickmed.backend.entities.ExameSangue;
import com.quickmed.backend.repositories.ExameSangueRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ExameSangueService {

    private final ExameSangueRepository exameSangueRepository;

    @Autowired
    public ExameSangueService(ExameSangueRepository exameSangueRepository) {
        this.exameSangueRepository = exameSangueRepository;
    }

    public ExameSangue getExameSangueById(Long id) {
        Optional<ExameSangue> optionalExameSangue = exameSangueRepository.findById(id);
        return optionalExameSangue.orElse(null);
    }

    public List<ExameSangue> listarExamesSangue() {
        return exameSangueRepository.findAll();
    }

    public ExameSangue cadastrarExameSangue(ExameSangue exameSangue) {
        return exameSangueRepository.save(exameSangue);
    }

    public ExameSangue atualizarExameSangue(Long id, ExameSangue exameSangueAtualizado) {
        Optional<ExameSangue> optionalExameSangue = exameSangueRepository.findById(id);
        if (optionalExameSangue.isPresent()) {
            ExameSangue exameSangue = optionalExameSangue.get();

            return exameSangueRepository.save(exameSangue);
        } else {
            return null;
        }
    }
}
