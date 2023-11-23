package com.quickmed.backend.entities;

import jakarta.persistence.*;
import lombok.*;


import java.util.Date;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
@Entity
@Table(name = "prediagnostico")
public class PreDiagnostico {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    public Long id;
    private String descricao;
    private Date dataDiagnostico;
    private String resultado;
    private String tratamentoRecomendado;
    private String setorRecomendado;
    private String observacoes;


    @ManyToOne
    @JoinColumn(name = "paciente_id")
    private Paciente paciente;

    @ManyToOne
    @JoinColumn(name = "medico_id")
    private Medico medico;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getDescricao() {
        return descricao;
    }

    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }

    public Date getDataDiagnostico() {
        return dataDiagnostico;
    }

    public void setDataDiagnostico(Date dataDiagnostico) {
        this.dataDiagnostico = dataDiagnostico;
    }

    public String getResultado() {
        return resultado;
    }

    public void setResultado(String resultado) {
        this.resultado = resultado;
    }

    public String getTratamentoRecomendado() {
        return tratamentoRecomendado;
    }

    public void setTratamentoRecomendado(String tratamentoRecomendado) {
        this.tratamentoRecomendado = tratamentoRecomendado;
    }

    public String getSetorRecomendado() {
        return setorRecomendado;
    }

    public void setSetorRecomendado(String setorRecomendado) {
        this.setorRecomendado = setorRecomendado;
    }

    public String getObservacoes() {
        return observacoes;
    }

    public void setObservacoes(String observacoes) {
        this.observacoes = observacoes;
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

