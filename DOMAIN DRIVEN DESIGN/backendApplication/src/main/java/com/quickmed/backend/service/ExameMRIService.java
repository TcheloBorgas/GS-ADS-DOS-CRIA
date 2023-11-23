
package com.quickmed.backend.service;

        import com.quickmed.backend.entities.ExameMRI;
        import com.quickmed.backend.repositories.ExameMRIRepository;
        import org.springframework.beans.factory.annotation.Autowired;
        import org.springframework.stereotype.Service;

        import java.lang.reflect.Field;
        import java.util.List;
        import java.util.Optional;

@Service
public class ExameMRIService {

    private final ExameMRIRepository exameMRIRepository;

    @Autowired
    public ExameMRIService(ExameMRIRepository exameMRIRepository) {
        this.exameMRIRepository = exameMRIRepository;
    }

    public Optional<ExameMRI> getExameMRIById(Long id) {
        return exameMRIRepository.findById(id);
    }

    public List<ExameMRI> getAllExamesMRI() {
        return exameMRIRepository.findAll();
    }

    public ExameMRI criarExameMRI(ExameMRI exameMRI) {
        return exameMRIRepository.save(exameMRI);
    }

    public boolean deletarExameMRI(Long id) {
        if (exameMRIRepository.existsById(id)) {
            exameMRIRepository.deleteById(id);
            return true;
        } else {
            return false;
        }
    }

    public ExameMRI atualizarExameMRI(Long id, ExameMRI exameMRIAtualizado) {
        Optional<ExameMRI> exameMRIExistente = exameMRIRepository.findById(id);
        if (exameMRIExistente.isPresent()) {
            ExameMRI exameMRI = exameMRIExistente.get();
            copiarCampos(exameMRI, exameMRIAtualizado);
            return exameMRIRepository.save(exameMRI);
        } else {
            return null;
        }
    }

    private void copiarCampos(ExameMRI destino, ExameMRI origem) {
        // Utiliza reflexão para obter todos os campos da classe
        Field[] campos = ExameMRI.class.getDeclaredFields();

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


