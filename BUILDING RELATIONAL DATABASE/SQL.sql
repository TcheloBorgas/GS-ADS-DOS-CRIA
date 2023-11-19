-- Macelo Henrique - RM98893
-- Marcel P. Soddano - RM99841
-- Nicolas E. Inohue - RM98057

DROP TABLE sintoma CASCADE CONSTRAINTS;
DROP TABLE paciente CASCADE CONSTRAINTS; 
DROP TABLE prediagnostico CASCADE CONSTRAINTS;
DROP TABLE medico CASCADE CONSTRAINTS;
DROP TABLE consulta CASCADE CONSTRAINTS;

CREATE TABLE consulta (
    id_consulta NUMBER CONSTRAINT id_consulta_pk PRIMARY KEY,
    data_consulta DATE CONSTRAINT data_consulta_nn NOT NULL,
    horario_consulta DATE CONSTRAINT horario_consulta_nn NOT NULL,
    paciente_id NUMBER,
    medico_id NUMBER
);

CREATE TABLE paciente (
    id_paciente NUMBER CONSTRAINT id_paciente_pk PRIMARY KEY,
    nome_paciente VARCHAR2(60) CONSTRAINT nome_paciente_nn NOT NULL,
    cpf_paciente VARCHAR2(11) CONSTRAINT cpf_paciente_uk UNIQUE NOT NULL,
    dt_nascimento_paciente DATE CONSTRAINT dt_nascimento_paciente_nn NOT NULL,
    sexo_paciente VARCHAR2(9) CONSTRAINT sexo_paciente_nn NOT NULL,
    endereco_paciente VARCHAR2(100) CONSTRAINT endereco_paciente_nn NOT NULL,
    telefone_paciente NUMBER(11),
    email_paciente VARCHAR2(100) CONSTRAINT email_paciente_nn NOT NULL,
    plano_de_saude_paciente VARCHAR2(60) CONSTRAINT plano_de_saude_paciente_nn NOT NULL,
    historico_medico_paciente VARCHAR2(300) CONSTRAINT historico_medico_paciente_nn NOT NULL,
    ficha_paciente VARCHAR2(200) CONSTRAINT ficha_paciente_nn NOT NULL,
    consulta_id NUMBER
);

CREATE TABLE medico (
    id_medico NUMBER CONSTRAINT id_medico_pk PRIMARY KEY,
    nome_medico VARCHAR2(60) CONSTRAINT nome_medico_nn NOT NULL,
    especialidade_medico VARCHAR2(50) CONSTRAINT especialidade_medico_nn NOT NULL,
    contato_medico VARCHAR2(80) CONSTRAINT contato_medico_nn NOT NULL,
    crm_medico VARCHAR2(8) CONSTRAINT crm_medico_uk UNIQUE NOT NULL,
    hospital_medico VARCHAR2(50) CONSTRAINT hospital_medico_nn NOT NULL,
    horario_atendimento_medico DATE CONSTRAINT horario_atendimento_medico_nn NOT NULL,
    consulta_id NUMBER,
    prediagnostico_id NUMBER
);

CREATE TABLE sintoma (
    simtoma_id VARCHAR2(100) CONSTRAINT id_sintoma_pk PRIMARY KEY,
    descricao_sintoma VARCHAR2(300) CONSTRAINT descricao_sintoma_nn NOT NULL,
    tipo_sintoma VARCHAR2(30) CONSTRAINT tipo_sintoma_nn NOT NULL,
    data_inicio_sintoma DATE CONSTRAINT data_inicio_sintoma_nn NOT NULL,
    gravidade_sintoma VARCHAR2(30) CONSTRAINT gravidade_sintoma_nn NOT NULL,
    observacoes_sintoma VARCHAR(150),
    paciente_id NUMBER
);

CREATE TABLE prediagnostico (
    id_diagnostico NUMBER CONSTRAINT id_prediagnostico_pk PRIMARY KEY,
    descricao_diagnostico VARCHAR2(300) CONSTRAINT descricao_diagnostico_nn NOT NULL,
    data_diagnostico DATE CONSTRAINT data_diagnostico_nn NOT NULL,
    resultado_diagnostico VARCHAR2(50) CONSTRAINT resultado_diagnostico_nn NOT NULL,
    tratamento_recomendado VARCHAR2(50) CONSTRAINT tratamento_recomendado_nn NOT NULL,
    setor_recomendado VARCHAR2(50) CONSTRAINT setor_recomendado_nn NOT NULL,
    observacoes_diagnostico VARCHAR2(300),
    paciente_id NUMBER,
    medico_id NUMBER
);

-----------------------------------------------------------------------------------------------------------------------------------------------------------
--adicionando foreign keys / relação de tabelas 
ALTER TABLE paciente
ADD CONSTRAINT fk_paciente_consulta FOREIGN KEY (consulta_id) REFERENCES consulta (id_consulta);

ALTER TABLE consulta
ADD CONSTRAINT fk_consulta_paciente FOREIGN KEY (paciente_id) REFERENCES paciente (id_paciente);

ALTER TABLE consulta
ADD CONSTRAINT fk_consulta_medico FOREIGN KEY (medico_id) REFERENCES medico (id_medico);

ALTER TABLE medico
ADD CONSTRAINT fk_medico_consulta FOREIGN KEY (consulta_id) REFERENCES consulta (id_consulta);

ALTER TABLE medico
ADD CONSTRAINT fk_medico_diagnostico FOREIGN KEY (prediagnostico_id) REFERENCES prediagnostico (id_diagnostico);

ALTER TABLE sintoma
ADD CONSTRAINT fk_sintoma_paciente FOREIGN KEY (paciente_id) REFERENCES paciente (id_paciente);

ALTER TABLE prediagnostico
ADD CONSTRAINT fk_prediagnostico_paciente FOREIGN KEY (paciente_id) REFERENCES paciente (id_paciente);

ALTER TABLE prediagnostico
ADD CONSTRAINT fk_prediagnostico_medico FOREIGN KEY (medico_id) REFERENCES medico (id_medico);

-----------------------------------------------------------------------------------------------------------------------------------------------------------
-- Inserindo dados na tabela Consulta
INSERT INTO consulta (id_consulta, data_consulta, horario_consulta)
VALUES (1, TO_DATE('2023-11-17', 'YYYY-MM-DD'), TO_DATE('2023-11-17 09:00:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO consulta (id_consulta, data_consulta, horario_consulta)
VALUES (2, TO_DATE('2023-11-18', 'YYYY-MM-DD'), TO_DATE('2023-11-18 10:30:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO consulta (id_consulta, data_consulta, horario_consulta)
VALUES (3, TO_DATE('2023-11-19', 'YYYY-MM-DD'), TO_DATE('2023-11-19 14:15:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO consulta (id_consulta, data_consulta, horario_consulta)
VALUES (4, TO_DATE('2023-11-20', 'YYYY-MM-DD'), TO_DATE('2023-11-20 11:45:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO consulta (id_consulta, data_consulta, horario_consulta)
VALUES (5, TO_DATE('2023-11-21', 'YYYY-MM-DD'), TO_DATE('2023-11-21 16:30:00', 'YYYY-MM-DD HH24:MI:SS'));

-- Inserindo dados na tabela Paciente
INSERT INTO paciente (id_paciente, nome_paciente, cpf_paciente, dt_nascimento_paciente, sexo_paciente, endereco_paciente, telefone_paciente, email_paciente, plano_de_saude_paciente, historico_medico_paciente, ficha_paciente)
VALUES (101, 'John Doe', '12345678901', TO_DATE('1990-01-01', 'YYYY-MM-DD'), 'Male', '123 Main St, City', 12345678901, 'john.doe@example.com', 'Health Plan A', 'No significant history', 'Ficha A');

INSERT INTO paciente (id_paciente, nome_paciente, cpf_paciente, dt_nascimento_paciente, sexo_paciente, endereco_paciente, telefone_paciente, email_paciente, plano_de_saude_paciente, historico_medico_paciente, ficha_paciente)
VALUES (102, 'Jane Smith', '98765432101', TO_DATE('1985-05-15', 'YYYY-MM-DD'), 'Female', '456 Oak St, Town', 98765432102, 'jane.smith@example.com', 'Health Plan B', 'Allergies to penicillin', 'Ficha B');

INSERT INTO paciente (id_paciente, nome_paciente, cpf_paciente, dt_nascimento_paciente, sexo_paciente, endereco_paciente, telefone_paciente, email_paciente, plano_de_saude_paciente, historico_medico_paciente, ficha_paciente)
VALUES (103, 'Michael Johnson', '55566677788', TO_DATE('1982-08-20', 'YYYY-MM-DD'), 'Male', '789 Pine St, Village', 5551112233, 'michael.johnson@example.com', 'Health Plan C', 'Hypertension', 'Ficha C');

INSERT INTO paciente (id_paciente, nome_paciente, cpf_paciente, dt_nascimento_paciente, sexo_paciente, endereco_paciente, telefone_paciente, email_paciente, plano_de_saude_paciente, historico_medico_paciente, ficha_paciente)
VALUES (104, 'Emily Davis', '99988877766', TO_DATE('1995-04-12', 'YYYY-MM-DD'), 'Female', '987 Cedar St, Hamlet', 9993334455, 'emily.davis@example.com', 'Health Plan D', 'Asthma', 'Ficha D');

INSERT INTO paciente (id_paciente, nome_paciente, cpf_paciente, dt_nascimento_paciente, sexo_paciente, endereco_paciente, telefone_paciente, email_paciente, plano_de_saude_paciente, historico_medico_paciente, ficha_paciente)
VALUES (105, 'David Wilson', '11122233344', TO_DATE('1988-11-25', 'YYYY-MM-DD'), 'Male', '654 Elm St, Borough', 1112223344, 'david.wilson@example.com', 'Health Plan E', 'None', 'Ficha E');

-- Inserindo dados na tabela Medico
INSERT INTO medico (id_medico, nome_medico, especialidade_medico, contato_medico, crm_medico, hospital_medico, horario_atendimento_medico)
VALUES (201, 'Dr. Anderson', 'Cardiologist', '555-1234', 'CRM12345', 'City Hospital', TO_DATE('2023-11-17 08:00:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO medico (id_medico, nome_medico, especialidade_medico, contato_medico, crm_medico, hospital_medico, horario_atendimento_medico)
VALUES (202, 'Dr. Smith', 'Orthopedic Surgeon', '555-5678', 'CRM67890', 'Town Hospital', TO_DATE('2023-11-18 10:00:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO medico (id_medico, nome_medico, especialidade_medico, contato_medico, crm_medico, hospital_medico, horario_atendimento_medico)
VALUES (203, 'Dr. Martinez', 'Dermatologist', '555-9876', 'CRM98765', 'Village Clinic', TO_DATE('2023-11-19 14:00:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO medico (id_medico, nome_medico, especialidade_medico, contato_medico, crm_medico, hospital_medico, horario_atendimento_medico)
VALUES (204, 'Dr. Taylor', 'Neurologist', '555-4321', 'CRM54321', 'Hamlet Medical Center', TO_DATE('2023-11-20 11:30:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO medico (id_medico, nome_medico, especialidade_medico, contato_medico, crm_medico, hospital_medico, horario_atendimento_medico)
VALUES (205, 'Dr. White', 'Pediatrician', '555-8765', 'CRM87654', 'Borough Childrens Hospital', TO_DATE('2023-11-21 16:15:00', 'YYYY-MM-DD HH24:MI:SS'));

-- Inserindo dados na tabela Sintoma
INSERT INTO sintoma (simtoma_id, descricao_sintoma, tipo_sintoma, data_inicio_sintoma, gravidade_sintoma, observacoes_sintoma)
VALUES ('SYM001', 'Headache', 'General', TO_DATE('2023-11-10', 'YYYY-MM-DD'), 'Moderate', 'None');

INSERT INTO sintoma (simtoma_id, descricao_sintoma, tipo_sintoma, data_inicio_sintoma, gravidade_sintoma, observacoes_sintoma)
VALUES ('SYM002', 'Back Pain', 'Orthopedic', TO_DATE('2023-11-15', 'YYYY-MM-DD'), 'Severe', 'Previous injury');

INSERT INTO sintoma (simtoma_id, descricao_sintoma, tipo_sintoma, data_inicio_sintoma, gravidade_sintoma, observacoes_sintoma)
VALUES ('SYM003', 'Skin Rash', 'Dermatological', TO_DATE('2023-11-19', 'YYYY-MM-DD'), 'Mild', 'Itchy and red');

INSERT INTO sintoma (simtoma_id, descricao_sintoma, tipo_sintoma, data_inicio_sintoma, gravidade_sintoma, observacoes_sintoma)
VALUES ('SYM004', 'Seizures', 'Neurological', TO_DATE('2023-11-20', 'YYYY-MM-DD'), 'Severe', 'Frequent episodes');

INSERT INTO sintoma (simtoma_id, descricao_sintoma, tipo_sintoma, data_inicio_sintoma, gravidade_sintoma, observacoes_sintoma)
VALUES ('SYM005', 'Fever', 'General', TO_DATE('2023-11-21', 'YYYY-MM-DD'), 'Moderate', 'Temperature of 101°F');

-- Inserindo dados na tabela Prediagnostico
INSERT INTO prediagnostico (id_diagnostico, descricao_diagnostico, data_diagnostico, resultado_diagnostico, tratamento_recomendado, setor_recomendado, observacoes_diagnostico)
VALUES (301, 'Cardiac Arrhythmia', TO_DATE('2023-11-17', 'YYYY-MM-DD'), 'Positive', 'Medication', 'Cardiology', 'None');

INSERT INTO prediagnostico (id_diagnostico, descricao_diagnostico, data_diagnostico, resultado_diagnostico, tratamento_recomendado, setor_recomendado, observacoes_diagnostico)
VALUES (302, 'Fractured Spine', TO_DATE('2023-11-18', 'YYYY-MM-DD'), 'Positive', 'Surgery', 'Orthopedics', 'Requires immediate attention');

INSERT INTO prediagnostico (id_diagnostico, descricao_diagnostico, data_diagnostico, resultado_diagnostico, tratamento_recomendado, setor_recomendado, observacoes_diagnostico)
VALUES (303, 'Allergic Reaction', TO_DATE('2023-11-19', 'YYYY-MM-DD'), 'Positive', 'Antihistamines', 'Dermatology', 'Prescribed medication for relief');

INSERT INTO prediagnostico (id_diagnostico, descricao_diagnostico, data_diagnostico, resultado_diagnostico, tratamento_recomendado, setor_recomendado, observacoes_diagnostico)
VALUES (304, 'Epilepsy', TO_DATE('2023-11-20', 'YYYY-MM-DD'), 'Positive', 'Antiepileptic drugs', 'Neurology', 'Scheduled follow-up tests');

INSERT INTO prediagnostico (id_diagnostico, descricao_diagnostico, data_diagnostico, resultado_diagnostico, tratamento_recomendado, setor_recomendado, observacoes_diagnostico)
VALUES (305, 'Infection', TO_DATE('2023-11-21', 'YYYY-MM-DD'), 'Positive', 'Antibiotics', 'Pediatrics', 'Advised bed rest and hydration');

-----------------------------------------------------------------------------------------------------------------------------------------------------------
--RELATORIOS
--seleciona consulta de id da consulta e data da consulta 
SELECT id_consulta, data_consulta, horario_consulta
FROM consulta 
WHERE id_consulta > 5 
ORDER BY data_consulta, horario_consulta;

-- Seleciona consultas agendadas com informações de médico e paciente
SELECT c.id_consulta, c.data_consulta, c.horario_consulta, m.nome_medico, p.nome_paciente
FROM consulta c
JOIN medico m ON c.medico_id = m.id_medico
JOIN paciente p ON c.paciente_id = p.id_paciente
ORDER BY c.data_consulta, c.horario_consulta;

-- Seleciona pacientes com sintomas graves e os tratamentos recomendados
SELECT p.nome_paciente, s.descricao_sintoma, s.gravidade_sintoma, pd.tratamento_recomendado
FROM paciente p
JOIN sintoma s ON p.id_paciente = s.paciente_id
JOIN prediagnostico pd ON p.id_paciente = pd.paciente_id
WHERE s.gravidade_sintoma = 'Severe'
ORDER BY p.nome_paciente;

-- Lista médicos e seus setores recomendados
SELECT m.nome_medico, m.especialidade_medico, pd.setor_recomendado
FROM medico m
JOIN prediagnostico pd ON m.prediagnostico_id = pd.id_diagnostico
ORDER BY m.nome_medico;

-- Conta o número de pacientes por sexo e especialidade médica
SELECT p.sexo_paciente, m.especialidade_medico, COUNT(*) AS numero_pacientes
FROM paciente p
JOIN consulta c ON p.consulta_id = c.id_consulta
JOIN medico m ON c.medico_id = m.id_medico
GROUP BY p.sexo_paciente, m.especialidade_medico;

-- Lista sintomas registrados por tipo e gravidade
SELECT tipo_sintoma, gravidade_sintoma, COUNT(*) AS numero_sintomas
FROM sintoma
GROUP BY tipo_sintoma, gravidade_sintoma;

--consulta nome do paciente, data de nascimento, sexo e nome do medico associado a consulta do paciente, apenas para pacientes do sexo feminino, ordenação é feita pelo nome do paciente.
SELECT p.nome_paciente, p.dt_nascimento_paciente, p.sexo_paciente, m.nome_medico
FROM paciente p
LEFT JOIN consulta c ON p.consulta_id = c.id_consulta
LEFT JOIN medico m ON c.medico_id = m.id_medico
WHERE p.sexo_paciente = 'Female'
ORDER BY p.nome_paciente;

--consulta nome do paciente, data de nascimento, sexo e nome do medico associado a consulta do paciente, apenas para pacientes do sexo masculino, ordenação é feita pelo nome do paciente.
SELECT p.nome_paciente, p.dt_nascimento_paciente, p.sexo_paciente, m.nome_medico
FROM paciente p
LEFT JOIN consulta c ON p.consulta_id = c.id_consulta
LEFT JOIN medico m ON c.medico_id = m.id_medico
WHERE p.sexo_paciente = 'Male'
ORDER BY p.nome_paciente;

--consulta que conta número de pacientes por plano de saúde
SELECT plano_de_saude_paciente, COUNT(*) AS numero_pacientes
FROM paciente
GROUP BY plano_de_saude_paciente;

-- Seleciona nome do paciente, data de nascimento, sexo e nome do médico associado à consulta do paciente (apenas pacientes femininos)
SELECT p.nome_paciente, p.dt_nascimento_paciente, p.sexo_paciente, m.nome_medico
FROM paciente p
JOIN consulta c ON p.consulta_id = c.id_consulta
JOIN medico m ON c.medico_id = m.id_medico
WHERE p.sexo_paciente = 'Female'
ORDER BY p.nome_paciente;

-- Seleciona nome do paciente, data de nascimento, sexo e nome do médico associado à consulta do paciente (apenas pacientes masculinos)
SELECT p.nome_paciente, p.dt_nascimento_paciente, p.sexo_paciente, m.nome_medico
FROM paciente p
JOIN consulta c ON p.consulta_id = c.id_consulta
JOIN medico m ON c.medico_id = m.id_medico
WHERE p.sexo_paciente = 'Male'
ORDER BY p.nome_paciente;

--junção de tabelas paciente e sintoma, e cálculo da média de idades para paciente com mais de um sintoma registrado e agrupa resultados pelo nome do paciente. (extract calcula idade com base na data de nascimento.)
SELECT
  p.nome_paciente,
  AVG(EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM p.dt_nascimento_paciente)) AS media_idade
FROM
  paciente p
JOIN
  sintoma s ON p.id_paciente = s.paciente_id
GROUP BY
  p.nome_paciente
HAVING
  COUNT(s.simtoma_id) > 1;

DESC paciente;
DESC medico;
DESC consulta;
DESC prediagnostico;
DESC sintoma;

SELECT * FROM paciente;
SELECT * FROM medico;
SELECT * FROM consulta;
SELECT * FROM prediagnostico;
SELECT * FROM sintoma;