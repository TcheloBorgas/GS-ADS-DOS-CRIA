package com.quickmed.backend.service;

import com.quickmed.backend.entities.Medico;
import com.quickmed.backend.repositories.MedicoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class MedicoService {

    private final MedicoRepository medicoRepository;

    @Autowired
    public MedicoService(MedicoRepository medicoRepository) {
        this.medicoRepository = medicoRepository;
    }

    public Medico getMedicoById(Long id) {
        Optional<Medico> medicoOptional = medicoRepository.findById(id);
        return medicoOptional.orElse(null);
    }

    public List<Medico> listarMedicos() {
        return medicoRepository.findAll();
    }

    public Medico cadastrarMedico(Medico medico) {
        return medicoRepository.save(medico);
    }

    public Medico atualizarMedico(Long id, Medico medicoAtualizado) {
        Optional<Medico> medicoExistente = medicoRepository.findById(id);
        if (medicoExistente.isPresent()) {
            Medico medico = medicoExistente.get();
            medico.setId(medicoAtualizado.getId());
            medico.setNome(medicoAtualizado.getNome());
            medico.setEmail(medicoAtualizado.getEmail());
            medico.setCrm(medicoAtualizado.getCrm());
            medico.setEspecialidade(medicoAtualizado.getEspecialidade());
            medico.setTelefone(medicoAtualizado.getTelefone());
            medico.setEndereco(medicoAtualizado.getEndereco());
            // Atualize outros campos conforme necessário
            return medicoRepository.save(medico);
        } else {
            return null;
        }
    }
}

