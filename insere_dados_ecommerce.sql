show databases;
use ecommerce;
show tables;

-- 1 inserindo registros na tabela Clientes --
INSERT INTO `Clientes` (`Pname`, `Minit`, `Lname`, `Address`, `phone`) VALUES ('Abraão', 'H', 'Silva', 'SP', '11988123569');
INSERT INTO `Clientes` (`Pname`, `Minit`, `Lname`, `Address`, `phone`) VALUES ('Ana', 'M', 'Fonseca', 'MG', '31985641232');
INSERT INTO `Clientes` (`Pname`, `Minit`, `Lname`, `Address`, `phone`) VALUES ('Lucas', 'S', 'Silva', 'RJ', '2125896325');

-- 2 Inserindo registros na tabela Documentos --
INSERT INTO `Documentos` (`DocType`, `DocNum`, `fk_idClient`) VALUES ('CNPJ', '00623904000173', '1');
INSERT INTO `Documentos` (`DocNum`, `fk_idClient`) VALUES ('06239040001', '2');
INSERT INTO `Documentos` (`DocNum`, `fk_idClient`) VALUES ('23904000159', '3');

-- 3 Inserindo registros na tabela cartão de crédito --
INSERT INTO `creditcards` (`Name`, `Number`, `Flag`, `ExpDate`,`fk_idClient`) VALUES ('Abraão H Silva', '1234567891023456', 'Visa', '25-10-25', '1');
INSERT INTO `creditcards` (`Name`, `Number`, `Flag`, `ExpDate`,`fk_idClient`) VALUES ('Ana M Fonseca', '1098765432101234', 'Master', '24-01-23', '2');
INSERT INTO `creditcards` (`Name`, `Number`, `Flag`, `ExpDate`,`fk_idClient`) VALUES ('Ana M Fonseca', '3579518888012398', 'Visa', '25-01-25', '2');
INSERT INTO `creditcards` (`Name`, `Number`, `Flag`, `ExpDate`,`fk_idClient`) VALUES ('Lucas S Silva', '3579518897880235', 'Visa', '25-01-05', '3');

-- 4 Inserindo registros na tabela formas de pagamentos --
INSERT INTO `formas_pagamentos` (`PayType`) VALUES ('Credito');
INSERT INTO `formas_pagamentos` (`PayType`) VALUES ('Boleto');
INSERT INTO `formas_pagamentos` (`PayType`) VALUES ('Pix');
INSERT INTO `formas_pagamentos` (`PayType`) VALUES ('Debito');

-- 5 Inserindo registros na tabela Fornecedores --
INSERT INTO `fornecedores` (`SocialName`, `CNPJ`, `Contact`) VALUES ('Terabyte', '07993973000118', '4130862957');
INSERT INTO `fornecedores` (`SocialName`, `CNPJ`, `Contact`) VALUES ('Kabum', '05570714000159', '1921138250');

-- 6 Inserindo registros na tabela Produtos -- 
INSERT INTO `produtos` (`Name`, `ClassKids`, `Category`, `Size`, `Rating`, `Price`) VALUES ('SSD', '0', 'Eletrônico', '2.5"', '5', '95');
INSERT INTO `produtos` (`Name`, `ClassKids`, `Category`, `Size`, `Rating`, `Price`) VALUES ('Monitor', '0', 'Eletrônico', '19"', '4', '2000');
INSERT INTO `produtos` (`Name`, `ClassKids`, `Category`, `Size`, `Rating`, `Price`) VALUES ('Mesa gamer', '0', 'Móveis', '50x80x80', '3', '1400');
INSERT INTO `produtos` (`Name`, `ClassKids`, `Category`, `Size`, `Rating`, `Price`) VALUES ('Nitro 5', '0', 'Eletrônico', '29x32x4', '4', '4400');

-- 7 Inserindo registros na tabela fornecedores_produtos --
INSERT INTO `fornecedores_produtos` (`fk_idSupplier`, `fk_idProduct`, `Qtd`) VALUES ('1', '1', '100');
INSERT INTO `fornecedores_produtos` (`fk_idSupplier`, `fk_idProduct`, `Qtd`) VALUES ('2', '2', '50');
INSERT INTO `fornecedores_produtos` (`fk_idSupplier`, `fk_idProduct`, `Qtd`) VALUES ('1', '3', '200');
INSERT INTO `fornecedores_produtos` (`fk_idSupplier`, `fk_idProduct`, `Qtd`) VALUES ('1', '4', '20');

-- 8 Inserindo registros na tabela de estoques --
INSERT INTO `estoques` (`Local`, `Name`, `Contact`) VALUES ('Rio de Janeiro - RJ','Pedro','21965324123');
INSERT INTO `estoques` (`Local`, `Name`, `Contact`) VALUES ('São Paulo - SP','Raul Seixas','11965324512');
INSERT INTO `estoques` (`Local`, `Name`, `Contact`) VALUES ('Salvador - BA','China','77956238574');
INSERT INTO `estoques` (`Local`, `Name`, `Contact`) VALUES ('Curitiba - PR','Macunaíma','41985749632');
INSERT INTO `estoques` (`Local`, `Name`, `Contact`) VALUES ('Uberlândia - MG','Bob Esponja','31956234578');
INSERT INTO `estoques` (`Local`, `Name`, `Contact`) VALUES ('Campinas - SP','Cristiano Araujo','19978453265');

-- 9 Inserindo registros na tabela de produtos_estoques -- 
INSERT INTO `produtos_estoques` (`fk_idProduct`, `fk_idStorage`, `Qtd`) VALUES ('1','1', '100');
INSERT INTO `produtos_estoques` (`fk_idProduct`, `fk_idStorage`, `Qtd`) VALUES ('2','2', '50');
INSERT INTO `produtos_estoques` (`fk_idProduct`, `fk_idStorage`, `Qtd`) VALUES ('3','3', '200');
INSERT INTO `produtos_estoques` (`fk_idProduct`, `fk_idStorage`, `Qtd`) VALUES ('4','4', '100');

-- 10 Inserindo registros na tabela de Terceiros/Vendedores --
INSERT INTO `vendedores` (`SocialName`, `AbstName`, `CNPJ`, `CPF`, `Local`, `Contact`) VALUES ('WAZ',NULL,'96325874136985',NULL,'Minas Gerais','31963258763');
INSERT INTO `vendedores` (`SocialName`, `AbstName`, `CNPJ`, `CPF`, `Local`, `Contact`) VALUES ('André Móveis',NULL,'53159852951753',NULL,'Minas Gerais','31985265453');
INSERT INTO `vendedores` (`SocialName`, `AbstName`, `CNPJ`, `CPF`, `Local`, `Contact`) VALUES ('Juarez',NULL,NULL,'88899966621','Acre','68952654232');
INSERT INTO `vendedores` (`SocialName`, `AbstName`, `CNPJ`, `CPF`, `Local`, `Contact`) VALUES ('Oficina dos Bits',NULL,'02593449000136',NULL,'Minas Gerais','31965412548');
INSERT INTO `vendedores` (`SocialName`, `AbstName`, `CNPJ`, `CPF`, `Local`, `Contact`) VALUES ('Beco',NULL,'35895278965411',NULL,'Minas Gerais','37963524122');

-- 11 Inserindo registros na tabela Entregas -- 
INSERT INTO `entregas` (`Cod`, `Status`, `ShipValue`) VALUES ('1122334455', 'Aguardando', '20.51');
INSERT INTO `entregas` (`Cod`, `Status`, `ShipValue`) VALUES ('78965412', 'Enviado', '45');
INSERT INTO `entregas` (`Cod`, `Status`, `ShipValue`) VALUES ('123987456', 'Em trânsito', '12');
INSERT INTO `entregas` (`Cod`, `Status`, `ShipValue`) VALUES ('852369741', 'Entregue', '18');
INSERT INTO `entregas` (`Cod`, `Status`, `ShipValue`) VALUES ('123654852', 'Entregue', '25.56');

-- 12 Inserindo registros na tabela de Pedidos --
INSERT INTO `pedidos` (`fk_idClient`, `fk_idDeliver`, `fk_idPayType`, `fk_idCreditCard`, `Status`, `Description`, `TotalValue`, `Date`, `NumberPayment`) VALUES ('2', '2', '1', '2', 'Confirmado', 'utilizou cartão Visa', '9590', '22-10-15', '98465321');
INSERT INTO `pedidos` (`fk_idClient`, `fk_idDeliver`, `fk_idPayType`, `Status`, `Description`, `TotalValue`, `Date`, `NumberPayment`) VALUES ('1', '4', '3', 'Confirmado', 'Pagou com Pix', '399', '22-10-10', '13221322');
INSERT INTO `pedidos` (`fk_idClient`, `fk_idDeliver`, `fk_idPayType`, `Status`, `Description`, `TotalValue`, `Date`, `NumberPayment`) VALUES ('3', '1', '2', 'Em Processamento', 'Aguardando o boleto ser processado', '3420', '22-10-14', '29292929');
INSERT INTO `pedidos` (`fk_idClient`, `fk_idDeliver`, `fk_idPayType`, `fk_idCreditCard`, `Status`, `Description`, `TotalValue`, `Date`, `NumberPayment`) VALUES ('1', '1', '1', '1', 'Cancelado', 'Cancelou o pedido', '1400', '22-10-14', '42424236');
INSERT INTO `pedidos` (`fk_idClient`, `fk_idDeliver`, `fk_idPayType`, `fk_idCreditCard`, `Status`, `Description`, `TotalValue`, `Date`, `NumberPayment`) VALUES ('2', '1', '1', '3', 'Confirmado', 'utilizou cartão Master', '2000', '22-10-14', '12365431');
INSERT INTO `pedidos` (`fk_idClient`, `fk_idDeliver`, `fk_idPayType`, `fk_idCreditCard`, `Status`, `Description`, `TotalValue`, `Date`, `NumberPayment`) VALUES ('1', '3', '1', '3', 'Confirmado', 'cartão', '399', '22-10-10', '1984');

-- 13 Inserindo registros na tabela pedidos_produtos --
INSERT INTO `pedidos_produtos` (`fk_idProduct`, `fk_idOrder`, `Qtd`, `Status`) VALUES ('1', '1', '2', 'Disponível');
INSERT INTO `pedidos_produtos` (`fk_idProduct`, `fk_idOrder`, `Qtd`, `Status`) VALUES ('2', '1', '4', 'Disponível');
INSERT INTO `pedidos_produtos` (`fk_idProduct`, `fk_idOrder`, `Qtd`, `Status`) VALUES ('3', '1', '1', 'Disponível');
INSERT INTO `pedidos_produtos` (`fk_idProduct`, `fk_idOrder`, `Qtd`, `Status`) VALUES ('4', '2', '1', 'Disponível');
INSERT INTO `pedidos_produtos` (`fk_idProduct`, `fk_idOrder`, `Qtd`, `Status`) VALUES ('4', '3', '1', 'Disponível');
INSERT INTO `pedidos_produtos` (`fk_idProduct`, `fk_idOrder`, `Qtd`, `Status`) VALUES ('2', '3', '1', 'Disponível');
INSERT INTO `pedidos_produtos` (`fk_idProduct`, `fk_idOrder`, `Qtd`, `Status`) VALUES ('3', '3', '1', 'Disponível');
INSERT INTO `pedidos_produtos` (`fk_idProduct`, `fk_idOrder`, `Qtd`, `Status`) VALUES ('3', '4', '1', 'Disponível');
INSERT INTO `pedidos_produtos` (`fk_idProduct`, `fk_idOrder`, `Qtd`, `Status`) VALUES ('2', '6', '1', 'Disponível');
INSERT INTO `pedidos_produtos` (`fk_idProduct`, `fk_idOrder`, `Qtd`, `Status`) VALUES ('4', '6', '1', 'Disponível');

-- 14 Inserindo registros na tabela Produtos_Terceiros;
INSERT INTO `produtos_terceiros` (`fk_idSeller`, `fk_idProduct`, `Qtd`) VALUES ('1', '2', '10');
INSERT INTO `produtos_terceiros` (`fk_idSeller`, `fk_idProduct`, `Qtd`) VALUES ('2', '3', '5');
INSERT INTO `produtos_terceiros` (`fk_idSeller`, `fk_idProduct`, `Qtd`) VALUES ('3', '4', '15');
INSERT INTO `produtos_terceiros` (`fk_idSeller`, `fk_idProduct`, `Qtd`) VALUES ('4', '1', '50');