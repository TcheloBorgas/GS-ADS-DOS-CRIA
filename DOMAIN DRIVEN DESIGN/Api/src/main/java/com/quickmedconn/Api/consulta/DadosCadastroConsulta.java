package com.quickmedconn.Api.consulta;

import java.time.LocalDate;
import java.time.LocalDateTime;

public class DadosCadastroConsulta {

    private LocalDate dataConsulta;
    private LocalDateTime horarioConsulta;

    public LocalDate getDataConsulta() {
        return dataConsulta;
    }

    public void setDataConsulta(LocalDate dataConsulta) {
        this.dataConsulta = dataConsulta;
    }

    public LocalDateTime getHorarioConsulta() {
        return horarioConsulta;
    }

    public void setHorarioConsulta(LocalDateTime horarioConsulta) {
        this.horarioConsulta = horarioConsulta;
    }
}

