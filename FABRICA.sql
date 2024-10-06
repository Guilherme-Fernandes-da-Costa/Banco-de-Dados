CREATE DATABASE FABRICA;

/*Cliente do sistema*/
CREATE TABLE Cliente(
    ID_Cliente VARCHAR(9) NOT NULL,
    Nome VARCHAR(25) NOT NULL,
    Email VARCHAR(9) NOT NULL,
    Telefone VARCHAR(14) NOT NULL,
    CEP VARCHAR(8) NOT NULL,
    Logradouro VARCHAR(25),
    Numero_Endereco INT NOT NULL,
    Complemento_Endereco VARCHAR(25) NOT NULL,
    PRIMARY KEY (ID_Cliente)
);

/*Funcionário da Empresa*/
CREATE TABLE Funcionario(
    ID_Funcionario VARCHAR(9) NOT NULL,
    Nome VARCHAR(25) NOT NULL,
    Cargo VARCHAR(25) NOT NULL,
    Logradouro VARCHAR(25),
    Salario DOUBLE(8,2) NOT NULL,
    PRIMARY KEY (ID_Funcionario)
);

CREATE TABLE Funcionario_Producao (
    turno INT NOT NULL,
) INHERITS (Funcionario);

CREATE TABLE Funcionario_Comercial (
    area_de_vendas INT NOT NULL
) INHERITS (Funcionario);

/*Pedido feito pelo cliente para o Funcionario da Empresa*/
CREATE TABLE Pedido(
    ID_Pedido VARCHAR(9) NOT NULL,

    ID_Cliente VARCHAR(9) NOT NULL,
    ID_Funcionario VARCHAR(9) NOT NULL,
    ID_Funcionario_Comercial VARCHAR(9) NOT NULL,
    STATUS_Pedido INT NOT NULL,
    
    Data_Entrega_Pedido DATE NOT NULL,
    Logradouro VARCHAR(25),
    Valor_Total_Pedido DOUBLE(8,2) NOT NULL,

    PRIMARY KEY (ID_Pedido),
    FOREIGN KEY (ID_Cliente) REFERENCES Cliente(ID_Cliente) ON DELETE CASCADE ON CREATE DELETE
    FOREIGN KEY (ID_Funcionario) REFERENCES Funcionario(ID_Funcionario) ON DELETE CASCADE ON CREATE DELETE
    FOREIGN KEY (ID_Funcionario_Comercial) REFERENCES Funcionario_Comercial(ID_Funcionario_Comercial) ON DELETE CASCADE ON CREATE DELETE

);

CREATE TABLE Produto(
    ID_Produto VARCHAR(9) NOT NULL,
    -- ID_MaterialPrima VARCHAR(9) NOT NULL,
    -- ID_Insumo VARCHAR(9) NOT NULL,
    
    Custo_Unitario DOUBLE(11,2) NOT NULL,
    Nome_Produto VARCHAR(25) NOT NULL,
    Estoque_Disponivel INT NOT NULL,

    PRIMARY KEY (ID_Produto)
);

CREATE TABLE Produto_Pedido(
    ID_Produto VARCHAR(9) NOT NULL,
    ID_Pedido VARCHAR(9) NOT NULL,
    Preco_Venda DOUBLE(11,2) NOT NULL,
    Quantidade INT NOT NULL,
    Status_Produto_Pedido INT NOT NULL,

    PRIMARY KEY (ID_Produto,ID_Pedido),
    FOREIGN KEY (ID_Produto) REFERENCES Pedido(ID_Produto) ON DELETE CASCADE ON CREATE DELETE
    FOREIGN KEY (ID_Pedido) REFERENCES Pedido(ID_Pedido) ON DELETE CASCADE ON CREATE DELETE
);

CREATE TABLE Fornecedor(
    ID_Fornecedor VARCHAR(9) NOT NULL,
    Avaliacao VARCHAR(255) NOT NULL,
    Contato VARCHAR(255) NOT NULL,
    Nome VARCHAR(255) NOT NULL,
    PRIMARY KEY (ID_Fornecedor)
);

CREATE TABLE MateriaPrima(
    ID_MaterialPrima
    Custo_Unitario DOUBLE(11,2) NOT NULL,
    Nome_Produto VARCHAR(25) NOT NULL,
    Estoque_Disponivel INT NOT NULL
    PRIMARY KEY (ID_MaterialPrima)
);

CREATE TABLE Constitui(
    ID_MaterialPrima VARCHAR(9) NOT NULL,
    ID_Produto VARCHAR(9) NOT NULL,
    PRIMARY KEY (ID_Produto, ID_MaterialPrima),
    FOREIGN KEY (ID_Produto) REFERENCES Fornecedor(ID_Produto),
    FOREIGN KEY (ID_MaterialPrima) REFERENCES Fornecedor(ID_MaterialPrima)
);

CREATE TABLE Lista(
    ID_Fornecedor VARCHAR(9) NOT NULL,
    ID_MaterialPrima VARCHAR(9) NOT NULL,
    PRIMARY KEY (ID_Fornecedor,ID_MaterialPrima),
    FOREIGN KEY (ID_Fornecedor) REFERENCES Fornecedor(ID_Fornecedor),
    FOREIGN KEY (ID_MaterialPrima) REFERENCES MateriaPrima(ID_MaterialPrima)
);

CREATE TABLE Relatorio_Vendas (
    ID_Relatorio_Vendas VARCHAR(9) NOT NULL,
    Data_Vendas DATE NOT NULL,
    Status_Venda INT NOT NULL,
    ID_Funcionario_Comercial VARCHAR(9) NOT NULL,

    PRIMARY KEY (ID_Relatorio_Vendas),
    FOREIGN KEY (ID_Funcionario_Comercial) REFERENCES Funcionario_Comercial(ID_Funcionario_Comercial)
);

CREATE TABLE Ordem_de_Pagamentos (
    Valor_OrdemDePagamento DOUBLE(11,2) NOT NULL,
    Status_OrdemDePagamentos INT NOT NULL,
    Data_OrdemDePagamentos DATE NOT NULL,
    ID_OrdemDePagamentos VARCHAR(9) NOT NULL,
    ID_Pedido VARCHAR(9) NOT NULL,

    PRIMARY KEY (ID_OrdemDePagamentos),
    FOREIGN KEY (ID_Pedido) REFERENCES Pedido(ID_Pedido)
);

CREATE TABLE Ordem_de_Producao (
    Custo_Total DOUBLE(11,2) NOT NULL,
    Status_OrdemDeProducao INT NOT NULL,
    Data_Cricao DATE NOT NULL,
    Data_Conclusao DATE NOT NULL,
    Qtd_Produzida INT NOT NULL,


    ID_OrdemDeProducao VARCHAR(9) NOT NULL,
    ID_Pedido VARCHAR(9) NOT NULL,

    PRIMARY KEY (ID_OrdemDeProducao),
    FOREIGN KEY (ID_Pedido) REFERENCES Pedido(ID_Pedido)
);

CREATE TABLE Demanda (
    ID_Fornecedor VARCHAR(9) NOT NULL,
    ID_OrdemDeProducao VARCHAR(9) NOT NULL,

    PRIMARY KEY (ID_OrdemDeProducao, ID_Fornecedor),
    FOREIGN KEY (ID_OrdemDeProducao) REFERENCES Ordem_de_Producao(ID_OrdemDeProducao),
    FOREIGN KEY (ID_Fornecedor) REFERENCES Fornecedor(ID_Fornecedor)
);