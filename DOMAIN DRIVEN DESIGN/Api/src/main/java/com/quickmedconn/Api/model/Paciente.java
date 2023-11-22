package com.quickmedconn.Api.model;

import com.quickmedconn.Api.endereco.Endereco;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import java.util.Date;


@Getter
@NoArgsConstructor
@EqualsAndHashCode
@AllArgsConstructor
@Entity(name = "Paciente")
@Table(name = "paciente")
public class Paciente {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "nome", length = 100, nullable = false)
    private String nome;

    @Column(name = "email", length = 100, nullable = false)
    private String email;

    @Column(name = "sexo", length = 10, nullable = false)
    private String sexo;

    @Column(name = "cpf", length = 11, unique = true, nullable = false)
    private String cpf;

    @Column(name = "dt_nascimento", nullable = false)
    private Date dataNascimento;

    @Column(name = "telefone", length = 20, nullable = false)
    private String telefone;

    @Embedded
    private Endereco endereco;

    @Column(name = "plano_saude")
    protected String planoSaude;

    @Column(name = "historico_medico")
    protected String historicoMedico;

    public Paciente(DadosCadastroPaciente dados) {
        this.nome = dados.getNome();
        this.cpf = dados.getCpf();
        this.dataNascimento = dados.getDataNascimento();
        this.sexo = dados.getSexo();
        this.email = dados.getEmail();
        this.telefone = dados.getTelefone();
        this.endereco = new Endereco(dados.getEndereco());
        this.planoSaude = dados.getPlanoSaude();
        this.historicoMedico = dados.getHistoricoMedico();
    }
}