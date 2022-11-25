-- -----------------------------------------------------
-- Schema ecommerce
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ecommerce` DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
USE `ecommerce`;

-- -----------------------------------------------------
-- Table `ecommerce`.`Clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`Clientes` (
  `idClient` INT NOT NULL AUTO_INCREMENT COMMENT 'id do cliente - único e incrementa de 1 em 1, primary key',
  `Pname` VARCHAR(10) NOT NULL COMMENT 'primeiro nome do cliente',
  `Minit` CHAR(4) NULL COMMENT 'iniciais do nome do meio - máximo 4 iniciais',
  `Lname` VARCHAR(20) NOT NULL COMMENT 'sobrenome do cliente',
  `Address` VARCHAR(100) NOT NULL COMMENT 'endereço do cliente',
  `phone` VARCHAR(15) NOT NULL COMMENT 'telefone do cliente',
  PRIMARY KEY (`idClient`));

-- -----------------------------------------------------
-- Table `ecommerce`.`Entregas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`Entregas` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT 'id de entrega, pk',
  `Cod` INT NOT NULL COMMENT 'códido do rastreio',
  `Status` ENUM('Aguardando', 'Em preparação', 'Enviado', 'Em trânsito', 'Saiu para entrega', 'Entregue') NOT NULL DEFAULT 'Aguardando' COMMENT 'Status da entrega.',
  `ShipValue` FLOAT NOT NULL DEFAULT 0 COMMENT 'valor do frete, por padrão 0.00, ponto flutuante e não nulo',
  PRIMARY KEY (`id`));
  
-- -----------------------------------------------------
-- Table `ecommerce`.`CreditCards`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`CreditCards` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT 'id do cartão, pk',
  `Name` VARCHAR(45) NOT NULL COMMENT 'nome do Titular do cartão',
  `Number` VARCHAR(16) NOT NULL COMMENT 'número do cartão, preencher sem os espaços; o cartão possui 16 números(4 blocos de 4 num) ',
  `Flag` VARCHAR(16) NOT NULL COMMENT 'bandeira do cartão',
  `ExpDate` DATE NOT NULL COMMENT 'data de validade',
  `fk_idClient` INT NOT NULL COMMENT 'chave estrangeira do id do cliente.',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `Number_UNIQUE` (`Number` ASC) VISIBLE,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_Pagamentos_Clientes1_idx` (`fk_idClient` ASC) VISIBLE,
  CONSTRAINT `fk_Pagamentos_Clientes1_idx`
    FOREIGN KEY (`fk_idClient`)
    REFERENCES `ecommerce`.`Clientes` (`idClient`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- -----------------------------------------------------
-- Table `ecommerce`.`Formas_Pagamentos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`Formas_Pagamentos` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT 'Id da forma de pagamento, chave primária auto incremento.',
  `PayType` VARCHAR(45) NOT NULL DEFAULT 'Pix' COMMENT 'tipo de Pagamento, o padrão é Pix.',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `PayType_UNIQUE` (`PayType` ASC) VISIBLE,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE);

-- -----------------------------------------------------
-- Table `ecommerce`.`Pedidos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`Pedidos` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT 'id do produto, pk',
  `fk_idClient` INT NOT NULL COMMENT 'chave estrangeira da tabela cliente (idClient).',
  `fk_idDeliver` INT NOT NULL COMMENT 'chave estrangeira da tabela de entrega.',
  `fk_idPayType` INT NOT NULL COMMENT 'chave estrangeira da tabela de tipo de pagamento.',
  `fk_idCreditCard` INT NULL COMMENT 'chave estrangeira do cartão de crédito.',
  `Status` ENUM('Cancelado', 'Confirmado', 'Em processamento') NOT NULL DEFAULT 'Em Processamento' COMMENT 'Status do pedido.',
  `Description` VARCHAR(255) NULL COMMENT 'descrição do produto, pode ficar em branco',
  `TotalValue` FLOAT NOT NULL COMMENT 'valor total do pedido; tipo float',
  `Date` DATE NOT NULL COMMENT 'data do pedido, tipo datetime()',
  `NumberPayment` VARCHAR(45) NOT NULL COMMENT 'registro da forma de pagamento.',
  PRIMARY KEY (`id`, `fk_idClient`, `fk_idDeliver`),
  INDEX `fk_Pedido_Cliente1_idx` (`fk_idClient` ASC) VISIBLE,
  INDEX `fk_Pedidos_Entregas1_idx` (`fk_idDeliver` ASC) VISIBLE,
  INDEX `fk_Pedidos_CreditCards1_idx` (`fk_idCreditCard` ASC) VISIBLE,
  INDEX `fk_Pedidos_Formas_Pagamentos1_idx` (`fk_idPayType` ASC) VISIBLE,
  CONSTRAINT `fk_Pedido_Cliente1`
    FOREIGN KEY (`fk_idClient`)
    REFERENCES `ecommerce`.`Clientes` (`idClient`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pedidos_Entregas1`
    FOREIGN KEY (`fk_idDeliver`)
    REFERENCES `ecommerce`.`Entregas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pedidos_CreditCards1`
    FOREIGN KEY (`fk_idCreditCard`)
    REFERENCES `ecommerce`.`CreditCards` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pedidos_Formas_Pagamentos1`
    FOREIGN KEY (`fk_idPayType`)
    REFERENCES `ecommerce`.`Formas_Pagamentos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- -----------------------------------------------------
-- Table `ecommerce`.`Produtos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`Produtos` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT 'pk',
  `Name` VARCHAR(20) NOT NULL COMMENT 'Nome do produto, obrigatório',
  `ClassKids` TINYINT NOT NULL DEFAULT 0 COMMENT 'Produto criança ou adulto, padrão é adulto',
  `Category` ENUM('Eletrônico', 'Vestimenta', 'Brinquedos', 'Alimentos', 'Móveis') NOT NULL COMMENT 'Categoria do produto, não pode ser nulo.',
  `Size` VARCHAR(10) NULL COMMENT 'tamanho do produto,não é obrigatório',
  `Rating` FLOAT NULL DEFAULT 0 COMMENT 'avaliações dos clientes, padrão é zero',
  `Price` FLOAT NOT NULL COMMENT 'Preço do produto.',
  PRIMARY KEY (`id`));

-- -----------------------------------------------------
-- Table `ecommerce`.`Fornecedores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`Fornecedores` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT 'id do Fornecedor, pk',
  `SocialName` VARCHAR(255) NOT NULL COMMENT 'Razão Social; não pode ser nulo.',
  `CNPJ` CHAR(14) NOT NULL COMMENT 'CNPJ da empresa; tipo char(14) não pode ser nulo e dever ser único.',
  `Contact` CHAR(11) NOT NULL COMMENT 'telefone; não pode ser nulo.',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `CNPJ_UNIQUE` (`CNPJ` ASC) VISIBLE,
  UNIQUE INDEX `idFornecedor_UNIQUE` (`id` ASC) VISIBLE);

-- -----------------------------------------------------
-- Table `ecommerce`.`Fornecedores_Produtos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`Fornecedores_Produtos` (
  `fk_idSupplier` INT NOT NULL COMMENT 'chave estrangeira da tabela de fornecedores.',
  `fk_idProduct` INT NOT NULL COMMENT 'chave estrangeira da tabela de produtos.',
  `Qtd` INT NOT NULL COMMENT 'quantidade adquirida do fornecedor ',
  PRIMARY KEY (`fk_idSupplier`, `fk_idProduct`),
  INDEX `fk_Fornecedor_has_Produto_Produto1_idx` (`fk_idProduct` ASC) VISIBLE,
  INDEX `fk_Fornecedor_has_Produto_Fornecedor1_idx` (`fk_idSupplier` ASC) VISIBLE,
  CONSTRAINT `fk_Fornecedor_has_Produto_Fornecedor1`
    FOREIGN KEY (`fk_idSupplier`)
    REFERENCES `ecommerce`.`Fornecedores` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Fornecedor_has_Produto_Produto1`
    FOREIGN KEY (`fk_idProduct`)
    REFERENCES `ecommerce`.`Produtos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- -----------------------------------------------------
-- Table `ecommerce`.`Estoques`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`Estoques` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT 'id do estoque, tipo auto incremento, pk',
  `Local` VARCHAR(255) NOT NULL COMMENT 'endereço',
  `Name` VARCHAR(50) NULL DEFAULT 0 COMMENT 'nome do responsável',
  `Contact` CHAR(11) NULL COMMENT 'telefone de contato.',
  PRIMARY KEY (`id`));

-- -----------------------------------------------------
-- Table `ecommerce`.`Produtos_Estoques`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`Produtos_Estoques` (
  `fk_idProduct` INT NOT NULL COMMENT 'chave estrangeira da tabela de produtos.',
  `fk_idStorage` INT NOT NULL COMMENT 'chave estrangeira da tabela de estoque.',
  `Qtd` INT NOT NULL COMMENT 'quantidade em estoque.',
  PRIMARY KEY (`fk_idProduct`, `fk_idStorage`),
  INDEX `fk_Produto_has_Estoque_Estoque1_idx` (`fk_idStorage` ASC) VISIBLE,
  INDEX `fk_Produto_has_Estoque_Produto1_idx` (`fk_idProduct` ASC) VISIBLE,
  CONSTRAINT `fk_Produto_has_Estoque_Produto1`
    FOREIGN KEY (`fk_idProduct`)
    REFERENCES `ecommerce`.`Produtos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Produto_has_Estoque_Estoque1`
    FOREIGN KEY (`fk_idStorage`)
    REFERENCES `ecommerce`.`Estoques` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- -----------------------------------------------------
-- Table `ecommerce.`Pedidos_Produtos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`Pedidos_Produtos` (
  `fk_idProduct` INT NOT NULL COMMENT 'chave estrangeira da tabela de produtos.',
  `fk_idOrder` INT NOT NULL COMMENT 'chave estrangeira da tabela de pedidos.',
  `Qtd` INT NULL DEFAULT 1 COMMENT 'quantidade solicitada na ordem, padrão 1.',
  `Status` ENUM('Disponível', 'Sem estoque') NOT NULL DEFAULT 'Disponível' COMMENT 'Status se produto está disponível ou não.',
  PRIMARY KEY (`fk_idProduct`, `fk_idOrder`),
  INDEX `fk_Produto_has_Pedido_Pedido1_idx` (`fk_idOrder` ASC) VISIBLE,
  INDEX `fk_Produto_has_Pedido_Produto1_idx` (`fk_idProduct` ASC) VISIBLE,
  CONSTRAINT `fk_Produto_has_Pedido_Produto1`
    FOREIGN KEY (`fk_idProduct`)
    REFERENCES `ecommerce`.`Produtos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Produto_has_Pedido_Pedido1`
    FOREIGN KEY (`fk_idOrder`)
    REFERENCES `ecommerce`.`Pedidos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- -----------------------------------------------------
-- Table `ecommerce`.`Vendedores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`Vendedores` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT 'id do venderor; pk',
  `SocialName` VARCHAR(255) NOT NULL COMMENT 'Razão Social do vendedor, tipo não nulo.',
  `AbstName` VARCHAR(255) NULL COMMENT 'Nome Fantasia',
  `CNPJ` CHAR(14) NULL COMMENT 'CNPJ tipo unico, não obrigatório,pode ser um vendedor pf.',
  `CPF` CHAR(11) NULL COMMENT 'CPF - tipo unico.',
  `Local` VARCHAR(255) NOT NULL COMMENT 'Endereço; não pode ser nulo.',
  `Contact` CHAR(11) NOT NULL COMMENT 'telefonde de contato; não pode ser nulo.',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `CNPJ_UNIQUE` (`CNPJ` ASC) VISIBLE,
  UNIQUE INDEX `CPF_UNIQUE` (`CPF` ASC) VISIBLE);

-- -----------------------------------------------------
-- Table `ecommerce`.`Produtos_Terceiros`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`Produtos_Terceiros` (
  `fk_idSeller` INT NOT NULL COMMENT 'chave estrangeira da tabela vendedores.',
  `fk_idProduct` INT NOT NULL COMMENT 'chave estrangeira da tabela produtos.',
  `Qtd` INT NULL DEFAULT 1 COMMENT 'quatidade vendida por terceiros.',
  PRIMARY KEY (`fk_idSeller`, `fk_idProduct`),
  INDEX `fk_Terceiros - Vendedor_has_Relação de Produto/Pedido_Rel_idx` (`fk_idProduct` ASC) VISIBLE,
  INDEX `fk_Terceiros - Vendedor_has_Relação de Produto/Pedido_Ter_idx` (`fk_idSeller` ASC) VISIBLE,
  CONSTRAINT `fk_Terceiros - Vendedor_has_Relação de Produto/Pedido_Terce1`
    FOREIGN KEY (`fk_idSeller`)
    REFERENCES `ecommerce`.`Vendedores` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Terceiros - Vendedor_has_Relação de Produto/Pedido_Rela1`
    FOREIGN KEY (`fk_idProduct`)
    REFERENCES `ecommerce`.`Pedidos_Produtos` (`fk_idProduct`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- -----------------------------------------------------
-- Table `ecommerce_refinado`.`Documentos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`Documentos` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT 'id do tipo de documento do cliente.',
  `DocType` ENUM('CPF', 'CNPJ') NOT NULL DEFAULT 'CPF' COMMENT 'Tipo do documento, pode ser \'CPF\' ou \'CNPJ\'.',
  `DocNum` VARCHAR(14) NOT NULL COMMENT 'O número do documento pode ser CPF ou CNPJ tipo varchar(14) tipo unico.',
  `fk_idClient` INT NOT NULL COMMENT 'chave estrangeira da tabela cliente.',
  PRIMARY KEY (`id`, `fk_idClient`),
  INDEX `fk_Documentos_Cliente1_idx` (`fk_idClient` ASC) VISIBLE,
  UNIQUE INDEX `DocNum_UNIQUE` (`DocNum` ASC) VISIBLE,
  CONSTRAINT `fk_Documentos_Cliente1`
    FOREIGN KEY (`fk_idClient`)
    REFERENCES `ecommerce`.`Clientes` (`idClient`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
