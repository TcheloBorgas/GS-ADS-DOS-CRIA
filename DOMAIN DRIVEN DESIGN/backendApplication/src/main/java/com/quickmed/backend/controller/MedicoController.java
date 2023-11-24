package com.quickmed.backend.controller;

import com.quickmed.backend.entities.Medico;
import com.quickmed.backend.service.MedicoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/medicos")
public class MedicoController {

    private final MedicoService medicoService;

    @Autowired
    public MedicoController(MedicoService medicoService) {
        this.medicoService = medicoService;
    }

    @GetMapping("/{id}")
    public ResponseEntity<Medico> getMedico(@PathVariable Long id) {
        Medico medico = medicoService.getMedicoById(id);
        if (medico != null) {
            return new ResponseEntity<>(medico, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @GetMapping
    public ResponseEntity<List<Medico>> listarMedicos() {
        List<Medico> medicos = medicoService.listarMedicos();
        return ResponseEntity.ok(medicos);
    }

    @PostMapping
    @Transactional
    public ResponseEntity<Medico> cadastrarMedico(@RequestBody Medico medico) {
        Medico createdMedico = medicoService.cadastrarMedico(medico);
        return new ResponseEntity<>(createdMedico, HttpStatus.CREATED);
    }

    @PutMapping("/{id}")
    @Transactional
    public ResponseEntity<Medico> atualizarMedico(@PathVariable Long id, @RequestBody Medico medico) {
        Medico updatedMedico = medicoService.atualizarMedico(id, medico);
        if (updatedMedico != null) {
            return ResponseEntity.ok(updatedMedico);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }
}
