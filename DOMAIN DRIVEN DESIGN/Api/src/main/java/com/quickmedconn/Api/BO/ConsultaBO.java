package com.quickmedconn.Api.BO;

import com.quickmedconn.Api.model.Consulta;
import org.springframework.stereotype.Service;
import org.springframework.util.Assert;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Service
public class ConsultaBO {

    public void validarConsulta(Consulta consulta) {

        // Verifica se a consulta não é nula
        Assert.notNull(consulta, "A consulta não pode ser nula.");

        // Verifica se a data da consulta não é nula e é uma data válida no fuso horário do servidor
        LocalDate dataConsulta = consulta.getDataConsulta();
        if (dataConsulta == null) {
            throw new IllegalArgumentException("A data da consulta não pode ser nula.");
        } else if (dataConsulta.isBefore(LocalDate.now())) {
            throw new IllegalArgumentException("A data da consulta deve ser posterior à data atual.");
        }

        // Verifica se o horário da consulta não é nulo e é um horário válido
        LocalDateTime horarioConsulta = consulta.getHorarioConsulta();
        if (horarioConsulta == null) {
            throw new IllegalArgumentException("O horário da consulta não pode ser nulo.");
        } else if (horarioConsulta.isBefore(LocalDateTime.now())) {
            throw new IllegalArgumentException("O horário da consulta deve ser posterior à hora atual.");
        }

        // Verifica se o paciente não é nulo
        Assert.notNull(consulta.getPaciente(), "O paciente não pode ser nulo.");

        // Verifica se o médico não é nulo
        Assert.notNull(consulta.getMedico(), "O médico não pode ser nulo.");
    }
}

