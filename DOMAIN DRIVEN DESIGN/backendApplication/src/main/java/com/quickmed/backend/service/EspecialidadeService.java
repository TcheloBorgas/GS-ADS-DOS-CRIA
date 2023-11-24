package com.quickmed.backend.service;

import com.quickmed.backend.entities.Especialidade;
import com.quickmed.backend.repositories.EspecialidadeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class EspecialidadeService {

    private final EspecialidadeRepository especialidadeRepository;

    @Autowired
    public EspecialidadeService(EspecialidadeRepository especialidadeRepository) {
        this.especialidadeRepository = especialidadeRepository;
    }

    public Object getEspecialidadeById(Long id) {
        return especialidadeRepository.findById(id);
    }

    public List<Especialidade> listarEspecialidades() {
        return especialidadeRepository.findAll();
    }

    public Especialidade cadastrarEspecialidade(Especialidade especialidade) {
        return especialidadeRepository.save(especialidade);
    }

    public Especialidade atualizarEspecialidade(Long id, Especialidade especialidadeAtualizada) {
        Optional<Especialidade> especialidadeExistente = especialidadeRepository.findById(id);
        if (especialidadeExistente.isPresent()) {
            Especialidade especialidade = especialidadeExistente.get();
            especialidade.setId(especialidadeAtualizada.getId());
            especialidade.setNome(especialidadeAtualizada.getNome());

            return especialidadeRepository.save(especialidade);
        } else {
            return null;
        }
    }
}

