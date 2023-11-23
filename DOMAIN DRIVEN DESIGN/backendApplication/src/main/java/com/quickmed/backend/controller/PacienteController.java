package com.quickmed.backend.controller;

import com.quickmed.backend.entities.Paciente;
import com.quickmed.backend.service.CadastroPacienteService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/pacientes")
public class PacienteController {
    private final CadastroPacienteService cadastroPacienteService;

    @Autowired
    public PacienteController(CadastroPacienteService cadastroPacienteService){
        this.cadastroPacienteService = cadastroPacienteService;
    }


    @GetMapping("/{id}")
    public ResponseEntity<Paciente> getPaciente(@PathVariable Long id) {
        Paciente paciente = CadastroPacienteService.getPacienteById(id);
        if (paciente != null) {
            return new ResponseEntity<>(paciente, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }
    @PostMapping
    @Transactional
    public void cadastrar(@RequestBody CadastroPacienteService dados) {

        System.out.println("dados recebido: " + dados);
    }

}
