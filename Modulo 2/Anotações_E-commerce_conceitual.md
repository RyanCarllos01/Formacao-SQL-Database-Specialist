## 09/03/2026 Relizei o upload do png de um projeto conceitual de E-commerce, foi realizado um desafio de refinamento do projeto base, foi me descrito 3 informações
<img width="1063" height="401" alt="image" src="https://github.com/user-attachments/assets/59228fae-5303-48f4-ba39-d1c16b75397d" />
eu teria que decidir como montar, se criaria um atributo de cliente ou uma entidade, e as alterações que realizei foram:
criei 4 entidade, cliente(pessoa física), cliente(CNPJ), pois como são clientes diferentes, e o mesmo cliente não pode preencher que é cliente físico e CNPJ, decidi criar duas classes distintas
criei uma entidade pra pagamento: pois há diversos métodos de pagamentos e eles serão persistidos no banco de dados no caso de efetuar um compra futura pelo mesmo método de pagamento
e outra para entrega, pois há entregas para diversos endereços, e passamos o código de rastreio para cada cliente

