# Projeto de banco de dados de e-Commerce

	- Contexto: Levantamento de requisitos
	- Projeto Conceitual: Modelo Entidade Relacionamento
	- Projeto Lógico: Modelo Relacional

# Modelando E-COMMERCE:
## Produto:
	- Os produtos são vendidos por uma única plataforma online e estes podem ter vendedores distintos (terceiros)
	- Cada produto possui um fornecedor
	- Um pedido pode ser composto por mais de um produto

## Cliente:
	- O cliente pode se cadastrar no site com seu CPF ou CNPJ
	- O endereço do cliente irá determinar o valor do frete
	- Um cliente pode comprar mais de um pedido. Este tem um período de carência para devolução do produto

## Pedido:
	- Os pedidos são criados por clientes e possuem informações de compra, endereço e status da entrega
	- Um produto ou mais compõem o pedido
	- O pedido pode ser cancelado


# Entidades: 
- Cliente, Pedido, Produto, Fornecedor e estoque

# Refinamento:
	- Cliente PJ e PF - Uma conta pode ser PJ ou PF, mas não pode ter as duas informações
	- Pagamento - Pode ter cadastrado mais de uma forma de pagamento
	- Entrega - possui status e código de restreio

## Software usado para modelagem
**MySQL Workbench**
