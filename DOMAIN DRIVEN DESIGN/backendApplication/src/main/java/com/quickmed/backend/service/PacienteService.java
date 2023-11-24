package com.quickmed.backend.service;

import com.quickmed.backend.entities.Paciente;
import com.quickmed.backend.repositories.PacienteRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

import static org.springframework.data.jpa.domain.AbstractPersistable_.id;

@Service
public class PacienteService {

    private final PacienteRepository pacienteRepository;
    public Paciente getPacienteById;

    @Autowired
    public PacienteService(PacienteRepository pacienteRepository) {
        this.pacienteRepository = pacienteRepository;
    }

    public List<Paciente> listarPacientes() {
        return pacienteRepository.findAll();
    }

    public ResponseEntity<Paciente> getPacienteById() {
        Optional<Paciente> paciente = pacienteRepository.findById(id);
        return paciente.map(ResponseEntity::ok).orElseGet(() -> ResponseEntity.notFound().build());
    }

    public List<Paciente> getAllPacientes() {
        return pacienteRepository.findAll();
    }

    public ResponseEntity<Paciente> criarPaciente(@RequestBody Paciente paciente) {
        Paciente novoPaciente = pacienteRepository.save(paciente);
        return ResponseEntity.status(201).body(novoPaciente);
    }

    public ResponseEntity<Paciente> atualizarPaciente(@PathVariable Long id, @RequestBody Paciente pacienteAtualizado) {
        Optional<Paciente> pacienteExistente = pacienteRepository.findById(id);
        if (pacienteExistente.isPresent()) {
            Paciente paciente = pacienteExistente.get();
            // Atualize os campos conforme necessário
            pacienteRepository.save(paciente);
            return ResponseEntity.ok(paciente);
        } else {
            return ResponseEntity.notFound().build();
        }
    }
}

