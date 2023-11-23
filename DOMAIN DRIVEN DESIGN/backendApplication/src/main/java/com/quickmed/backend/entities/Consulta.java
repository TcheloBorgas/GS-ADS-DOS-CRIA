package com.quickmed.backend.entities;

import com.quickmed.backend.entities.Paciente;
import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDate;
import java.time.LocalDateTime;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
@Entity
@Table(name = "consulta")
public class Consulta {
    @Getter
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private  Long id;

    @Getter
    @Column(name = "data_consulta", nullable = false)
    private LocalDate dataConsulta;
    @Getter
    @Column(name = "horario_consulta", nullable = false)
    private LocalDateTime horarioConsulta;
    @Getter
    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "paciente_id", nullable = false)
    private Paciente paciente;
    @Getter
    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "medico_id", nullable = false)
    private Medico medico;

    public Consulta(Long id, Long id1, LocalDate dataConsulta, LocalDateTime horarioConsulta, Paciente paciente, Medico medico, Paciente paciente1, Medico medico1) {
        this.id = id;
        this.id = id1;
        this.dataConsulta = dataConsulta;
        this.horarioConsulta = horarioConsulta;
        this.paciente = paciente;
        this.medico = medico;
        this.paciente = paciente1;
        this.medico = medico1;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public void setDataConsulta(LocalDate dataConsulta) {
        this.dataConsulta = dataConsulta;
    }

    public void setHorarioConsulta(LocalDateTime horarioConsulta) {
        this.horarioConsulta = horarioConsulta;
    }

    public void setPaciente(Paciente paciente) {
        this.paciente = paciente;
    }

    public void setMedico(Medico medico) {
        this.medico = medico;
    }
}
