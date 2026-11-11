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
Em **Charts → + Chart**, escolha o dataset `resumo_vendas`, selecione o tipo de gráfico e clique em **Create new chart**.

### 4.1 Faturamento por mês
1. Tipo: **Bar Chart**. Na aba **Data**:
2. **X-axis:** arraste `data_venda`.
3. **Time grain:** `Month`.
4. **Metrics:** clique no campo → aba **Simple** → coluna `faturamento`, agregado `SUM` → **Save**.
5. Clique em **Update chart** (ou **Create chart**) e confira o gráfico.
6. Clique em **Save**, nomeie `Faturamento por mês` e, em **Add to dashboard**, digite `Visão Geral de Vendas` para criar o dashboard já nesse passo.

### 4.2 Os outros três gráficos
Repita o processo (**Charts → + Chart** → `resumo_vendas`), mudando apenas estes campos:

| Gráfico | Tipo | X-axis | Metrics |
|---|---|---|---|
| Faturamento por categoria | Bar Chart (ou Pie Chart*) | `categoria` | `SUM(faturamento)` |
| Faturamento por região | Bar Chart | `regiao` | `SUM(faturamento)` |
| Quantidade por produto | Bar Chart | `produto` | `SUM(quantidade)` |

Ao salvar cada gráfico, escolha o dashboard `Visão Geral de Vendas` em **Add to dashboard**.

### 4.3 Montar o dashboard
Abra **Dashboards → Visão Geral de Vendas**, clique em **Edit dashboard**, arraste/organize os quatro gráficos e clique em **Save**.

> Se a opção `Month` não aparecer em **Time grain**: em **Data → Datasets**, edite `resumo_vendas`, aba **Columns**, e marque **Is temporal** em `data_venda`.

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
