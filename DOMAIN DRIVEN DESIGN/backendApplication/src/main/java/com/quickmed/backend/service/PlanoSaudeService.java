package com.quickmed.backend.service;

import com.quickmed.backend.entities.PlanoDeSaude;
import com.quickmed.backend.repositories.PlanoSaudeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.lang.reflect.Field;
import java.util.List;
import java.util.Optional;

@Service
public class PlanoSaudeService {

    private final PlanoSaudeRepository planoSaudeRepository;

    @Autowired
    public PlanoSaudeService(PlanoSaudeRepository planoSaudeRepository) {
        this.planoSaudeRepository = planoSaudeRepository;
    }

    public Optional<PlanoDeSaude> getPlanoSaudeById(Long id) {
        return planoSaudeRepository.findById(id);
    }

    public List<PlanoDeSaude> getAllPlanosSaude() {
        return planoSaudeRepository.findAll();
    }

    public PlanoDeSaude criarPlanoSaude(PlanoDeSaude planoSaude) {
        return planoSaudeRepository.save(planoSaude);
    }

    public PlanoDeSaude atualizarPlanoSaude(Long id, PlanoDeSaude planoSaudeAtualizado) {
        Optional<PlanoDeSaude> planoSaudeExistente = planoSaudeRepository.findById(id);
        if (planoSaudeExistente.isPresent()) {
            PlanoDeSaude planoSaude = planoSaudeExistente.get();
            copiarCampos(planoSaude, planoSaudeAtualizado);
            return planoSaudeRepository.save(planoSaude);
        } else {
            return null;
        }
    }

    private void copiarCampos(PlanoDeSaude destino, PlanoDeSaude origem) {
        // Utiliza reflexão para obter todos os campos da classe
        Field[] campos = PlanoDeSaude.class.getDeclaredFields();

        for (Field campo : campos) {
            campo.setAccessible(true);
            try {
                // Copia o valor do campo da origem para o destino
                Object valorCampoOrigem = campo.get(origem);
                if (valorCampoOrigem != null) {
                    campo.set(destino, valorCampoOrigem);
                }
            } catch (IllegalAccessException e) {
                e.printStackTrace();
            }
        }
    }
}
