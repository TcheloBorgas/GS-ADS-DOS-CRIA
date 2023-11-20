package com.quickmedconn.Api.consulta;

import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("consultas")
public class ConsultaController {

    private ConsultaRepository repository;

    public void cadastrar(@RequestBody DadosCadastroConsulta dados) {
        System.out.println("dados recebidos: ", dados);
    }

}
