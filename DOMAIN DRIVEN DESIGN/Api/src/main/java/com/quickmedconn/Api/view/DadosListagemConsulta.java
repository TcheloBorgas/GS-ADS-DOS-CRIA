package com.quickmedconn.Api.view;

import com.quickmedconn.Api.view.DadosListagemMedico;
import com.quickmedconn.Api.models.Consulta;
import com.quickmedconn.Api.view.DadosListagemPaciente;

import java.time.LocalDate;
import java.time.LocalDateTime;

public record DadosListagemConsulta(
        Long id,
        LocalDate dataConsulta,
        LocalDateTime horarioConsulta,
        DadosListagemPaciente paciente,
        DadosListagemMedico medico
) {
    public DadosListagemConsulta(Consulta consulta) {
        this(
                consulta.getId(),
                consulta.getDataConsulta(),
                consulta.getHorarioConsulta(),
                new DadosListagemPaciente(consulta.getPaciente()),
                new DadosListagemMedico(consulta.getMedico())
        );
    }
}

