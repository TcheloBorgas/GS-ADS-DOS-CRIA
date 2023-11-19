ALTER TABLE paciente
ADD (
    dt_nascimento DATE,
    sexo VARCHAR2(10),
    plano_saude VARCHAR2(100),
    historico_medico VARCHAR2(500)
);