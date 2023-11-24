package com.quickmed.backend.service;

import com.quickmed.backend.entities.Endereco;
import com.quickmed.backend.repositories.EnderecoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class EnderecoService {

    private final EnderecoRepository enderecoRepository;

    @Autowired
    public EnderecoService(EnderecoRepository enderecoRepository) {
        this.enderecoRepository = enderecoRepository;
    }

    public Optional<Endereco> getEnderecoById(Long id) {
        return enderecoRepository.findById(id);
    }

    public List<Endereco> listarEnderecos() {
        return enderecoRepository.findAll();
    }

    public Endereco cadastrarEndereco(Endereco endereco) {
        return enderecoRepository.save(endereco);
    }

    public Endereco atualizarEndereco(Long id, Endereco endereco) {
        Optional<Endereco> enderecoExistente = enderecoRepository.findById(id);

        if (enderecoExistente.isPresent()) {
            Endereco enderecoAtualizado = enderecoExistente.get();
            enderecoAtualizado.setLogradouro(endereco.getLogradouro());
            enderecoAtualizado.setBairro(endereco.getBairro());
            enderecoAtualizado.setCep(endereco.getCep());
            enderecoAtualizado.setNumero(endereco.getNumero());
            enderecoAtualizado.setComplemento(endereco.getComplemento());
            enderecoAtualizado.setCidade(endereco.getCidade());
            enderecoAtualizado.setUf(endereco.getUf());

            return enderecoRepository.save(enderecoAtualizado);
        } else {

            return null;
        }
    }
}
