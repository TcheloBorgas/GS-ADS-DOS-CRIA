-- Henry Komatsu - RM550684
-- Marcel Soddano - RM99841
-- Marcelo Henrique - RM98893
-- Nicolas Inohue - RM98057
-- Ricardo Brito - RM98370

DROP TABLE paciente CASCADE CONSTRAINTS;
DROP TABLE medico CASCADE CONSTRAINTS;
DROP TABLE endereco CASCADE CONSTRAINTS;
DROP TABLE especialidade CASCADE CONSTRAINTS;
DROP TABLE plano_saude CASCADE CONSTRAINTS;
DROP TABLE exame_sangue CASCADE CONSTRAINTS;
DROP TABLE exame_mri CASCADE CONSTRAINTS;
DROP TABLE consulta CASCADE CONSTRAINTS;
DROP TABLE prediagnostico CASCADE CONSTRAINTS;

CREATE TABLE consulta (
    id NUMBER CONSTRAINT id_consulta_pk PRIMARY KEY,
    data_consulta DATE CONSTRAINT data_consulta_nn NOT NULL,
    horario_consulta TIMESTAMP CONSTRAINT horario_consulta_nn NOT NULL,
    paciente_id NUMBER,
    medico_id NUMBER,
    id_prediagnostico NUMBER
);

CREATE TABLE paciente (
    id NUMBER CONSTRAINT id_paciente_pk PRIMARY KEY,
    nome VARCHAR2(100) CONSTRAINT nome_paciente_nn NOT NULL,
    cpf VARCHAR2(11) CONSTRAINT cpf_paciente_uk UNIQUE NOT NULL,
    dt_nascimento DATE CONSTRAINT dt_nascimento_paciente_nn NOT NULL,
    sexo VARCHAR2(10) CONSTRAINT sexo_paciente_nn NOT NULL,
    email VARCHAR2(100) CONSTRAINT email_paciente_nn NOT NULL,
    telefone VARCHAR2(20) CONSTRAINT telefone_paciente_nn NOT NULL,
    historico_medico VARCHAR2(500) CONSTRAINT historico_medico_paciente_nn NOT NULL,
    id_endereco NUMBER,
    id_planosaude NUMBER,
    id_prediagnostico NUMBER,
    id_especialidade NUMBER,
    consulta_id NUMBER
);

CREATE TABLE medico (
    id NUMBER CONSTRAINT id_medico_pk PRIMARY KEY,
    nome VARCHAR2(100) CONSTRAINT nome_medico_nn NOT NULL,
    email VARCHAR2(100) CONSTRAINT email_medico_nn_uk NOT NULL UNIQUE,
    crm VARCHAR2(8) CONSTRAINT crm_medico_nn_uk NOT NULL UNIQUE,
    telefone VARCHAR2(20) CONSTRAINT telefone_medico_nn NOT NULL,
    id_endereco NUMBER,
    consulta_id NUMBER,
    id_especialidade NUMBER,
    prediagnostico_id NUMBER
);

CREATE TABLE endereco (
    id NUMBER CONSTRAINT id_endereco_pk PRIMARY KEY,
    logradouro VARCHAR2(100) CONSTRAINT endereco_endereco_nn NOT NULL,
    bairro VARCHAR2(100) CONSTRAINT bairro_endereco_nn NOT NULL,
    cep VARCHAR2(9) CONSTRAINT cep_endereco_nn NOT NULL,
    complemento VARCHAR2(100) CONSTRAINT complemento_endereco_nn NOT NULL,
    numero VARCHAR2(20) CONSTRAINT numero_endereco_nn NOT NULL,
    uf VARCHAR2(2) CONSTRAINT uf_endereco_nn NOT NULL,
    cidade VARCHAR2(100) CONSTRAINT cidade_endereco_nn NOT NULL
);

CREATE TABLE especialidade (
    id NUMBER CONSTRAINT id_especialidade_pk PRIMARY KEY,
    nome VARCHAR(100) CONSTRAINT nome_especialidade_nn NOT NULL
);

CREATE TABLE plano_saude (
    id NUMBER CONSTRAINT id_planosaude_pk PRIMARY KEY,
    nome VARCHAR(255) CONSTRAINT nome_planosaude_nn NOT NULL,
    descricao VARCHAR2(300) CONSTRAINT descricao_planosaude_nn NOT NULL
);

CREATE TABLE exame_sangue (
    id NUMBER CONSTRAINT id_examesangue_pk PRIMARY KEY,
    leukocytes FLOAT(6) CONSTRAINT leukocytes_examesangue_nn NOT NULL,
    platelets FLOAT(6) CONSTRAINT platelets_examesangue_nn NOT NULL,
    mean_platelet_volume FLOAT(6) CONSTRAINT meanplatvol_examesangue_nn NOT NULL,
    eosinophils FLOAT(6) CONSTRAINT eosinophils_examesangue_nn NOT NULL,
    proteinac_reativa FLOAT(6) CONSTRAINT proteinac_examesangue_nn NOT NULL,
    id_paciente NUMBER,
    id_consulta NUMBER
);

CREATE TABLE exame_mri (
    id NUMBER CONSTRAINT id_examemri_pk PRIMARY KEY,
    image_path VARCHAR2(300) CONSTRAINT imagepath_examemri_nn NOT NULL,
    tumor_type VARCHAR2(300) CONSTRAINT tumortype_examemri_nn NOT NULL,
    tumor_probability FLOAT(6) CONSTRAINT tumorprob_examemri_nn NOT NULL,
    id_paciente NUMBER,
    id_consulta NUMBER
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

ALTER TABLE paciente
ADD CONSTRAINT fk_paciente_endereco FOREIGN KEY (id_endereco) REFERENCES endereco(id);

ALTER TABLE paciente
ADD CONSTRAINT fk_paciente_planosaude FOREIGN KEY (id_planosaude) REFERENCES plano_saude(id);

ALTER TABLE consulta
ADD CONSTRAINT fk_consulta_paciente FOREIGN KEY (paciente_id) REFERENCES paciente (id);

ALTER TABLE consulta
ADD CONSTRAINT fk_consulta_medico FOREIGN KEY (medico_id) REFERENCES medico (id);

ALTER TABLE consulta
ADD CONSTRAINT fk_consulta_prediagnostico FOREIGN KEY (id_prediagnostico) REFERENCES prediagnostico(id);

ALTER TABLE medico
ADD CONSTRAINT fk_medico_consulta FOREIGN KEY (consulta_id) REFERENCES consulta (id);

ALTER TABLE medico
ADD CONSTRAINT fk_medico_diagnostico FOREIGN KEY (prediagnostico_id) REFERENCES prediagnostico (id);

ALTER TABLE medico
ADD CONSTRAINT fk_medico_endereco FOREIGN KEY (id_endereco) REFERENCES endereco(id);

ALTER TABLE medico
ADD CONSTRAINT fk_medico_especialidade FOREIGN KEY (id_especialidade) REFERENCES especialidade(id);

ALTER TABLE prediagnostico
ADD CONSTRAINT fk_prediagnostico_paciente FOREIGN KEY (paciente_id) REFERENCES paciente (id);

ALTER TABLE prediagnostico
ADD CONSTRAINT fk_prediagnostico_medico FOREIGN KEY (medico_id) REFERENCES medico (id);

ALTER TABLE exame_sangue
ADD CONSTRAINT fk_examesangue_paciente FOREIGN KEY (id_paciente) REFERENCES paciente(id);

ALTER TABLE exame_sangue
ADD CONSTRAINT fk_examesangue_consulta FOREIGN KEY (id_consulta) REFERENCES consulta(id);

ALTER TABLE exame_mri
ADD CONSTRAINT fk_examemri_paciente FOREIGN KEY (id_paciente) REFERENCES paciente(id);

ALTER TABLE exame_mri
ADD CONSTRAINT fk_examemri_consulta FOREIGN KEY (id_consulta) REFERENCES CONSULTA(id);

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

INSERT INTO consulta (id, data_consulta, horario_consulta)
VALUES (6, TO_DATE('2023-11-22', 'YYYY-MM-DD'), TO_DATE('2023-11-22 08:45:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO consulta (id, data_consulta, horario_consulta)
VALUES (7, TO_DATE('2023-11-23', 'YYYY-MM-DD'), TO_DATE('2023-11-23 13:00:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO consulta (id, data_consulta, horario_consulta)
VALUES (8, TO_DATE('2023-11-24', 'YYYY-MM-DD'), TO_DATE('2023-11-24 10:15:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO consulta (id, data_consulta, horario_consulta)
VALUES (9, TO_DATE('2023-11-25', 'YYYY-MM-DD'), TO_DATE('2023-11-25 15:30:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO consulta (id, data_consulta, horario_consulta)
VALUES (10, TO_DATE('2023-11-26', 'YYYY-MM-DD'), TO_DATE('2023-11-26 11:00:00', 'YYYY-MM-DD HH24:MI:SS'));

-- Inserindo dados na tabela Paciente
INSERT INTO paciente (id, nome, cpf, dt_nascimento, sexo, email, telefone, historico_medico)
VALUES (101, 'John Doe', '12345678901', TO_DATE('1990-01-01', 'YYYY-MM-DD'), 'Male', 'john.doe@example.com', 'Health Plan A', 'No significant history');

INSERT INTO paciente (id, nome, cpf, dt_nascimento, sexo, email, telefone, historico_medico)
VALUES (102, 'Jane Smith', '98765432101', TO_DATE('1985-05-15', 'YYYY-MM-DD'), 'Female', 'jane.smith@example.com', 'Health Plan B', 'Allergies to penicillin');

INSERT INTO paciente (id, nome, cpf, dt_nascimento, sexo, email, telefone, historico_medico)
VALUES (103, 'Michael Johnson', '55566677788', TO_DATE('1982-08-20', 'YYYY-MM-DD'), 'Male', 'michael.johnson@example.com', 'Health Plan C', 'Hypertension');

INSERT INTO paciente (id, nome, cpf, dt_nascimento, sexo, email, telefone, historico_medico)
VALUES (104, 'Emily Davis', '99988877766', TO_DATE('1995-04-12', 'YYYY-MM-DD'), 'Female', 'emily.davis@example.com', 'Health Plan D', 'Asthma');

INSERT INTO paciente (id, nome, cpf, dt_nascimento, sexo, email, telefone, historico_medico)
VALUES (105, 'David Wilson', '11122233344', TO_DATE('1988-11-25', 'YYYY-MM-DD'), 'Male', 'david.wilson@example.com', 'Health Plan E', 'None');

INSERT INTO paciente (id, nome, cpf, dt_nascimento, sexo, email, telefone, historico_medico)
VALUES (106, 'Isabel Silva', '77788899900', TO_DATE('1993-07-08', 'YYYY-MM-DD'), 'Female', 'isabel.silva@example.com', 'Health Plan F', 'None');

INSERT INTO paciente (id, nome, cpf, dt_nascimento, sexo, email, telefone, historico_medico)
VALUES (107, 'Carlos Oliveira', '33344455566', TO_DATE('1980-03-17', 'YYYY-MM-DD'), 'Male', 'carlos.oliveira@example.com', 'Health Plan G', 'Diabetes');

INSERT INTO paciente (id, nome, cpf, dt_nascimento, sexo, email, telefone, historico_medico)
VALUES (108, 'Fernanda Santos', '12121212121', TO_DATE('1997-12-05', 'YYYY-MM-DD'), 'Female', 'fernanda.santos@example.com', 'Health Plan H', 'Migraine');

INSERT INTO paciente (id, nome, cpf, dt_nascimento, sexo, email, telefone, historico_medico)
VALUES (109, 'Ricardo Lima', '45454545454', TO_DATE('1984-09-22', 'YYYY-MM-DD'), 'Male', 'ricardo.lima@example.com', 'Health Plan I', 'High cholesterol');

INSERT INTO paciente (id, nome, cpf, dt_nascimento, sexo, email, telefone, historico_medico)
VALUES (110, 'Camila Pereira', '66677788899', TO_DATE('1992-02-14', 'YYYY-MM-DD'), 'Female', 'camila.pereira@example.com', 'Health Plan J', 'None');

--Inserindo dados na tabela Medico
INSERT INTO medico (id, nome, email, telefone, crm)
VALUES (201, 'Dr. Anderson', 'dr.anderson@example.com', '555-1234', 'CRM12345');

INSERT INTO medico (id, nome, email, telefone, crm)
VALUES (202, 'Dr. Smith', 'dr.smith@example.com', '555-5678', 'CRM67890');

INSERT INTO medico (id, nome, email, telefone, crm)
VALUES (203, 'Dr. Martinez', 'dr.martinez@example.com', '555-9876', 'CRM98765');

INSERT INTO medico (id, nome, email, telefone, crm)
VALUES (204, 'Dr. Taylor', 'dr.taylor@example.com', '555-4321', 'CRM54321');

INSERT INTO medico (id, nome, email, telefone, crm)
VALUES (205, 'Dr. White', 'dr.white@example.com', '555-8765', 'CRM87654');

INSERT INTO medico (id, nome, email, telefone, crm)
VALUES (206, 'Dra. Oliveira', 'dra.oliveira@example.com', '555-3456', 'CRM34567');

INSERT INTO medico (id, nome, email, telefone, crm)
VALUES (207, 'Dr. Pereira', 'dr.pereira@example.com', '555-7890', 'CRM78901');

INSERT INTO medico (id, nome, email, telefone, crm)
VALUES (208, 'Dra. Lima', 'dra.lima@example.com', '555-0123', 'CRM01234');

INSERT INTO medico (id, nome, email, telefone, crm)
VALUES (209, 'Dr. Santos', 'dr.santos@example.com', '555-3417', 'CRM32561');

INSERT INTO medico (id, nome, email, telefone, crm)
VALUES (210, 'Dra. Pereira', 'dra.pereira@example.com', '555-7836', 'CRM98911');

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

INSERT INTO prediagnostico (id, descricao, data_diagnostico, resultado, tratamento_recomendado, setor_recomendado, observacoes)
VALUES (306, 'Respiratory Infection', TO_DATE('2023-11-22', 'YYYY-MM-DD'), 'Positive', 'Antibiotics', 'Pulmonology', 'Rest and fluids recommended');

INSERT INTO prediagnostico (id, descricao, data_diagnostico, resultado, tratamento_recomendado, setor_recomendado, observacoes)
VALUES (307, 'Herniated Disc', TO_DATE('2023-11-23', 'YYYY-MM-DD'), 'Positive', 'Physical Therapy', 'Orthopedics', 'Avoid heavy lifting and follow exercise regimen');

INSERT INTO prediagnostico (id, descricao, data_diagnostico, resultado, tratamento_recomendado, setor_recomendado, observacoes)
VALUES (308, 'Skin Rash', TO_DATE('2023-11-24', 'YYYY-MM-DD'), 'Positive', 'Topical Cream', 'Dermatology', 'Keep the affected area clean and dry');

INSERT INTO prediagnostico (id, descricao, data_diagnostico, resultado, tratamento_recomendado, setor_recomendado, observacoes)
VALUES (309, 'Migraine', TO_DATE('2023-11-25', 'YYYY-MM-DD'), 'Positive', 'Pain Medication', 'Neurology', 'Avoid triggers and maintain regular sleep');

INSERT INTO prediagnostico (id, descricao, data_diagnostico, resultado, tratamento_recomendado, setor_recomendado, observacoes)
VALUES (310, 'Stomach Flu', TO_DATE('2023-11-26', 'YYYY-MM-DD'), 'Positive', 'Fluids and Rest', 'Gastroenterology', 'Watch for dehydration and follow a bland diet');

-- Inserts para a tabela endereco
INSERT INTO endereco
VALUES (1, 'Rua da Paz, 123', 'Centro', '12345-678', 'Apto 101', '123', 'SP', 'São Paulo');

INSERT INTO endereco
VALUES (2, 'Avenida da Liberdade, 456', 'Jardins', '98765-432', 'Casa 202', '456', 'RJ', 'Rio de Janeiro');

INSERT INTO endereco
VALUES (3, 'Rua das Flores, 789', 'Floresta', '54321-876', 'Casa 303', '789', 'MG', 'Belo Horizonte');

INSERT INTO endereco
VALUES (4, 'Avenida Principal, 101', 'Centro', '87654-321', 'Apto 404', '101', 'RJ', 'Rio de Janeiro');

INSERT INTO endereco
VALUES (5, 'Rua das Árvores, 202', 'Jardim', '23456-789', 'Casa 505', '202', 'SP', 'São Paulo');

INSERT INTO endereco
VALUES (6, 'Avenida dos Pássaros, 303', 'Parque', '76543-210', 'Apto 606', '303', 'MG', 'Belo Horizonte');

INSERT INTO endereco
VALUES (7, 'Rua dos Girassóis, 404', 'Jardim', '87654-321', 'Casa 707', '404', 'RJ', 'Rio de Janeiro');

INSERT INTO endereco
VALUES (8, 'Avenida da Serra, 505', 'Montanha', '34567-890', 'Apto 808', '505', 'SP', 'São Paulo');

INSERT INTO endereco
VALUES (9, 'Rua do Riacho, 606', 'Vale', '67890-123', 'Casa 909', '606', 'MG', 'Belo Horizonte');

INSERT INTO endereco
VALUES (10, 'Avenida do Mar, 707', 'Praia', '98765-432', 'Apto 1010', '707', 'RJ', 'Rio de Janeiro');

-- Inserts para a tabela especialidade
INSERT INTO especialidade
VALUES (1, 'Cardiologia');

INSERT INTO especialidade
VALUES (2, 'Ortopedia');

INSERT INTO especialidade
VALUES (3, 'Dermatologia');

INSERT INTO especialidade
VALUES (4, 'Neurologia');

INSERT INTO especialidade
VALUES (5, 'Oftalmologia');

INSERT INTO especialidade
VALUES (6, 'Pediatria');

INSERT INTO especialidade
VALUES (7, 'Psiquiatria');

INSERT INTO especialidade
VALUES (8, 'Ginecologia');

INSERT INTO especialidade
VALUES (9, 'Urologia');

INSERT INTO especialidade
VALUES (10, 'Ortopedia');

-- Inserts para a tabela plano_saude
INSERT INTO plano_saude
VALUES (1, 'Plano Saúde SP', 'Plano de Saúde para São Paulo');

INSERT INTO plano_saude
VALUES (2, 'Plano Saúde RJ', 'Plano de Saúde para Rio de Janeiro');

INSERT INTO plano_saude
VALUES (3, 'Plano Saúde MG', 'Plano de Saúde para Minas Gerais');

INSERT INTO plano_saude
VALUES (4, 'Plano Saúde BA', 'Plano de Saúde para Bahia');

INSERT INTO plano_saude
VALUES (5, 'Plano Saúde RS', 'Plano de Saúde para Rio Grande do Sul');

INSERT INTO plano_saude
VALUES (6, 'Plano Saúde PR', 'Plano de Saúde para Paraná');

INSERT INTO plano_saude
VALUES (7, 'Plano Saúde SC', 'Plano de Saúde para Santa Catarina');

INSERT INTO plano_saude
VALUES (8, 'Plano Saúde PE', 'Plano de Saúde para Pernambuco');

INSERT INTO plano_saude
VALUES (9, 'Plano Saúde CE', 'Plano de Saúde para Ceará');

INSERT INTO plano_saude
VALUES (10, 'Plano Saúde DF', 'Plano de Saúde para Distrito Federal');

-- Inserts para a tabela exame_sangue
INSERT INTO exame_sangue (id, leukocytes, platelets, mean_platelet_volume, eosinophils, proteinac_reativa)
VALUES (1, 7.2, 250000, 8.5, 1.5, 0.8);

INSERT INTO exame_sangue (id, leukocytes, platelets, mean_platelet_volume, eosinophils, proteinac_reativa)
VALUES (2, 6.8, 300000, 9.0, 2.0, 1.2);

INSERT INTO exame_sangue (id, leukocytes, platelets, mean_platelet_volume, eosinophils, proteinac_reativa)
VALUES (3, 7.5, 280000, 8.8, 1.8, 1.0);

INSERT INTO exame_sangue (id, leukocytes, platelets, mean_platelet_volume, eosinophils, proteinac_reativa)
VALUES (4, 6.5, 260000, 8.0, 1.2, 0.5);

INSERT INTO exame_sangue (id, leukocytes, platelets, mean_platelet_volume, eosinophils, proteinac_reativa)
VALUES (5, 7.0, 270000, 8.2, 1.6, 0.9);

INSERT INTO exame_sangue (id, leukocytes, platelets, mean_platelet_volume, eosinophils, proteinac_reativa)
VALUES (6, 7.8, 310000, 9.5, 2.5, 1.5);

INSERT INTO exame_sangue (id, leukocytes, platelets, mean_platelet_volume, eosinophils, proteinac_reativa)
VALUES (7, 6.3, 240000, 7.8, 1.0, 0.3);

INSERT INTO exame_sangue (id, leukocytes, platelets, mean_platelet_volume, eosinophils, proteinac_reativa)
VALUES (8, 7.4, 260000, 8.1, 1.3, 0.6);

INSERT INTO exame_sangue (id, leukocytes, platelets, mean_platelet_volume, eosinophils, proteinac_reativa)
VALUES (9, 6.6, 290000, 9.2, 2.2, 1.3);

INSERT INTO exame_sangue (id, leukocytes, platelets, mean_platelet_volume, eosinophils, proteinac_reativa)
VALUES (10, 7.1, 280000, 8.7, 1.7, 0.7);

-- Inserts para a tabela exame_mri
INSERT INTO exame_mri (id, image_path, tumor_type, tumor_probability)
VALUES (1, '/imagens/paciente1/mri1.jpg', 'Benigno', 0.15);

INSERT INTO exame_mri (id, image_path, tumor_type, tumor_probability)
VALUES (2, '/imagens/paciente2/mri2.jpg', 'Maligno', 0.85);

INSERT INTO exame_mri (id, image_path, tumor_type, tumor_probability)
VALUES (3, '/imagens/paciente3/mri3.jpg', 'Maligno', 0.78);

INSERT INTO exame_mri (id, image_path, tumor_type, tumor_probability)
VALUES (4, '/imagens/paciente4/mri4.jpg', 'Benigno', 0.22);

INSERT INTO exame_mri (id, image_path, tumor_type, tumor_probability)
VALUES (5, '/imagens/paciente5/mri5.jpg', 'Maligno', 0.91);

INSERT INTO exame_mri (id, image_path, tumor_type, tumor_probability)
VALUES (6, '/imagens/paciente6/mri6.jpg', 'Benigno', 0.12);

INSERT INTO exame_mri (id, image_path, tumor_type, tumor_probability)
VALUES (7, '/imagens/paciente7/mri7.jpg', 'Maligno', 0.77);

INSERT INTO exame_mri (id, image_path, tumor_type, tumor_probability)
VALUES (8, '/imagens/paciente8/mri8.jpg', 'Benigno', 0.29);

INSERT INTO exame_mri (id, image_path, tumor_type, tumor_probability)
VALUES (9, '/imagens/paciente9/mri9.jpg', 'Maligno', 0.68);

INSERT INTO exame_mri (id, image_path, tumor_type, tumor_probability)
VALUES (10, '/imagens/paciente10/mri10.jpg', 'Benigno', 0.18);





-----------------------------------------------------------------------------------------------------------------------------------------------------------
--RELATORIOS
-- Seleciona consulta pelo id da consulta e data da consulta
SELECT id, data_consulta, horario_consulta
FROM consulta 
WHERE id > 5 
ORDER BY data_consulta, horario_consulta;

-- Seleciona consultas agendadas com informações de médico e paciente
SELECT c.id, c.data_consulta, c.horario_consulta, m.nome AS nome_medico, p.nome AS nome_paciente
FROM consulta c
JOIN medico m ON c.medico_id = m.id
JOIN paciente p ON c.paciente_id = p.id
ORDER BY c.data_consulta, c.horario_consulta;

-- Lista médicos e seus setores recomendados
SELECT m.nome AS nome_medico, e.nome AS nome_especialidade, pd.setor_recomendado
FROM medico m
JOIN prediagnostico pd ON m.id = pd.medico_id
JOIN especialidade e ON m.id_especialidade = e.id
ORDER BY m.nome;

-- Conta o número de pacientes por sexo e especialidade médica
SELECT p.sexo, e.nome AS nome_especialidade, COUNT(*) AS numero_pacientes
FROM paciente p
JOIN consulta c ON p.id = c.paciente_id
JOIN medico m ON c.medico_id = m.id
JOIN especialidade e ON m.id_especialidade = e.id
GROUP BY p.sexo, e.nome;

-- Consulta nome do paciente, data de nascimento, sexo e nome do médico associado à consulta do paciente, apenas para pacientes do sexo feminino, ordenação é feita pelo nome do paciente.
SELECT p.nome, p.dt_nascimento, p.sexo, m.nome AS nome_medico
FROM paciente p
LEFT JOIN consulta c ON p.consulta_id = c.id
LEFT JOIN medico m ON c.medico_id = m.id
WHERE p.sexo = 'Female'
ORDER BY p.nome;

-- Consulta nome do paciente, data de nascimento, sexo e nome do médico associado à consulta do paciente, apenas para pacientes do sexo masculino, ordenação é feita pelo nome do paciente.
SELECT p.nome, p.dt_nascimento, p.sexo, m.nome AS nome_medico
FROM paciente p
LEFT JOIN consulta c ON p.consulta_id = c.id
LEFT JOIN medico m ON c.medico_id = m.id
WHERE p.sexo = 'Male'
ORDER BY p.nome;

-- Consulta que conta número de pacientes por plano de saúde
SELECT id_planosaude, COUNT(*) AS numero_pacientes
FROM paciente
GROUP BY id_planosaude;

-- Seleciona nome do paciente, data de nascimento, sexo e nome do médico associado à consulta do paciente (apenas pacientes femininos)
SELECT p.nome, p.dt_nascimento, p.sexo, m.nome AS nome_medico
FROM paciente p
JOIN consulta c ON p.consulta_id = c.id
JOIN medico m ON c.medico_id = m.id
WHERE p.sexo = 'Female'
ORDER BY p.nome;

-- Seleciona nome do paciente, data de nascimento, sexo e nome do médico associado à consulta do paciente (apenas pacientes masculinos)
SELECT p.nome, p.dt_nascimento, p.sexo, m.nome AS nome_medico
FROM paciente p
JOIN consulta c ON p.consulta_id = c.id
JOIN medico m ON c.medico_id = m.id
WHERE p.sexo = 'Male'
ORDER BY p.nome;

-- Calcula média do número de consultas por médico, excluindo médicos com menos de 3 consultas, resultados são ordenados pela média de consultas em ordem decrescente
SELECT m.nome, AVG(consulta_count) AS media_consultas
FROM medico m
JOIN (
    SELECT medico_id, COUNT(id) AS consulta_count
    FROM consulta
    GROUP BY medico_id
) c ON m.id = c.medico_id
GROUP BY m.nome
HAVING AVG(consulta_count) >= 3
ORDER BY media_consultas DESC;

-----------------------------------------------------------------------------------------------------------------------------------------------------------

DESC paciente;
DESC medico;
DESC consulta;
DESC prediagnostico;
DESC endereco;
DESC plano_saude;
DESC especialidade;
DESC exame_sangue;
DESC exame_mri;

SELECT * FROM paciente;
SELECT * FROM medico;
SELECT * FROM consulta;
SELECT * FROM prediagnostico;
SELECT * FROM endereco;
SELECT * FROM plano_saude;
SELECT * FROM especialidade;
SELECT * FROM exame_sangue;
SELECT * FROM exame_mri;