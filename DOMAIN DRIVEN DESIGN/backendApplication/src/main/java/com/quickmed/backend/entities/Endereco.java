package com.quickmed.backend.entities;

import jakarta.persistence.*;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;

import lombok.*;

@Id
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

    public void setId(Long id) {
        this.id = id;}

    public void setLogradouro(String logradouro) {
        this.logradouro = logradouro;}

    public void setBairro(String bairro) {
        this.bairro = bairro;}

    public void setCep(String cep) {
        this.cep = cep;}

    public void setNumero(String numero) {
        this.numero = numero;}

    public void setComplemento(String complemento) {
        this.complemento = complemento;}

    public void setCidade(String cidade) {
        this.cidade = cidade;}

    public void setUf(String uf) {
        this.uf = uf;}

}
