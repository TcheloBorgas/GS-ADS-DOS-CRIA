package com.quickmedconn.Api.medico;

import org.springframework.stereotype.Service;
import org.springframework.util.Assert;

@Service
public class MedicoBO {

    public void validarMedico(DadosCadastroMedico dados) {
        // Incluir regras de validação para dados específicos do médico, se necessário
        Assert.notNull(dados, "Os dados do médico não podem ser nulos.");
        Assert.hasText(dados.getNome(), "O nome do médico é obrigatório.");
        Assert.hasText(dados.getEmail(), "O e-mail do médico é obrigatório.");
        // Adicione outras validações conforme necessário
    }

    // Adicione métodos específicos do negócio para a entidade Médico, se necessário
}

