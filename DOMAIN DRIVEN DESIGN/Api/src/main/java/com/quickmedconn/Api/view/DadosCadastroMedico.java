package com.quickmedconn.Api.view;

import com.quickmedconn.Api.view.DadosEndereco;
import com.quickmedconn.Api.models.Especialidade;
import jakarta.validation.Valid;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;

public record DadosCadastroMedico(


        @NotBlank
        String nome,
        @Email
        @NotBlank
        String email,
        @NotBlank
        @Pattern(regexp = "\\d{4,6}")
        String crm,

        @NotNull
        Especialidade especialidade,
        String telefone,
        @NotNull@Valid DadosEndereco endereco) {

}
