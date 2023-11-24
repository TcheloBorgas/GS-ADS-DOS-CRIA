package com.quickmed.backend.entities;

import jakarta.persistence.*;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;

@Entity
@Table(name = "endereco")
public class Endereco {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "logradouro", nullable = false, length = 100)
    private String logradouro;

    @Column(name = "bairro", nullable = false, length = 100)
    private String bairro;

    @Column(name = "cep", nullable = false, length = 100)
    private String cep;

    @Column(name = "numero", nullable = false, length = 100)
    private String numero;
    @Column(name = "complemento", nullable = false, length = 100)
    private String complemento;
    @Column(name = "cidade", nullable = false, length = 100)
    private String cidade;
    @Column(name = "uf", nullable = false, length = 100)
    private String uf;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getLogradouro() {
        return logradouro;
    }

    public void setLogradouro(String logradouro) {
        this.logradouro = logradouro;
    }

    public String getBairro() {
        return bairro;
    }

    public void setBairro(String bairro) {
        this.bairro = bairro;
    }

    public String getCep() {
        return cep;
    }

    public void setCep(String cep) {
        this.cep = cep;
    }

    public String getNumero() {
        return numero;
    }

    public void setNumero(String numero) {
        this.numero = numero;
    }

    public String getComplemento() {
        return complemento;
    }

    public void setComplemento(String complemento) {
        this.complemento = complemento;
    }

    public String getCidade() {
        return cidade;
    }

    public void setCidade(String cidade) {
        this.cidade = cidade;
    }

    public String getUf() {
        return uf;
    }

    public void setUf(String uf) {
        this.uf = uf;
    }

    @Override
    public String toString() {
        return "Endereco{" + "id=" + id + ", logradouro=" + logradouro + ", bairro=" + bairro + ", cep=" + cep + ", numero=" + numero + ", complemento=" + complemento + ", cidade=" + cidade + ", uf=" + uf + '}';
    }


}
