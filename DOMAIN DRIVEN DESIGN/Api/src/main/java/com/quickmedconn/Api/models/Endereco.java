package com.quickmedconn.Api.models;

import com.quickmedconn.Api.view.DadosEndereco;
import jakarta.persistence.Embeddable;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Embeddable
@Getter
@NoArgsConstructor
public class Endereco {

    private String logradouro;
    private String bairro;
    private String cep;
    private String numero;
    private String complemento;
    private String cidade;
    private String uf;

    public Endereco(DadosEndereco dados) {
        this.logradouro = dados.logradouro();
        this.bairro = dados.bairro();
        this.cep = dados.cep();
        this.numero = dados.numero();
        this.complemento = dados.complemento();
        this.cidade = dados.cidade();
        this.uf = dados.uf();




    }

    public void atualizarInformacoes(DadosEndereco dados) {
        if (dados.logradouro()!= null){
            this.logradouro = dados.logradouro();
        }
        if (dados.bairro()!= null){
            this.bairro = dados.bairro();
        }
        if (dados.cep()!= null){
            this.cep = dados.cep();
        }
        if (dados.logradouro()!= null){
            this.uf = dados.uf();
        }
        if (dados.cidade()!= null){
            this.cidade = dados.cidade();
        }
        if (dados.logradouro()!= null){
            this.numero = dados.numero();
        }
        if (dados.complemento()!= null){
            this.complemento = dados.complemento();
        }

    }
}