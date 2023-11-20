package com.quickmedconn.Api.medico;

import com.quickmedconn.Api.endereco.DadosEndereco;
import jakarta.validation.constraints.NotNull;

public record DadosAtualizacaoMedico(
        @NotNull
        Long id,
        String nome,
        DadosEndereco endereco,
        String telefone) {
}
