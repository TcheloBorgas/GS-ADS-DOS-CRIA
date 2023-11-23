package com.quickmedconn.Api.view;

<<<<<<< HEAD:DOMAIN DRIVEN DESIGN/Api/src/main/java/com/quickmedconn/Api/view/DadosListagemConsulta.java
import com.quickmedconn.Api.view.DadosListagemMedico;
import com.quickmedconn.Api.models.Consulta;
import com.quickmedconn.Api.view.DadosListagemPaciente;
=======
import com.quickmedconn.Api.medico.DadosListagemMedico;
import com.quickmedconn.Api.model.Consulta;
import com.quickmedconn.Api.paciente.DadosListagemPaciente;
>>>>>>> e0361684018fa17620e3b52f9b2fdfb3c35ad70c:DOMAIN DRIVEN DESIGN/Api/src/main/java/com/quickmedconn/Api/consulta/DadosListagemConsulta.java

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

