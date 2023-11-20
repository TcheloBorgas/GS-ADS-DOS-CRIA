package com.quickmedconn.Api.consulta;

public interface ConsultaRepository extends JpaRepository<Consulta, Long> {
    void save(Consulta novaConsulta);
}
