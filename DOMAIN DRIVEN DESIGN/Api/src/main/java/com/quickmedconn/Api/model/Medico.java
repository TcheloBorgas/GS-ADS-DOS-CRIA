package com.quickmedconn.Api.model;

import com.quickmedconn.Api.endereco.Endereco;
import jakarta.persistence.*;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.springframework.boot.autoconfigure.web.WebProperties;

@Table(name = "medicos")
@Entity(name = "Medico")
@Getter
@NoArgsConstructor
@EqualsAndHashCode(of = "id")
public class Medico {

@Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private String nome;
    private String email;
    private String crm;
    @Enumerated(EnumType.STRING)
    private Especialidade especialidade;
    private String telefone;
    @Embedded
    private  Endereco endereco;

    public Medico(DadosCadastroMedico dados) {
        this.nome = dados.nome () ;
        this.email = dados.email();
        this.crm = dados.crm();
        this.especialidade = dados.especialidade();
        this.telefone = dados.telefone();
        this.endereco = new Endereco(dados.endereco());
    }

            public Long getId() {
                return null;
                }

    public void atualizarIndinformacoes(DadosAtualizacaoMedico dados) {
        if (dados.nome() != null){
            this.nome = dados.nome();
        }
        if (dados.telefone()!= null){
            this.telefone = dados.telefone();

        }
        if (dados.endereco() !=null){
            this.endereco.atualizarInformacoes(dados.endereco());
        }
    }
}