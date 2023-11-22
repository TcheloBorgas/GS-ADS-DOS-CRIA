-- Henry Komatsu 
-- Macelo Henrique - RM98893
-- Marcel P. Soddano - RM99841
-- Nicolas E. Inohue - RM98057
-- Ricardo Brito 

DROP TABLE paciente;
DROP TABLE medico;
DROP TABLE endereco;
DROP TABLE especialidade;
DROP TABLE plano_saude;
DROP TABLE exame_sangue;
DROP TABLE exame_mri;
DROP TABLE consulta;
DROP TABLE prediagnostico;

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
    historico_medico VARCHAR2(500) CONSTRAINT historico_medico_paciente_nn NOT NULL,
    consulta_id NUMBER
);

CREATE TABLE medico (
    id NUMBER CONSTRAINT id_medico_pk PRIMARY KEY,
    nome VARCHAR2(100) CONSTRAINT nome_medico_nn NOT NULL,
    email varchar2(100) CONSTRAINT email_medico_nn_uk NOT NULL UNIQUE,
    crm VARCHAR2(8) CONSTRAINT crm_medico_nn_uk NOT NULL UNIQUE,
    telefone VARCHAR2(20) CONSTRAINT telefone_medico_nn NOT NULL,
    consulta_id NUMBER,
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
    cidade VARCHAR2(100) CONSTRAINT cidade_endereco_nn NOT NULL,
);

CREATE TABLE especialidade (
    id NUMBER CONSTRAINT id_especialidade_pk PRIMARY KEY,
    nome VARCHAR(100) CONSTRAINT nome_especialidade_nn NOT NULL
);

CREATE TABLE plano_saude (
    id NUMBER CONSTRAINT id_planosaude_pk PRIMARY KEY,
    nome VARCHAR(255) CONSTRAINT nome_planosaude_nn NOT NULL,
    descricao VARCHAR2(300) CONSTRAINT descricao_planosaude_nn NOT NULL,
);

CREATE TABLE exame_sangue (
    id NUMBER CONSTRAINT id_examesangue_pk PRIMARY KEY,
    leukocytes FLOAT(6) CONSTRAINT leukocytes_examesangue_nn NOT NULL,
    platelets FLOAT(6), CONSTRAINT platelets_examesangue_nn NOT NULL,
    mean_platelet_volume FLOAT(6) CONSTRAINT meanplatvol_examesangue_nn NOT NULL,
    eosinophils FLOAT(6) CONSTRAINT eosinophils_examesangue_nn NOT NULL,
    proteinac_reativa FLOAT(6) CONSTRAINT proteinac_examesangue_nn NOT NULL,
);

CREATE TABLE exame_mri (
    id NUMBER CONSTRAINT id_examemri_pk PRIMARY KEY,
    image_path VARCHAR2(300) CONSTRAINT imagepath_examemri_nn NOT NULL,
    tumor_type VARCHAR2(300) CONSTRAINT tumortype_examemri_nn NOT NULL,
    tumor_probability FLOAT(6) CONSTRAINT tumorprob_examemri_nn NOT NULL,
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
ADD CONSTRAINT fk_consulta_paciente FOREIGN KEY (id_paciente) REFERENCES paciente(id);

ALTER TABLE consulta
ADD CONSTRAINT fk_consulta_medico FOREIGN KEY (id_medico) REFERENCES medico(id);

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
ADD CONSTRAINT fk_examesangue_paciente
FOREIGN KEY (id_paciente) REFERENCES paciente(id);

ALTER TABLE exame_sangue
ADD CONSTRAINT fk_examesangue_consulta FOREIGN KEY (id_consulta) REFERENCES consulta(id);

ALTER TABLE exame_mri
ADD CONSTRAINT fk_examemri_paciente FOREIGN KEY (id_paciente) REFERENCES paciente(id);

ALTER TABLE exame_mri
ADD CONSTRAINT fk_examemri_consulta FOREIGN KEY (id_consulta) REFERENCES consulta(id);

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
INSERT INTO paciente (id, nome, cpf, dt_nascimento, sexo, telefone, email, historico_medico)
VALUES (101, 'John Doe', '12345678901', TO_DATE('1990-01-01', 'YYYY-MM-DD'), 'Male', '123 Main St', 101, 'City', '12345-678', 'Apto 302', 'SP', 'São Paulo', 12345678901, 'john.doe@example.com', 'Health Plan A', 'No significant history');

INSERT INTO paciente (id, nome, cpf, dt_nascimento, sexo, logradouro, numero, bairro, cep, complemento, uf, cidade, telefone, email, plano_saude, historico_medico)
VALUES (102, 'Jane Smith', '98765432101', TO_DATE('1985-05-15', 'YYYY-MM-DD'), 'Female', '456 Oak St', 202, 'Town', '54321-876', 'Casa 1', 'RJ', 'Rio de Janeiro', 98765432102, 'jane.smith@example.com', 'Health Plan B', 'Allergies to penicillin');

INSERT INTO paciente (id, nome, cpf, dt_nascimento, sexo, logradouro, numero, bairro, cep, complemento, uf, cidade, telefone, email, plano_saude, historico_medico)
VALUES (103, 'Michael Johnson', '55566677788', TO_DATE('1982-08-20', 'YYYY-MM-DD'), 'Male', '789 Pine St', 303, 'Village', '98765-432', 'Sala 105', 'MG', 'Belo Horizonte', 5551112233, 'michael.johnson@example.com', 'Health Plan C', 'Hypertension');

INSERT INTO paciente (id, nome, cpf, dt_nascimento, sexo, logradouro, numero, bairro, cep, complemento, uf, cidade, telefone, email, plano_saude, historico_medico)
VALUES (104, 'Emily Davis', '99988877766', TO_DATE('1995-04-12', 'YYYY-MM-DD'), 'Female', '987 Cedar St', 404, 'Hamlet', '45678-901', 'Andar 3', 'RS', 'Porto Alegre', 9993334455, 'emily.davis@example.com', 'Health Plan D', 'Asthma');

INSERT INTO paciente (id, nome, cpf, dt_nascimento, sexo, logradouro, numero, bairro, cep, complemento, uf, cidade, telefone, email, plano_saude, historico_medico)
VALUES (105, 'David Wilson', '11122233344', TO_DATE('1988-11-25', 'YYYY-MM-DD'), 'Male', '654 Elm St', 505, 'Borough', '65432-109', 'Bloco C', 'PR', 'Curitiba', 1112223344, 'david.wilson@example.com', 'Health Plan E', 'None');

INSERT INTO paciente (id, nome, cpf, dt_nascimento, sexo, logradouro, numero, bairro, cep, complemento, uf, cidade, telefone, email, plano_saude, historico_medico)
VALUES (106, 'Isabel Silva', '77788899900', TO_DATE('1993-07-08', 'YYYY-MM-DD'), 'Female', '321 Maple St', 606, 'District', '87654-321', 'Apto 201', 'SC', 'Florianópolis', 7778889990, 'isabel.silva@example.com', 'Health Plan F', 'None');

INSERT INTO paciente (id, nome, cpf, dt_nascimento, sexo, logradouro, numero, bairro, cep, complemento, uf, cidade, telefone, email, plano_saude, historico_medico)
VALUES (107, 'Carlos Oliveira', '33344455566', TO_DATE('1980-03-17', 'YYYY-MM-DD'), 'Male', '852 Pine St', 707, 'Vale', '34567-890', 'Casa 2', 'BA', 'Salvador', 3334445556, 'carlos.oliveira@example.com', 'Health Plan G', 'Diabetes');

INSERT INTO paciente (id, nome, cpf, dt_nascimento, sexo, logradouro, numero, bairro, cep, complemento, uf, cidade, telefone, email, plano_saude, historico_medico)
VALUES (108, 'Fernanda Santos', '12121212121', TO_DATE('1997-12-05', 'YYYY-MM-DD'), 'Female', '753 Oak St', 808, 'Suburb', '23456-789', 'Casa 3', 'PE', 'Recife', 1212121212, 'fernanda.santos@example.com', 'Health Plan H', 'Migraine');

INSERT INTO paciente (id, nome, cpf, dt_nascimento, sexo, logradouro, numero, bairro, cep, complemento, uf, cidade, telefone, email, plano_saude, historico_medico)
VALUES (109, 'Ricardo Lima', '45454545454', TO_DATE('1984-09-22', 'YYYY-MM-DD'), 'Male', '456 Cedar St', 909, 'Hill', '78901-234', 'Bloco B', 'GO', 'Goiânia', 4545454545, 'ricardo.lima@example.com', 'Health Plan I', 'High cholesterol');

INSERT INTO paciente (id, nome, cpf, dt_nascimento, sexo, logradouro, numero, bairro, cep, complemento, uf, cidade, telefone, email, plano_saude, historico_medico)
VALUES (110, 'Camila Pereira', '66677788899', TO_DATE('1992-02-14', 'YYYY-MM-DD'), 'Female', '987 Pine St', 1010, 'Haven', '56789-012', 'Apto 401', 'DF', 'Brasília', 6667778889, 'camila.pereira@example.com', 'Health Plan J', 'None');

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

INSERT INTO medico (id, nome, email, especialidade, telefone, crm, logradouro, bairro, cep, complemento, numero, uf, cidade)
VALUES (206, 'Dra. Oliveira', 'dra.oliveira@example.com', 'Gynecologist', '555-3456', 'CRM34567', 'Women Wellness Center', 'Women District', '76543-210', 'Andar 2', 25, 'SC', 'Florianópolis');

INSERT INTO medico (id, nome, email, especialidade, telefone, crm, logradouro, bairro, cep, complemento, numero, uf, cidade)
VALUES (207, 'Dr. Pereira', 'dr.pereira@example.com', 'Oncologist', '555-7890', 'CRM78901', 'Cancer Care Clinic', 'Oncology Zone', '87654-321', 'Bloco C', 36, 'BA', 'Salvador');

INSERT INTO medico (id, nome, email, especialidade, telefone, crm, logradouro, bairro, cep, complemento, numero, uf, cidade)
VALUES (208, 'Dra. Lima', 'dra.lima@example.com', 'Psychiatrist', '555-0123', 'CRM01234', 'Mind Health Institute', 'Mental Health District', '23456-789', 'Sala 301', 15, 'PE', 'Recife');

INSERT INTO medico (id, nome, email, especialidade, telefone, crm, logradouro, bairro, cep, complemento, numero, uf, cidade)
VALUES (209, 'Dr. Santos', 'dr.santos@example.com', 'Urologist', '555-3417', 'CRM32561', 'Urology Center', 'Urology Zone', '87654-321', 'Andar 2', 22, 'GO', 'Goiânia');

INSERT INTO medico (id, nome, email, especialidade, telefone, crm, logradouro, bairro, cep, complemento, numero, uf, cidade)
VALUES (210, 'Dra. Pereira', 'dra.pereira@example.com', 'Endocrinologist', '555-7836', 'CRM98911', 'Endocrinology Clinic', 'Endocrinology Zone', '87654-321', 'Bloco C', 33, 'DF', 'Brasília');

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

SELECT * FROM paciente;
SELECT * FROM medico;
SELECT * FROM consulta;
SELECT * FROM prediagnostico;