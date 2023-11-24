package com.quickmed.backend.controller;

import com.quickmed.backend.entities.Especialidade;
import com.quickmed.backend.service.EspecialidadeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/especialidades")
public class EspecialidadeController {

    private final EspecialidadeService especialidadeService;

    @Autowired
    public EspecialidadeController(EspecialidadeService especialidadeService) {
        this.especialidadeService = especialidadeService;
    }

    @GetMapping("/{id}")
    public ResponseEntity<Especialidade> getEspecialidade(@PathVariable Long id) {
        Especialidade especialidade = (Especialidade) especialidadeService.getEspecialidadeById(id);
        if (especialidade != null) {
            return new ResponseEntity<>(especialidade, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @GetMapping
    public ResponseEntity<List<Especialidade>> listarEspecialidades() {
        List<Especialidade> especialidades = especialidadeService.listarEspecialidades();
        return ResponseEntity.ok(especialidades);
    }

    @PostMapping
    @Transactional
    public ResponseEntity<Especialidade> cadastrarEspecialidade(@RequestBody Especialidade especialidade) {
        Especialidade createdEspecialidade = especialidadeService.cadastrarEspecialidade(especialidade);
        return new ResponseEntity<>(createdEspecialidade, HttpStatus.CREATED);
    }

    @PutMapping("/{id}")
    @Transactional
    public ResponseEntity<Especialidade> atualizarEspecialidade(@PathVariable Long id, @RequestBody Especialidade especialidade) {
        Especialidade updatedEspecialidade = especialidadeService.atualizarEspecialidade(id, especialidade);
        if (updatedEspecialidade != null) {
            return ResponseEntity.ok(updatedEspecialidade);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }
}

