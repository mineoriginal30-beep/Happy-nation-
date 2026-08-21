# HappyNationBet Demo

Esta publicação é uma **demonstração sem dinheiro real** do sistema enviado pelo proprietário.

Os endpoints de pagamentos, depósitos, saques, PIX, gateways e recompensas financeiras foram desativados para esta demo. Nenhum segredo, arquivo `.env`, dump do banco ou credencial de administrador faz parte do pacote publicado.

A demo usa SQLite temporário e pode perder dados quando o serviço gratuito reiniciar ou ficar inativo. Ela não é adequada para produção, apostas, depósitos, saques ou armazenamento de dados reais.

## Publicação

O serviço é construído com Docker a partir do `Dockerfile`. O código Laravel está compactado em `happynationbet-demo-source-tiny.zip` para manter o repositório leve e excluir os ativos grandes de jogos e arquivos sensíveis.
