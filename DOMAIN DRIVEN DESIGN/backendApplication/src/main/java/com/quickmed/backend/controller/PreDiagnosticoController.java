package com.quickmed.backend.controller;

import com.quickmed.backend.entities.PreDiagnostico;
import com.quickmed.backend.service.PreDiagnosticoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/prediagnosticos")
public class PreDiagnosticoController {

    private final PreDiagnosticoService preDiagnosticoService;

    @Autowired
    public PreDiagnosticoController(PreDiagnosticoService preDiagnosticoService) {
        this.preDiagnosticoService = preDiagnosticoService;
    }

    @GetMapping("/{id}")
    public ResponseEntity<Optional<PreDiagnostico>> getPreDiagnostico(@PathVariable Long id) {
        Optional<PreDiagnostico> preDiagnostico = preDiagnosticoService.getPreDiagnosticoById(id);
        return ResponseEntity.ok(preDiagnostico);
    }

    @GetMapping
    public ResponseEntity<List<PreDiagnostico>> getAllPreDiagnosticos() {
        List<PreDiagnostico> preDiagnosticos = preDiagnosticoService.getAllPreDiagnosticos();
        return ResponseEntity.ok(preDiagnosticos);
    }

    @PostMapping
    public ResponseEntity<PreDiagnostico> criarPreDiagnostico(@RequestBody PreDiagnostico preDiagnostico) {
        PreDiagnostico novoPreDiagnostico = preDiagnosticoService.criarPreDiagnostico(preDiagnostico);
        return new ResponseEntity<>(novoPreDiagnostico, HttpStatus.CREATED);
    }

    @PutMapping("/{id}")
    public ResponseEntity<PreDiagnostico> atualizarPreDiagnostico(@PathVariable Long id, @RequestBody PreDiagnostico preDiagnosticoAtualizado) {
        PreDiagnostico preDiagnostico = preDiagnosticoService.atualizarPreDiagnostico(id, preDiagnosticoAtualizado);
        if (preDiagnostico != null) {
            return ResponseEntity.ok(preDiagnostico);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deletarPreDiagnostico(@PathVariable Long id) {
        boolean deleted = preDiagnosticoService.deletarPreDiagnostico(id);
        if (deleted) {
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }
}

