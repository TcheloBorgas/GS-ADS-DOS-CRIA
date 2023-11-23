package com.quickmedconn.Api.view;


<<<<<<< HEAD:DOMAIN DRIVEN DESIGN/Api/src/main/java/com/quickmedconn/Api/view/DadosListagemPaciente.java
import com.quickmedconn.Api.models.Paciente;
=======
import com.quickmedconn.Api.model.Paciente;
>>>>>>> e0361684018fa17620e3b52f9b2fdfb3c35ad70c:DOMAIN DRIVEN DESIGN/Api/src/main/java/com/quickmedconn/Api/paciente/DadosListagemPaciente.java

public record DadosListagemPaciente(String nome, String email, String cpf) {
    public DadosListagemPaciente(Paciente paciente) {
        this(paciente.getNome(), paciente.getEmail(), paciente.getCpf());
    }
}