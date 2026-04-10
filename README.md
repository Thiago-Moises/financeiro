# 📘 Projeto Contas a Pagar – Oracle PL/SQL
__
## 📌 Descrição
Sistema de Contas a Pagar desenvolvido em Oracle PL/SQL, com suporte a:

Cadastro de contas (fornecedor, CNPJ, valor, forma de pagamento).

Cadastro de parcelas (para boletos e duplicatas).

Consolidação de pagamentos.

Relatórios de contas e parcelas.
___
## 🛠️ Requisitos
Oracle Database (XE ou superior).

Oracle SQL Developer.

Usuário/schema dedicado (ex: financeiro).

__

## 📂 Estrutura do Projeto
01_tabelas.sql → Criação das tabelas contas_pagar e parcelas.

02_package.sql → Criação do pacote contas_pkg com procedures.

03_exemplos.sql → Exemplos de uso (cadastro, parcelas, relatório).

README.md → Documentação do projeto.

__
## 📑 Tabelas
**contas_pagar**
id_conta (PK)

descricao

fornecedor

cnpj

valor_total

data_pagamento

forma_pagamento

**parcelas**
id_parcela (PK)

id_conta (FK → contas_pagar)

numero_parcela

valor_parcela

data_vencimento

pago
__

##📦 Pacote contas_pkg
Procedures
cadastrar_conta → Insere uma nova conta.

cadastrar_parcela → Insere parcelas vinculadas a uma conta.

consolidar_pagamento → Marca conta e parcelas como pagas.

relatorio_contas → Exibe relatório via DBMS_OUTPUT.

__

##🚀 Exemplo de Uso

```
BEGIN
   contas_pkg.cadastrar_conta(
      p_descricao       => 'Compra de materiais de escritório',
      p_fornecedor      => 'Fornecedor ABC',
      p_cnpj            => '12.345.678/0001-99',
      p_valor_total     => 1500,
      p_data_pagamento  => NULL,
      p_forma_pagamento => 'Boleto'
   );

   contas_pkg.cadastrar_parcela(1, 1, 500, DATE '2026-05-10');
   contas_pkg.cadastrar_parcela(1, 2, 500, DATE '2026-06-10');
   contas_pkg.cadastrar_parcela(1, 3, 500, DATE '2026-07-10');
END;
/

COMMIT;
```
___
📊 Relatório
```
BEGIN
   contas_pkg.relatorio_contas;
END;
/
```

