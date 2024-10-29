-- CREATE DATABASE FABRICA;
-- Tabela Cliente
CREATE TABLE Cliente (
    ID_Cliente INT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Telefone VARCHAR(15) NOT NULL,
    Email VARCHAR(50) NOT NULL,
    Numero INT NOT NULL,
    CEP VARCHAR(10) NOT NULL,
    Complemento VARCHAR(100),
    Logradouro VARCHAR(100)
);

-- Tabela Pedido
CREATE TABLE Pedido (
    ID_Pedido INT PRIMARY KEY,
    Data_Pedido DATE NOT NULL,
    Data_Entrega DATE,
    Status VARCHAR(20) NOT NULL,
    ID_Cliente INT,
    FOREIGN KEY (ID_Cliente) REFERENCES Cliente(ID_Cliente) ON DELETE CASCADE
);

-- Tabela Produto
CREATE TABLE Produto (
    ID_Produto INT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Descricao TEXT,
    Estoque_Disponivel INT NOT NULL,
    Custo_Unitario DECIMAL(10, 2) NOT NULL
);

-- Tabela Contém (relacionamento entre Pedido e Produto)
CREATE TABLE Contem (
    ID_Pedido INT,
    ID_Produto INT,
    Quantidade INT NOT NULL,
    PRIMARY KEY (ID_Pedido, ID_Produto),
    FOREIGN KEY (ID_Pedido) REFERENCES Pedido(ID_Pedido) ON DELETE CASCADE,
    FOREIGN KEY (ID_Produto) REFERENCES Produto(ID_Produto) ON DELETE CASCADE
);

-- Tabela Ordem de Produção
CREATE TABLE OrdemProducao (
    ID_Ordem INT PRIMARY KEY,
    Quantidade_Produzida INT NOT NULL,
    Status VARCHAR(20) NOT NULL,
    Custo_Total DECIMAL(10, 2),
    Data_Criacao DATE NOT NULL,
    Data_Conclusao DATE
);

-- Tabela Contém (relacionamento entre Produto e Ordem de Produção)
CREATE TABLE ContemOrdemProducao (
    ID_Produto INT,
    ID_Ordem INT,
    Quantidade INT NOT NULL,
    PRIMARY KEY (ID_Produto, ID_Ordem),
    FOREIGN KEY (ID_Produto) REFERENCES Produto(ID_Produto) ON DELETE CASCADE,
    FOREIGN KEY (ID_Ordem) REFERENCES OrdemProducao(ID_Ordem) ON DELETE CASCADE
);

-- Tabela Matéria-Prima
CREATE TABLE MateriaPrima (
    ID_MateriaPrima INT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Custo_Unidade DECIMAL(10, 2) NOT NULL,
    Estoque_Disponivel INT NOT NULL
);

-- Tabela Constituido (relacionamento entre Produto e Materia-Prima)
CREATE TABLE Constituido (
    ID_Produto INT,
    ID_MateriaPrima INT,
    Quantidade INT NOT NULL,
    PRIMARY KEY (ID_Produto, ID_MateriaPrima),
    FOREIGN KEY (ID_Produto) REFERENCES Produto(ID_Produto) ON DELETE CASCADE,
    FOREIGN KEY (ID_MateriaPrima) REFERENCES MateriaPrima(ID_MateriaPrima) ON DELETE CASCADE
);

-- Tabela Fornecedor
CREATE TABLE Fornecedor (
    ID_Fornecedor INT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Avaliacao DECIMAL(3, 2),
    Telefone VARCHAR(15) NOT NULL,
    Email VARCHAR(50) NOT NULL
);

-- Tabela Fornece (relacionamento entre Fornecedor e Materia-Prima)
CREATE TABLE Fornece (
    ID_Fornecedor INT,
    ID_MateriaPrima INT,
    Preco INT NOT NULL,
    PRIMARY KEY (ID_Fornecedor, ID_MateriaPrima),
    FOREIGN KEY (ID_Fornecedor) REFERENCES Fornecedor(ID_Fornecedor) ON DELETE CASCADE,
    FOREIGN KEY (ID_MateriaPrima) REFERENCES MateriaPrima(ID_MateriaPrima) ON DELETE CASCADE
);

-- Tabela Funcionário
CREATE TABLE Funcionario (
    ID_Funcionario INT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Cargo VARCHAR(50) NOT NULL,
    Salario DECIMAL(10, 2) NOT NULL
);

-- Tabela Recebe (relacionamento entre Funcionário e Pedido)
CREATE TABLE Recebe (
    ID_Funcionario INT,
    ID_Pedido INT,
    PRIMARY KEY (ID_Funcionario, ID_Pedido),
    FOREIGN KEY (ID_Funcionario) REFERENCES Funcionario(ID_Funcionario) ON DELETE CASCADE,
    FOREIGN KEY (ID_Pedido) REFERENCES Pedido(ID_Pedido) ON DELETE CASCADE
);

-- Tabela Realiza (relacionamento entre Funcionário e Ordem de Produção)
CREATE TABLE Realiza (
    ID_Funcionario INT,
    ID_Ordem INT,
    PRIMARY KEY (ID_Funcionario, ID_Ordem),
    FOREIGN KEY (ID_Funcionario) REFERENCES Funcionario(ID_Funcionario) ON DELETE CASCADE,
    FOREIGN KEY (ID_Ordem) REFERENCES OrdemProducao(ID_Ordem) ON DELETE CASCADE
);
