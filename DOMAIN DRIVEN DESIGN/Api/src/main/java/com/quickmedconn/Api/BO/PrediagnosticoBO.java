package com.quickmedconn.BO;

import com.quickmedconn.Api.prediagnostico.DadosCadastroPrediagnostico;
import org.springframework.stereotype.Service;
import org.springframework.util.Assert;

@Service
public class PrediagnosticoBO {

    public void validarPrediagnostico(DadosCadastroPrediagnostico dados) {
        // Incluir regras de validação para dados específicos do prediagnóstico, se necessário
        Assert.notNull(dados, "Os dados do prediagnóstico não podem ser nulos.");
        Assert.hasText(dados.getDescricao(), "A descrição do prediagnóstico é obrigatória.");
        Assert.notNull(dados.getDataDiagnostico(), "A data do prediagnóstico não pode ser nula.");

    }


}

