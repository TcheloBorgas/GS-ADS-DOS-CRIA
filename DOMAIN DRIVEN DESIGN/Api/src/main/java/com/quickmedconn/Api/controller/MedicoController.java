package com.quickmedconn.Api.controller;

import com.quickmedconn.Api.endereco.Endereco;
import com.quickmedconn.Api.medico.DadosCadastroMedico;
import com.quickmedconn.Api.medico.DadosListagemMedico;
import com.quickmedconn.Api.medico.Medico;
import com.quickmedconn.Api.medico.MedicoRepository;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("medicos")
public class MedicoController {

    @Autowired
    private MedicoRepository repository;
    @PostMapping
    @Transactional
    public void cadastrar(@RequestBody @Valid DadosCadastroMedico dados){
        repository.save(new Medico(dados));
    }

    @GetMapping
    public Page <DadosListagemMedico> listar(@PageableDefault(size=10,sort = {"nome"})Pageable paginacao){
        return repository.findAll(paginacao).map(DadosListagemMedico:: new);
    }
}

