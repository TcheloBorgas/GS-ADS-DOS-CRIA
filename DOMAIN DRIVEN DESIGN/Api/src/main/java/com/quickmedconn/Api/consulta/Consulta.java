package com.quickmedconn.Api.consulta;

import com.quickmedconn.Api.medico.Medico;
import com.quickmedconn.Api.paciente.Paciente;
import com.quickmedconn.Api.paciente.PacienteRepository;
import jakarta.persistence.*;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
public class Consulta {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(name = "data_consulta", nullable = false)
    private LocalDate dataConsulta;
    @Column(name = "horario_consulta", nullable = false)
    private LocalDateTime horarioConsulta;
    @JoinColumn(name = "paciente_id", nullable = false)
    private Paciente paciente;
    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "medico_id", nullable = false)
    private Medico medico;


    public Consulta(LocalDate dataConsulta, LocalDateTime horarioConsulta, Paciente paciente, Medico medico) {
        this.dataConsulta = dataConsulta;
        this.horarioConsulta = horarioConsulta;
        this.paciente = paciente;
        this.medico = medico;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

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

    public Paciente getPaciente() {
        return paciente;
    }

    public void setPaciente(Paciente paciente) {
        this.paciente = paciente;
    }

    public Medico getMedico() {
        return medico;
    }

    public void setMedico(Medico medico) {
        this.medico = medico;
    }
}
