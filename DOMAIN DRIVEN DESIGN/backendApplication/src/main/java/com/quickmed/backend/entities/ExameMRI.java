package com.quickmed.backend.entities;

import jakarta.persistence.*;
import lombok.*;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
@Entity
@Table(name = "exame_mri")
public class ExameMRI {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "image_path", nullable = false, length = 300)
    private String imagePath;

    @Column(name = "tumor_type", nullable = false, length = 300)
    private String tumorType;

    @Column(name = "tumor_probability", nullable = false)
    private Float tumorProbability;

    @ManyToOne
    @JoinColumn(name = "id_paciente")
    private Paciente paciente;

    @ManyToOne
    @JoinColumn(name = "id_consulta")
    private Consulta consulta;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getImagePath() {
        return imagePath;
    }

    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
    }

    public String getTumorType() {
        return tumorType;
    }

    public void setTumorType(String tumorType) {
        this.tumorType = tumorType;
    }

    public Float getTumorProbability() {
        return tumorProbability;
    }

    public void setTumorProbability(Float tumorProbability) {
        this.tumorProbability = tumorProbability;
    }

    public Paciente getPaciente() {
        return paciente;
    }

    public void setPaciente(Paciente paciente) {
        this.paciente = paciente;
    }

    public Consulta getConsulta() {
        return consulta;
    }

    public void setConsulta(Consulta consulta) {
        this.consulta = consulta;
    }
}
