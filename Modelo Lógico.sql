-- ==========================================
-- TORCEPLUS - BANCO OPERACIONAL (Transacional)
-- ==========================================

CREATE TABLE Clube (
    id SERIAL PRIMARY KEY,
    razao_social VARCHAR(255) NOT NULL,
    cnpj VARCHAR(18) UNIQUE NOT NULL,
    nome_fantasia VARCHAR(255),
    data_fundacao DATE,
    cores_oficiais VARCHAR(100),
    presidente VARCHAR(255),
    taxa_plataforma DECIMAL(5,2)
);

CREATE TABLE Conta_Bancaria_Clube (
    id SERIAL PRIMARY KEY,
    clube_id INT NOT NULL,
    banco VARCHAR(100),
    agencia VARCHAR(20),
    conta VARCHAR(20),
    chave_pix VARCHAR(255),
    status_aprovacao VARCHAR(50),
    FOREIGN KEY (clube_id) REFERENCES Clube(id)
);

CREATE TABLE Plano_Socio (
    id SERIAL PRIMARY KEY,
    clube_id INT NOT NULL,
    nome VARCHAR(100) NOT NULL,
    valor_mensal DECIMAL(10,2) NOT NULL,
    permite_dependentes BOOLEAN,
    status_ativo BOOLEAN,
    FOREIGN KEY (clube_id) REFERENCES Clube(id)
);

CREATE TABLE Beneficio (
    id SERIAL PRIMARY KEY,
    plano_id INT NOT NULL,
    descricao VARCHAR(255) NOT NULL,
    tipo_desconto VARCHAR(50),
    FOREIGN KEY (plano_id) REFERENCES Plano_Socio(id)
);

CREATE TABLE Torcedor_Titular (
    id SERIAL PRIMARY KEY,
    clube_id INT NOT NULL,
    nome VARCHAR(255) NOT NULL,
    cpf VARCHAR(14) UNIQUE NOT NULL,
    data_nascimento DATE,
    email VARCHAR(255) UNIQUE NOT NULL,
    telefone VARCHAR(20),
    hash_senha VARCHAR(255) NOT NULL,
    FOREIGN KEY (clube_id) REFERENCES Clube(id)
);

CREATE TABLE Dependente (
    id SERIAL PRIMARY KEY,
    titular_id INT NOT NULL,
    nome VARCHAR(255) NOT NULL,
    data_nascimento DATE,
    grau_parentesco VARCHAR(50),
    FOREIGN KEY (titular_id) REFERENCES Torcedor_Titular(id)
);

CREATE TABLE Assinatura (
    id SERIAL PRIMARY KEY,
    titular_id INT NOT NULL,
    plano_id INT NOT NULL,
    data_adesao DATE NOT NULL,
    status_adimplencia VARCHAR(50),
    FOREIGN KEY (titular_id) REFERENCES Torcedor_Titular(id),
    FOREIGN KEY (plano_id) REFERENCES Plano_Socio(id)
);

CREATE TABLE Fatura (
    id SERIAL PRIMARY KEY,
    assinatura_id INT NOT NULL,
    mes_referencia VARCHAR(7),
    valor_total DECIMAL(10,2) NOT NULL,
    data_vencimento DATE NOT NULL,
    status VARCHAR(50),
    FOREIGN KEY (assinatura_id) REFERENCES Assinatura(id)
);

CREATE TABLE Pagamento (
    id SERIAL PRIMARY KEY,
    fatura_id INT NOT NULL,
    data_pagamento TIMESTAMP,
    metodo_pagamento VARCHAR(50),
    token_cartao VARCHAR(255),
    FOREIGN KEY (fatura_id) REFERENCES Fatura(id)
);

CREATE TABLE Uso_Beneficio (
    id SERIAL PRIMARY KEY,
    assinatura_id INT NOT NULL,
    beneficio_id INT NOT NULL,
    data_utilizacao TIMESTAMP NOT NULL,
    FOREIGN KEY (assinatura_id) REFERENCES Assinatura(id),
    FOREIGN KEY (beneficio_id) REFERENCES Beneficio(id)
);

-- ==========================================
-- TORCEPLUS - DATA WAREHOUSE (Analítico)
-- ==========================================

CREATE TABLE Dim_Tempo (
    id SERIAL PRIMARY KEY,
    data DATE NOT NULL,
    mes INT,
    ano INT
);

CREATE TABLE Dim_Clube (
    id SERIAL PRIMARY KEY,
    nome_fantasia VARCHAR(255),
    faixa_tamanho VARCHAR(50)
);

CREATE TABLE Dim_Torcedor_Anonimizado (
    id SERIAL PRIMARY KEY,
    faixa_etaria VARCHAR(50),
    estado_civil VARCHAR(50),
    cidade_origem VARCHAR(100)
);

CREATE TABLE Dim_Plano (
    id SERIAL PRIMARY KEY,
    nome_plano VARCHAR(100)
);

CREATE TABLE Fato_Faturamento (
    id_tempo INT NOT NULL,
    id_clube INT NOT NULL,
    id_plano INT NOT NULL,
    valor_arrecadado DECIMAL(15,2),
    taxa_retida DECIMAL(15,2),
    inadimplencia DECIMAL(15,2),
    PRIMARY KEY (id_tempo, id_clube, id_plano),
    FOREIGN KEY (id_tempo) REFERENCES Dim_Tempo(id),
    FOREIGN KEY (id_clube) REFERENCES Dim_Clube(id),
    FOREIGN KEY (id_plano) REFERENCES Dim_Plano(id)
);

CREATE TABLE Fato_Engajamento (
    id_tempo INT NOT NULL,
    id_clube INT NOT NULL,
    id_beneficio INT,
    qtd_utilizacoes INT,
    PRIMARY KEY (id_tempo, id_clube, id_beneficio),
    FOREIGN KEY (id_tempo) REFERENCES Dim_Tempo(id),
    FOREIGN KEY (id_clube) REFERENCES Dim_Clube(id)
);
