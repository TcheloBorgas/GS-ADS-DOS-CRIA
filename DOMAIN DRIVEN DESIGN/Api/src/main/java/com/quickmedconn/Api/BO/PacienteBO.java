package com.quickmedconn.Api.BO;

import com.quickmedconn.Api.paciente.DadosCadastroPaciente;
import org.springframework.stereotype.Service;
import org.springframework.util.Assert;

@Service
public class PacienteBO {

    public void validarPaciente(DadosCadastroPaciente dados) {
        // Incluir regras de validação para dados específicos do paciente, se necessário
        Assert.notNull(dados, "Os dados do paciente não podem ser nulos.");
        Assert.hasText(dados.getNome(), "O nome do paciente é obrigatório.");
        Assert.hasText(dados.getCpf(), "O CPF do paciente é obrigatório.");
        // Adicione outras validações conforme necessário
    }

    // Adicione métodos específicos do negócio para a entidade Paciente, se necessário
}

