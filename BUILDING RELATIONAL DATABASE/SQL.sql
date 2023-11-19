-- Macelo Henrique - RM98893
-- Marcel P. Soddano - RM99841
-- Nicolas E. Inohue - RM98057
--
--

DROP TABLE sintoma CASCADE CONSTRAINTS;
DROP TABLE paciente CASCADE CONSTRAINTS; 
DROP TABLE prediagnostico CASCADE CONSTRAINTS;
DROP TABLE medico CASCADE CONSTRAINTS;
DROP TABLE consulta CASCADE CONSTRAINTS;

CREATE TABLE consulta (
    id NUMBER CONSTRAINT id_consulta_pk PRIMARY KEY,
    data_consulta DATE CONSTRAINT data_consulta_nn NOT NULL,
    horario_consulta TIMESTAMP CONSTRAINT horario_consulta_nn NOT NULL,
    paciente_id NUMBER,
    medico_id NUMBER
);

CREATE TABLE paciente (
    id NUMBER CONSTRAINT id_paciente_pk PRIMARY KEY,
    nome VARCHAR2(100) CONSTRAINT nome_paciente_nn NOT NULL,
    cpf VARCHAR2(11) CONSTRAINT cpf_paciente_uk UNIQUE NOT NULL,
    dt_nascimento DATE CONSTRAINT dt_nascimento_paciente_nn NOT NULL,
    sexo VARCHAR2(10) CONSTRAINT sexo_paciente_nn NOT NULL,
    email VARCHAR2(100) CONSTRAINT email_paciente_nn NOT NULL,
    telefone VARCHAR2(20) CONSTRAINT telefone_paciente_nn NOT NULL,
    logradouro VARCHAR2(100) CONSTRAINT endereco_paciente_nn NOT NULL,
    bairro VARCHAR2(100) CONSTRAINT bairro_paciente_nn NOT NULL,
    cep VARCHAR2(9) CONSTRAINT cep_paciente_nn NOT NULL,
    complemento VARCHAR2(100) CONSTRAINT complemento_paciente_nn NOT NULL,
    numero VARCHAR2(20) CONSTRAINT numero_paciente_nn NOT NULL,
    uf VARCHAR2(2) CONSTRAINT uf_paciente_nn NOT NULL,
    cidade VARCHAR2(100) CONSTRAINT cidade_paciente_nn NOT NULL,
    plano_saude VARCHAR2(100) CONSTRAINT plano_de_saude_paciente_nn NOT NULL,
    historico_medico VARCHAR2(500) CONSTRAINT historico_medico_paciente_nn NOT NULL,
    consulta_id NUMBER
);

CREATE TABLE medico (
    id NUMBER CONSTRAINT id_medico_pk PRIMARY KEY,
    nome VARCHAR2(100) CONSTRAINT nome_medico_nn NOT NULL,
    email varchar2(100) CONSTRAINT email_medico_nn_uk NOT NULL UNIQUE,
    crm VARCHAR2(8) CONSTRAINT crm_medico_nn_uk NOT NULL UNIQUE,
    especialidade VARCHAR2(100) CONSTRAINT especialidade_medico_nn NOT NULL,
    telefone VARCHAR2(20) CONSTRAINT telefone_medico_nn NOT NULL,
    logradouro VARCHAR2(100) CONSTRAINT logradouro_medico_nn NOT NULL,
    bairro VARCHAR(100) CONSTRAINT bairro_medico_nn NOT NULL,
    cep VARCHAR(9) CONSTRAINT cep_medico_nn NOT NULL,
    complemento VARCHAR2(100) CONSTRAINT complemento_medico_nn NOT NULL,
    numero VARCHAR2(20) CONSTRAINT numero_medico_nn NOT NULL,
    uf VARCHAR2(2) CONSTRAINT uf_medico_nn NOT NULL,
    cidade VARCHAR2(100) CONSTRAINT cidade_medico_nn NOT NULL,
    consulta_id NUMBER,
    prediagnostico_id NUMBER
);

CREATE TABLE sintoma (
    id VARCHAR2(100) CONSTRAINT id_sintoma_pk PRIMARY KEY,
    descricao VARCHAR2(300) CONSTRAINT descricao_sintoma_nn NOT NULL,
    tipo VARCHAR2(30) CONSTRAINT tipo_sintoma_nn NOT NULL,
    data_inicio DATE CONSTRAINT data_inicio_sintoma_nn NOT NULL,
    gravidade VARCHAR2(30) CONSTRAINT gravidade_sintoma_nn NOT NULL,
    observacoes VARCHAR(150),
    paciente_id NUMBER
);

CREATE TABLE prediagnostico (
    id NUMBER CONSTRAINT id_prediagnostico_pk PRIMARY KEY,
    descricao VARCHAR2(300) CONSTRAINT descricao_diagnostico_nn NOT NULL,
    data_diagnostico DATE CONSTRAINT data_diagnostico_nn NOT NULL,
    resultado VARCHAR2(50) CONSTRAINT resultado_diagnostico_nn NOT NULL,
    tratamento_recomendado VARCHAR2(50) CONSTRAINT tratamento_recomendado_nn NOT NULL,
    setor_recomendado VARCHAR2(50) CONSTRAINT setor_recomendado_nn NOT NULL,
    observacoes VARCHAR2(300),
    paciente_id NUMBER,
    medico_id NUMBER
);

-----------------------------------------------------------------------------------------------------------------------------------------------------------
--adicionando foreign keys / relação de tabelas 
ALTER TABLE paciente
ADD CONSTRAINT fk_paciente_consulta FOREIGN KEY (consulta_id) REFERENCES consulta (id);

ALTER TABLE consulta
ADD CONSTRAINT fk_consulta_paciente FOREIGN KEY (paciente_id) REFERENCES paciente (id);

ALTER TABLE consulta
ADD CONSTRAINT fk_consulta_medico FOREIGN KEY (medico_id) REFERENCES medico (id);

ALTER TABLE medico
ADD CONSTRAINT fk_medico_consulta FOREIGN KEY (consulta_id) REFERENCES consulta (id);

ALTER TABLE medico
ADD CONSTRAINT fk_medico_diagnostico FOREIGN KEY (prediagnostico_id) REFERENCES prediagnostico (id);

ALTER TABLE sintoma
ADD CONSTRAINT fk_sintoma_paciente FOREIGN KEY (paciente_id) REFERENCES paciente (id);

ALTER TABLE prediagnostico
ADD CONSTRAINT fk_prediagnostico_paciente FOREIGN KEY (paciente_id) REFERENCES paciente (id);

ALTER TABLE prediagnostico
ADD CONSTRAINT fk_prediagnostico_medico FOREIGN KEY (medico_id) REFERENCES medico (id);

-----------------------------------------------------------------------------------------------------------------------------------------------------------
-- Inserindo dados na tabela Consulta
INSERT INTO consulta (id, data_consulta, horario_consulta)
VALUES (1, TO_DATE('2023-11-17', 'YYYY-MM-DD'), TO_DATE('2023-11-17 09:00:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO consulta (id, data_consulta, horario_consulta)
VALUES (2, TO_DATE('2023-11-18', 'YYYY-MM-DD'), TO_DATE('2023-11-18 10:30:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO consulta (id, data_consulta, horario_consulta)
VALUES (3, TO_DATE('2023-11-19', 'YYYY-MM-DD'), TO_DATE('2023-11-19 14:15:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO consulta (id, data_consulta, horario_consulta)
VALUES (4, TO_DATE('2023-11-20', 'YYYY-MM-DD'), TO_DATE('2023-11-20 11:45:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO consulta (id, data_consulta, horario_consulta)
VALUES (5, TO_DATE('2023-11-21', 'YYYY-MM-DD'), TO_DATE('2023-11-21 16:30:00', 'YYYY-MM-DD HH24:MI:SS'));

-- Inserindo dados na tabela Paciente
INSERT INTO paciente (id, nome, cpf, dt_nascimento, sexo, logradouro, numero, bairro, cep, complemento, uf, cidade, telefone, email, plano_saude, historico_medico)
VALUES (101, 'John Doe', '12345678901', TO_DATE('1990-01-01', 'YYYY-MM-DD'), 'Male', '123 Main St', 101, 'City', '12345-678', 'Apto 302', 'SP', 'São Paulo', 12345678901, 'john.doe@example.com', 'Health Plan A', 'No significant history');

INSERT INTO paciente (id, nome, cpf, dt_nascimento, sexo, logradouro, numero, bairro, cep, complemento, uf, cidade, telefone, email, plano_saude, historico_medico)
VALUES (102, 'Jane Smith', '98765432101', TO_DATE('1985-05-15', 'YYYY-MM-DD'), 'Female', '456 Oak St', 202, 'Town', '54321-876', 'Casa 1', 'RJ', 'Rio de Janeiro', 98765432102, 'jane.smith@example.com', 'Health Plan B', 'Allergies to penicillin');

INSERT INTO paciente (id, nome, cpf, dt_nascimento, sexo, logradouro, numero, bairro, cep, complemento, uf, cidade, telefone, email, plano_saude, historico_medico)
VALUES (103, 'Michael Johnson', '55566677788', TO_DATE('1982-08-20', 'YYYY-MM-DD'), 'Male', '789 Pine St', 303, 'Village', '98765-432', 'Sala 105', 'MG', 'Belo Horizonte', 5551112233, 'michael.johnson@example.com', 'Health Plan C', 'Hypertension');

INSERT INTO paciente (id, nome, cpf, dt_nascimento, sexo, logradouro, numero, bairro, cep, complemento, uf, cidade, telefone, email, plano_saude, historico_medico)
VALUES (104, 'Emily Davis', '99988877766', TO_DATE('1995-04-12', 'YYYY-MM-DD'), 'Female', '987 Cedar St', 404, 'Hamlet', '45678-901', 'Andar 3', 'RS', 'Porto Alegre', 9993334455, 'emily.davis@example.com', 'Health Plan D', 'Asthma');

INSERT INTO paciente (id, nome, cpf, dt_nascimento, sexo, logradouro, numero, bairro, cep, complemento, uf, cidade, telefone, email, plano_saude, historico_medico)
VALUES (105, 'David Wilson', '11122233344', TO_DATE('1988-11-25', 'YYYY-MM-DD'), 'Male', '654 Elm St', 505, 'Borough', '65432-109', 'Bloco C', 'PR', 'Curitiba', 1112223344, 'david.wilson@example.com', 'Health Plan E', 'None');

--Inserindo dados na tabela Medico
INSERT INTO medico (id, nome, email, especialidade, telefone, crm, logradouro, bairro, cep, complemento, numero, uf, cidade)
VALUES (201, 'Dr. Anderson', 'dr.anderson@example.com', 'Cardiologist', '555-1234', 'CRM12345', 'City Hospital', 'Central District', '12345-678', 'Sala 102', 15, 'SP', 'São Paulo');

INSERT INTO medico (id, nome, email, especialidade, telefone, crm, logradouro, bairro, cep, complemento, numero, uf, cidade)
VALUES (202, 'Dr. Smith', 'dr.smith@example.com', 'Orthopedic Surgeon', '555-5678', 'CRM67890', 'Town Hospital', 'Downtown Area', '54321-876', 'Andar 5', 28, 'RJ', 'Rio de Janeiro');

INSERT INTO medico (id, nome, email, especialidade, telefone, crm, logradouro, bairro, cep, complemento, numero, uf, cidade)
VALUES (203, 'Dr. Martinez', 'dr.martinez@example.com', 'Dermatologist', '555-9876', 'CRM98765', 'Village Clinic', 'Suburbia', '98765-432', 'Apto 301', 7, 'MG', 'Belo Horizonte');

INSERT INTO medico (id, nome, email, especialidade, telefone, crm, logradouro, bairro, cep, complemento, numero, uf, cidade)
VALUES (204, 'Dr. Taylor', 'dr.taylor@example.com', 'Neurologist', '555-4321', 'CRM54321', 'Hamlet Medical Center', 'Medical District', '45678-901', 'Bloco B', 42, 'RS', 'Porto Alegre');

INSERT INTO medico (id, nome, email, especialidade, telefone, crm, logradouro, bairro, cep, complemento, numero, uf, cidade)
VALUES (205, 'Dr. White', 'dr.white@example.com', 'Pediatrician', '555-8765', 'CRM87654', 'Borough Childrens Hospital', 'Pediatric Zone', '65432-109', 'Sala 205', 10, 'PR', 'Curitiba');

-- Inserindo dados na tabela Sintoma
INSERT INTO sintoma (id, descricao, tipo, data_inicio, gravidade, observacoes)
VALUES ('SYM001', 'Headache', 'General', TO_DATE('2023-11-10', 'YYYY-MM-DD'), 'Moderate', 'None');

INSERT INTO sintoma (id, descricao, tipo, data_inicio, gravidade, observacoes)
VALUES ('SYM002', 'Back Pain', 'Orthopedic', TO_DATE('2023-11-15', 'YYYY-MM-DD'), 'Severe', 'Previous injury');

INSERT INTO sintoma (id, descricao, tipo, data_inicio, gravidade, observacoes)
VALUES ('SYM003', 'Skin Rash', 'Dermatological', TO_DATE('2023-11-19', 'YYYY-MM-DD'), 'Mild', 'Itchy and red');

INSERT INTO sintoma (id, descricao, tipo, data_inicio, gravidade, observacoes)
VALUES ('SYM004', 'Seizures', 'Neurological', TO_DATE('2023-11-20', 'YYYY-MM-DD'), 'Severe', 'Frequent episodes');

INSERT INTO sintoma (id, descricao, tipo, data_inicio, gravidade, observacoes)
VALUES ('SYM005', 'Fever', 'General', TO_DATE('2023-11-21', 'YYYY-MM-DD'), 'Moderate', 'Temperature of 101°F');

-- Inserindo dados na tabela Prediagnostico
INSERT INTO prediagnostico (id, descricao, data_diagnostico, resultado, tratamento_recomendado, setor_recomendado, observacoes)
VALUES (301, 'Cardiac Arrhythmia', TO_DATE('2023-11-17', 'YYYY-MM-DD'), 'Positive', 'Medication', 'Cardiology', 'None');

INSERT INTO prediagnostico (id, descricao, data_diagnostico, resultado, tratamento_recomendado, setor_recomendado, observacoes)
VALUES (302, 'Fractured Spine', TO_DATE('2023-11-18', 'YYYY-MM-DD'), 'Positive', 'Surgery', 'Orthopedics', 'Requires immediate attention');

INSERT INTO prediagnostico (id, descricao, data_diagnostico, resultado, tratamento_recomendado, setor_recomendado, observacoes)
VALUES (303, 'Allergic Reaction', TO_DATE('2023-11-19', 'YYYY-MM-DD'), 'Positive', 'Antihistamines', 'Dermatology', 'Prescribed medication for relief');

INSERT INTO prediagnostico (id, descricao, data_diagnostico, resultado, tratamento_recomendado, setor_recomendado, observacoes)
VALUES (304, 'Epilepsy', TO_DATE('2023-11-20', 'YYYY-MM-DD'), 'Positive', 'Antiepileptic drugs', 'Neurology', 'Scheduled follow-up tests');

INSERT INTO prediagnostico (id, descricao, data_diagnostico, resultado, tratamento_recomendado, setor_recomendado, observacoes)
VALUES (305, 'Infection', TO_DATE('2023-11-21', 'YYYY-MM-DD'), 'Positive', 'Antibiotics', 'Pediatrics', 'Advised bed rest and hydration');

-----------------------------------------------------------------------------------------------------------------------------------------------------------
--RELATORIOS
-- Seleciona consulta pelo id da consulta e data da consulta
SELECT id, data_consulta, horario_consulta
FROM consulta 
WHERE id > 5 
ORDER BY data_consulta, horario_consulta;

-- Seleciona consultas agendadas com informações de médico e paciente
SELECT c.id, c.data_consulta, c.horario_consulta, m.nome, p.nome
FROM consulta c
JOIN medico m ON c.medico_id = m.id
JOIN paciente p ON c.paciente_id = p.id
ORDER BY c.data_consulta, c.horario_consulta;

-- Seleciona pacientes com sintomas graves e os tratamentos recomendados
SELECT p.nome, s.descricao, s.gravidade, pd.tratamento_recomendado
FROM paciente p
JOIN sintoma s ON p.id = s.paciente_id
JOIN prediagnostico pd ON p.id = pd.paciente_id
WHERE s.gravidade = 'Severe'
ORDER BY p.nome;

-- Lista médicos e seus setores recomendados
SELECT m.nome, m.especialidade, pd.setor_recomendado
FROM medico m
JOIN prediagnostico pd ON m.id = pd.medico_id
ORDER BY m.nome;

-- Conta o número de pacientes por sexo e especialidade médica
SELECT p.sexo, m.especialidade, COUNT(*) AS numero_pacientes
FROM paciente p
JOIN consulta c ON p.consulta_id = c.id
JOIN medico m ON c.medico_id = m.id
GROUP BY p.sexo, m.especialidade;

-- Lista sintomas registrados por tipo e gravidade
SELECT tipo, gravidade, COUNT(*) AS numero_sintomas
FROM sintoma
GROUP BY tipo, gravidade;

-- Consulta nome do paciente, data de nascimento, sexo e nome do médico associado à consulta do paciente, apenas para pacientes do sexo feminino, ordenação é feita pelo nome do paciente.
SELECT p.nome, p.dt_nascimento, p.sexo, m.nome
FROM paciente p
LEFT JOIN consulta c ON p.consulta_id = c.id
LEFT JOIN medico m ON c.medico_id = m.id
WHERE p.sexo = 'Female'
ORDER BY p.nome;

-- Consulta nome do paciente, data de nascimento, sexo e nome do médico associado à consulta do paciente, apenas para pacientes do sexo masculino, ordenação é feita pelo nome do paciente.
SELECT p.nome, p.dt_nascimento, p.sexo, m.nome
FROM paciente p
LEFT JOIN consulta c ON p.consulta_id = c.id
LEFT JOIN medico m ON c.medico_id = m.id
WHERE p.sexo = 'Male'
ORDER BY p.nome;

-- Consulta que conta número de pacientes por plano de saúde
SELECT plano_saude, COUNT(*) AS numero_pacientes
FROM paciente
GROUP BY plano_saude;

-- Seleciona nome do paciente, data de nascimento, sexo e nome do médico associado à consulta do paciente (apenas pacientes femininos)
SELECT p.nome, p.dt_nascimento, p.sexo, m.nome
FROM paciente p
JOIN consulta c ON p.consulta_id = c.id
JOIN medico m ON c.medico_id = m.id
WHERE p.sexo = 'Female'
ORDER BY p.nome;

-- Seleciona nome do paciente, data de nascimento, sexo e nome do médico associado à consulta do paciente (apenas pacientes masculinos)
SELECT p.nome, p.dt_nascimento, p.sexo, m.nome
FROM paciente p
JOIN consulta c ON p.consulta_id = c.id
JOIN medico m ON c.medico_id = m.id
WHERE p.sexo = 'Male'
ORDER BY p.nome;

--junção de tabelas paciente e sintoma, e cálculo da média de idades para paciente com mais de um sintoma registrado e agrupa resultados pelo nome do paciente. (extract calcula idade com base na data de nascimento.)
SELECT
  p.nome,
  AVG(EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM p.dt_nascimento)) AS media_idade
FROM
  paciente p
JOIN
  sintoma s ON p.id = s.paciente_id
GROUP BY
  p.nome
HAVING
  COUNT(s.id) > 1;

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