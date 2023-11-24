package com.quickmed.backend.service;

import com.quickmed.backend.entities.Consulta;
import com.quickmed.backend.repositories.ConsultaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;
import java.util.Optional;

@Service
public class ConsultaService {

    private static ConsultaRepository consultaRepository;

    @Autowired
    public ConsultaService(ConsultaRepository consultaRepository) {
        ConsultaService.consultaRepository = consultaRepository;
    }

    public static List<Consulta> listarConsultas() {
        return consultaRepository.findAll();
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




