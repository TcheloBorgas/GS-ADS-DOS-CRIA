package com.quickmed.backend.controller;

import com.quickmed.backend.entities.ExameMRI;
import com.quickmed.backend.service.ExameMRIService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/examesmri")
public class ExameMRIController {

    private final ExameMRIService exameMRIService;

    @Autowired
    public ExameMRIController(ExameMRIService exameMRIService) {
        this.exameMRIService = exameMRIService;
    }

    @GetMapping("/{id}")
    public ResponseEntity<Optional<ExameMRI>> getExameMRI(@PathVariable Long id) {
        Optional<ExameMRI> exameMRI = exameMRIService.getExameMRIById(id);
        return ResponseEntity.ok(exameMRI);
    }

    @GetMapping
    public ResponseEntity<List<ExameMRI>> getAllExamesMRI() {
        List<ExameMRI> examesMRI = exameMRIService.getAllExamesMRI();
        return ResponseEntity.ok(examesMRI);
    }

    @PostMapping
    public ResponseEntity<ExameMRI> criarExameMRI(@RequestBody ExameMRI exameMRI) {
        ExameMRI novoExameMRI = exameMRIService.criarExameMRI(exameMRI);
        return new ResponseEntity<>(novoExameMRI, HttpStatus.CREATED);
    }

    @PutMapping("/{id}")
    public ResponseEntity<ExameMRI> atualizarExameMRI(@PathVariable Long id, @RequestBody ExameMRI exameMRIAtualizado) {
        ExameMRI exameMRI = exameMRIService.atualizarExameMRI(id, exameMRIAtualizado);
        if (exameMRI != null) {
            return ResponseEntity.ok(exameMRI);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deletarExameMRI(@PathVariable Long id) {
        boolean deleted = exameMRIService.deletarExameMRI(id);
        if (deleted) {
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }
}

