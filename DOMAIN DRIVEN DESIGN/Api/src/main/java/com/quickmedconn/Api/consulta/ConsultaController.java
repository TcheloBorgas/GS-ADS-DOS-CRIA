package com.quickmedconn.Api.consulta;

import com.quickmedconn.Api.medico.Medico;
import com.quickmedconn.Api.paciente.DadosListagemPaciente;
import com.quickmedconn.Api.paciente.Paciente;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("consultas")
public class ConsultaController {

    private ConsultaRepository repository;

    @Autowired
    public  ConsultaController(ConsultaRepository repository) {
        this.repository = repository;
    }
    @PostMapping
    @Transactional
    public ResponseEntity<String> cadastrar(@RequestBody DadosCadastroConsulta dados){
        try {
            Paciente paciente = new Paciente();
            Medico medico = new Medico();
            Consulta novaConsulta = new Consulta(
                    dados.getDataConsulta(),
                    dados.getHorarioConsulta(),
                    paciente,
                    medico
            );


            repository.save(novaConsulta);

            return ResponseEntity.status(HttpStatus.CREATED).body("Consulta criada com sucesso!");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Erro ao criar consulta: " + e.getMessage());
        }
    }
    ;
}
