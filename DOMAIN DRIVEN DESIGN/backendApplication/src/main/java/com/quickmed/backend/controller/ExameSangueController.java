package com.quickmed.backend.controller;

import com.quickmed.backend.entities.ExameSangue;
import com.quickmed.backend.service.ExameSangueService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/exames-sangue")
public class ExameSangueController {

    private final ExameSangueService exameSangueService;

    @Autowired
    public ExameSangueController(ExameSangueService exameSangueService) {
        this.exameSangueService = exameSangueService;
    }

    @GetMapping("/{id}")
    public ResponseEntity<ExameSangue> getExameSangue(@PathVariable Long id) {
        ExameSangue exameSangue = exameSangueService.getExameSangueById(id);
        if (exameSangue != null) {
            return new ResponseEntity<>(exameSangue, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @PostMapping
    @Transactional
    public ResponseEntity<ExameSangue> cadastrarExameSangue(@RequestBody ExameSangue exameSangue) {
        ExameSangue createdExameSangue = exameSangueService.cadastrarExameSangue(exameSangue);
        return new ResponseEntity<>(createdExameSangue, HttpStatus.CREATED);
    }

    @PutMapping("/{id}")
    @Transactional
    public ResponseEntity<ExameSangue> atualizarExameSangue(@PathVariable Long id, @RequestBody ExameSangue exameSangue) {
        ExameSangue updatedExameSangue = exameSangueService.atualizarExameSangue(id, exameSangue);
        if (updatedExameSangue != null) {
            return ResponseEntity.ok(updatedExameSangue);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }
}

