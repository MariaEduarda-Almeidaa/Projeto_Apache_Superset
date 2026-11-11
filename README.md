# Projeto prático — Apache Superset | Dashboard de Vendas

Demonstração acadêmica simples: Apache Superset + PostgreSQL + dados fictícios de vendas.

## Requisitos
- Docker Desktop instalado e **aberto** (Windows/Mac) ou Docker + Compose (Linux).
- Internet na primeira execução (baixa as imagens, ~2–3 GB).
- Portas livres: **8088** (Superset) e **5433** (PostgreSQL).
- Recomendado: 4 GB de RAM livres para o Docker.

## 1. Iniciar
Abra o terminal nesta pasta e execute:
```bash
docker compose up --build -d
```
Aguarde a inicialização (a primeira vez leva alguns minutos; acompanhe com `docker compose logs -f superset` até aparecer algo como *Listening at: http://0.0.0.0:8088*) e acesse http://localhost:8088

Login: `admin` | Senha: `admin123` (somente para demonstração local).

## 2. Conectar o banco ao Superset
No Superset, abra **Settings → Database Connections** (ou **Data → Databases**) → **+ Database** → PostgreSQL.
Informe esta URI:
```text
postgresql+psycopg2://superset:superset_demo@db:5432/vendas
```
Clique em **Test Connection** e depois **Connect**. Use `db` como host: é o nome do serviço na rede Docker.

## 3. Criar o dataset
Vá em **Data → Datasets → + Dataset**. Selecione o banco conectado, schema `public` e view `resumo_vendas`. Salve.

## 4. Criar quatro gráficos
Em **Charts → + Chart**, selecione `resumo_vendas`:
- **Faturamento por mês:** gráfico de barras temporal; coluna `data_venda`; métrica `SUM(faturamento)`; granularidade mensal.
- **Faturamento por categoria:** barras ou pizza; dimensão `categoria`; métrica `SUM(faturamento)`.
- **Faturamento por região:** barras; dimensão `regiao`; métrica `SUM(faturamento)`.
- **Quantidade por produto:** barras; dimensão `produto`; métrica `SUM(quantidade)`.

Salve os gráficos. Depois abra **Dashboards → + Dashboard**, nomeie `Visão Geral de Vendas`, adicione os quatro gráficos e salve.

## 5. Demonstração SQL
No **SQL Lab → SQL Editor**, selecione o banco `vendas` e execute:
```sql
SELECT categoria, SUM(quantidade * valor_unitario) AS faturamento
FROM vendas
GROUP BY categoria
ORDER BY faturamento DESC;
```

## Roteiro da demonstração prática (≈ 6–8 min dentro de um seminário de 10–15 min)
1. Problema: uma tabela com muitas vendas é difícil de interpretar rapidamente.
2. Arquitetura: PostgreSQL armazena; Superset consulta; navegador exibe gráficos e dashboards.
3. Mostre a conexão do banco e o dataset `resumo_vendas`.
4. Execute o SQL para comparar o faturamento por categoria.
5. Abra o dashboard e explore mês, categoria, região e produto.
6. Conclusão: Superset é uma ferramenta de BI/visualização, não um banco de dados.

## Parar e reiniciar
```bash
docker compose down
docker compose up -d
```
Para apagar também os dados persistidos:
```bash
docker compose down -v
```
## Problemas comuns
| Sintoma | Solução |
|---|---|
| `port is already allocated` | Outra aplicação usa 8088 ou 5433. Feche-a ou troque a porta à esquerda em `ports:` no `docker-compose.yml`. |
| Página não abre logo após o `up` | O Superset ainda está iniciando. Espere 1–3 min e veja `docker compose logs -f superset`. |
| Banco `vendas` não existe / view `resumo_vendas` ausente | O `init.sql` só roda na 1ª criação do volume. Rode `docker compose down -v` e depois `docker compose up --build -d`. |
| `Could not load database driver: PostgresDialect_psycopg2` | O build do driver falhou. Rode `docker compose build --no-cache`. |
| Erro de conexão ao testar o banco | Use host `db` (não `localhost`) na URI. |

Dica para a apresentação: suba o ambiente e faça todo o passo a passo **antes** de apresentar; durante a defesa só mostre.

Dados fictícios. Não exponha o ambiente na internet; as credenciais e a chave são apenas para uso local. A primeira instalação pode levar alguns minutos.
