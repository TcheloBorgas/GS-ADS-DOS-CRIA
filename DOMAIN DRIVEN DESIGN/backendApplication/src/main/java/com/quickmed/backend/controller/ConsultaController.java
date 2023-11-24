package com.quickmed.backend.controller;

import com.quickmed.backend.entities.Consulta;
import com.quickmed.backend.service.ConsultaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/consultas")
public class ConsultaController {

    private final ConsultaService consultaService;

    @Autowired
    public ConsultaController(ConsultaService consultaService) {
        this.consultaService = consultaService;
    }

    @GetMapping("/{id}")
    public ResponseEntity<Consulta> getConsulta(@PathVariable Long id) {
        Optional<Consulta> consultaOptional = consultaService.getConsultaById(id);

        if (consultaOptional.isPresent()) {
            Consulta consulta = consultaOptional.get();
            return new ResponseEntity<>(consulta, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @PostMapping
    @Transactional
    public Consulta cadastrarConsulta(Consulta consulta) {
        return new Consulta();
    }

    @PutMapping("/{id}")
    @Transactional
    public ResponseEntity<Consulta> atualizarConsulta(@PathVariable Long id, @RequestBody Consulta consulta) {
        Consulta updatedConsulta = consultaService.atualizarConsulta(id, consulta);
        if (updatedConsulta != null) {
            return ResponseEntity.ok(updatedConsulta);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @GetMapping
    public ResponseEntity<List<Consulta>> listarConsultas() {
        List<Consulta> consultas = consultaService.listarConsultas();
        return ResponseEntity.ok(consultas);
    }
}

