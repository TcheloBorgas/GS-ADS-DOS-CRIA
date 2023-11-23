package com.quickmed.backend.service;

import com.quickmed.backend.entities.PreDiagnostico;
import com.quickmed.backend.repositories.PreDiagnosticoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.lang.reflect.Field;
import java.util.List;
import java.util.Optional;

@Service
public class PreDiagnosticoService {

    private final PreDiagnosticoRepository preDiagnosticoRepository;

    @Autowired
    public PreDiagnosticoService(PreDiagnosticoRepository preDiagnosticoRepository) {
        this.preDiagnosticoRepository = preDiagnosticoRepository;
    }

    public Optional<PreDiagnostico> getPreDiagnosticoById(Long id) {
        return preDiagnosticoRepository.findById(id);
    }

    public List<PreDiagnostico> getAllPreDiagnosticos() {
        return preDiagnosticoRepository.findAll();
    }

    public PreDiagnostico criarPreDiagnostico(PreDiagnostico preDiagnostico) {
        return preDiagnosticoRepository.save(preDiagnostico);
    }

    public PreDiagnostico atualizarPreDiagnostico(Long id, PreDiagnostico preDiagnosticoAtualizado) {
        Optional<PreDiagnostico> preDiagnosticoExistente = preDiagnosticoRepository.findById(id);
        if (preDiagnosticoExistente.isPresent()) {
            PreDiagnostico preDiagnostico = preDiagnosticoExistente.get();
            copiarCampos(preDiagnostico, preDiagnosticoAtualizado);
            return preDiagnosticoRepository.save(preDiagnostico);
        } else {
            return null;
        }
    }

    public boolean deletarPreDiagnostico(Long id) {
        if (preDiagnosticoRepository.existsById(id)) {
            preDiagnosticoRepository.deleteById(id);
            return true;
        } else {
            return false;
        }
    }

    private void copiarCampos(PreDiagnostico destino, PreDiagnostico origem) {
        // Utiliza reflexão para obter todos os campos da classe
        Field[] campos = PreDiagnostico.class.getDeclaredFields();

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

