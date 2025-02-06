
-- Criando o banco de dados
CREATE DATABASE OficinaMecanica;
USE OficinaMecanica;

-- Criando a tabela Cliente
CREATE TABLE Cliente (
    CodCliente INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Endereco VARCHAR(255),
    Telefone VARCHAR(20),
    Email VARCHAR(100)
);

-- Criando a tabela Veículo
CREATE TABLE Veiculo (
    Placa VARCHAR(10) PRIMARY KEY,
    Modelo VARCHAR(100) NOT NULL,
    Ano INT NOT NULL,
    CodCliente INT NOT NULL,
    FOREIGN KEY (CodCliente) REFERENCES Cliente(CodCliente) ON DELETE CASCADE
);

-- Criando a tabela Ordem de Serviço (OS)
CREATE TABLE OS (
    NumOS INT AUTO_INCREMENT PRIMARY KEY,
    DataEmissao DATE NOT NULL,
    ValorTotal DECIMAL(10,2) NOT NULL,
    Status ENUM('Aberta', 'Em Andamento', 'Concluída', 'Cancelada') NOT NULL,
    DataConclusao DATE,
    Placa VARCHAR(10) NOT NULL,
    FOREIGN KEY (Placa) REFERENCES Veiculo(Placa) ON DELETE CASCADE
);

-- Criando a tabela Serviço
CREATE TABLE Servico (
    CodServico INT AUTO_INCREMENT PRIMARY KEY,
    Descricao VARCHAR(255) NOT NULL,
    ValorMaoDeObra DECIMAL(10,2) NOT NULL
);

-- Criando a tabela de relacionamento OS_Servico (Muitos-para-Muitos)
CREATE TABLE OS_Servico (
    NumOS INT NOT NULL,
    CodServico INT NOT NULL,
    Quantidade INT NOT NULL DEFAULT 1,
    ValorPecas DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    PRIMARY KEY (NumOS, CodServico),
    FOREIGN KEY (NumOS) REFERENCES OS(NumOS) ON DELETE CASCADE,
    FOREIGN KEY (CodServico) REFERENCES Servico(CodServico) ON DELETE CASCADE
);

-- Criando a tabela Mecânico
CREATE TABLE Mecanico (
    CodMecanico INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Endereco VARCHAR(255),
    Especialidade VARCHAR(100)
);

-- Criando a tabela de relacionamento OS_Mecanico (Muitos-para-Muitos)
CREATE TABLE OS_Mecanico (
    NumOS INT NOT NULL,
    CodMecanico INT NOT NULL,
    PRIMARY KEY (NumOS, CodMecanico),
    FOREIGN KEY (NumOS) REFERENCES OS(NumOS) ON DELETE CASCADE,
    FOREIGN KEY (CodMecanico) REFERENCES Mecanico(CodMecanico) ON DELETE CASCADE
);
