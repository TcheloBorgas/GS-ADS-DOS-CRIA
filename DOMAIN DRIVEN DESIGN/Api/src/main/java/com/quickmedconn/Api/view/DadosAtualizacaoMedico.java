package com.quickmedconn.Api.view;

import com.quickmedconn.Api.view.DadosEndereco;
import jakarta.validation.constraints.NotNull;

public record DadosAtualizacaoMedico(
        @NotNull
        Long id,
        String nome,
        DadosEndereco endereco,
        String telefone) {
}
