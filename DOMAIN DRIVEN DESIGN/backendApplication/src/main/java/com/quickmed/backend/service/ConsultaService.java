package com.quickmed.backend.service;

import com.quickmed.backend.entities.Consulta;
import com.quickmed.backend.repositories.ConsultaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ConsultaService {

    private final ConsultaRepository consultaRepository;

    @Autowired
    public ConsultaService(ConsultaRepository consultaRepository) {
        this.consultaRepository = consultaRepository;
    }

    public Optional<Consulta> getConsultaById(Long id) {
        return consultaRepository.findById(id);
    }

    public List<Consulta> getAllConsultas() {
        return consultaRepository.findAll();
    }

    public Consulta criarConsulta(Consulta consulta) {
        return consultaRepository.save(consulta);
    }

    public Consulta atualizarConsulta(Long id, Consulta consultaAtualizada) {
        Optional<Consulta> consultaExistente = consultaRepository.findById(id);
        if (consultaExistente.isPresent()) {
            Consulta consulta = consultaExistente.get();
            consulta.setId(consultaAtualizada.getId());
            return consultaRepository.save(consulta);
        } else {
            return null;
        }
    }
}

