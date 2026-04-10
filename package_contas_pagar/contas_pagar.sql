CREATE OR REPLACE PACKAGE BODY contas_pkg AS

   PROCEDURE cadastrar_conta (
      p_descricao       IN VARCHAR2,
      p_fornecedor      IN VARCHAR2,
      p_cnpj            IN VARCHAR2,
      p_valor_total     IN NUMBER,
      p_data_pagamento  IN DATE,
      p_forma_pagamento IN VARCHAR2
   ) AS
   BEGIN
      INSERT INTO contas_pagar (descricao, fornecedor, cnpj, valor_total, data_pagamento, forma_pagamento)
      VALUES (p_descricao, p_fornecedor, p_cnpj, p_valor_total, p_data_pagamento, p_forma_pagamento);
   END cadastrar_conta;

   PROCEDURE cadastrar_parcela (
      p_id_conta        IN NUMBER,
      p_numero_parcela  IN NUMBER,
      p_valor_parcela   IN NUMBER,
      p_data_vencimento IN DATE
   ) AS
   BEGIN
      INSERT INTO parcelas (id_conta, numero_parcela, valor_parcela, data_vencimento)
      VALUES (p_id_conta, p_numero_parcela, p_valor_parcela, p_data_vencimento);
   END cadastrar_parcela;

   PROCEDURE consolidar_pagamento (
      p_id_conta IN NUMBER
   ) AS
   BEGIN
      UPDATE contas_pagar
      SET data_pagamento = SYSDATE
      WHERE id_conta = p_id_conta;

      UPDATE parcelas
      SET pago = 'S'
      WHERE id_conta = p_id_conta;
   END consolidar_pagamento;

   PROCEDURE relatorio_contas IS
      CURSOR c_contas IS
         SELECT c.id_conta, c.descricao, c.fornecedor, c.valor_total, c.forma_pagamento,
                p.numero_parcela, p.valor_parcela, p.data_vencimento, p.pago
         FROM contas_pagar c
         LEFT JOIN parcelas p ON c.id_conta = p.id_conta
         ORDER BY c.id_conta, p.numero_parcela;
   BEGIN
      FOR r IN c_contas LOOP
         DBMS_OUTPUT.PUT_LINE('Conta: ' || r.id_conta || ' - ' || r.descricao);
         DBMS_OUTPUT.PUT_LINE('Fornecedor: ' || r.fornecedor || ' | Valor: ' || r.valor_total);
         DBMS_OUTPUT.PUT_LINE('Forma: ' || r.forma_pagamento);
         IF r.numero_parcela IS NOT NULL THEN
            DBMS_OUTPUT.PUT_LINE('   Parcela ' || r.numero_parcela || 
                                 ' | Valor: ' || r.valor_parcela || 
                                 ' | Vencimento: ' || r.data_vencimento || 
                                 ' | Pago: ' || r.pago);
         END IF;
         DBMS_OUTPUT.PUT_LINE('-----------------------------------');
      END LOOP;
   END relatorio_contas;

END contas_pkg;
/
