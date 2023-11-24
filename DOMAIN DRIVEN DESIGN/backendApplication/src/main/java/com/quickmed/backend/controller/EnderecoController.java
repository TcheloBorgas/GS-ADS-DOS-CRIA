package com.quickmed.backend.controller;

import com.quickmed.backend.entities.Endereco;
import com.quickmed.backend.service.EnderecoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/enderecos")
public class EnderecoController {

    private final EnderecoService enderecoService;

    @Autowired
    public EnderecoController(EnderecoService enderecoService) {
        this.enderecoService = enderecoService;
    }

    @GetMapping("/{id}")
    public ResponseEntity<Endereco> getEndereco(@PathVariable Long id) {
        return enderecoService.getEnderecoById(id)
                .map((Endereco endereco) -> new ResponseEntity<>(endereco, HttpStatus.OK))
                .orElseGet(() -> new ResponseEntity<>(HttpStatus.NOT_FOUND));
    }


    @GetMapping
    public ResponseEntity<List<Endereco>> listarEnderecos() {
        List<Endereco> enderecos = enderecoService.listarEnderecos();
        return ResponseEntity.ok(enderecos);
    }

    @PostMapping
    @Transactional
    public ResponseEntity<Endereco> cadastrarEndereco(@RequestBody Endereco endereco) {
        Endereco createdEndereco = enderecoService.cadastrarEndereco(endereco);
        return new ResponseEntity<>(createdEndereco, HttpStatus.CREATED);
    }

    @PutMapping("/{id}")
    @Transactional
    public ResponseEntity<Endereco> atualizarEndereco(@PathVariable Long id, @RequestBody Endereco endereco) {
        Endereco updatedEndereco = enderecoService.atualizarEndereco(id, endereco);
        return updatedEndereco != null ?
                ResponseEntity.ok(updatedEndereco) :
                new ResponseEntity<>(HttpStatus.NOT_FOUND);
    }
}
