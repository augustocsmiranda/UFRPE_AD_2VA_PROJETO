# Carregar o pacote tidyverse
library(tidyverse)
library(dplyr)
library(DT)
# Ler o arquivo CSV
vendas_jogos <- read_csv("vgsales.csv")
datatable(vendas_jogos)

#ARQUIVO DE TESTE, NÃO USADO


# Filtrar e imprimir as linhas onde 'Year' é NA diretamente com DT
datatable(vendas_jogos[is.na(vendas_jogos$Year), ], options = list(pageLength = 10))

# Carregar a biblioteca DT
library(DT)

# Selecionar apenas as colunas Name e Year e imprimir com DT
datatable(vendas_jogos[, c("Name", "Year")], options = list(pageLength = 10, autoWidth = TRUE))


# Exibir as primeiras linhas do dataframe
head(vendas_jogos)

###################
library(knitr)
kable(vendas_jogos, caption = "Sua Legenda Aqui")

##################



# Substitua 'sua_tabela' pelo nome real do seu dataframe
# Remover linhas com valores NA
sua_tabela_sem_na <- na.omit(sua_tabela)

# Usar datatable para mostrar a tabela sem as linhas NA
datatable(sua_tabela_sem_na, options = list(pageLength = 10))


######################3
# Carregar a biblioteca dplyr
library(dplyr)

# Filtrar linhas onde uma coluna específica (ex: 'ColunaEspecifica') tem NA
# Substitua 'ColunaEspecifica' pelo nome real da sua coluna
sua_tabela_sem_na_em_coluna_especifica <- vendas_jogos %>%
  filter(!is.na(Year))

# Usar datatable para mostrar a tabela filtrada
datatable(sua_tabela_sem_na_em_coluna_especifica, options = list(pageLength = 100))



####################################

# Carregar a biblioteca dplyr
library(dplyr)
library(DT)

# Substitua 'sua_tabela' pelo nome real do seu dataframe
# Filtrar linhas que não contêm a string "N/A" em nenhuma coluna
sua_tabela_sem_na_string <- sua_tabela %>%
  filter(!apply(., 1, function(x) any(x == "N/A")))

# Usar datatable para mostrar a tabela filtrada
datatable(sua_tabela_sem_na_string, options = list(pageLength = 10))


# Sumarizando as vendas por gênero e região
vendas_por_genero_regiao <- vendas_jogos %>%
  group_by(Genre) %>%
  summarise(
    NA_Sales = sum(NA_Sales, na.rm = TRUE),
    EU_Sales = sum(EU_Sales, na.rm = TRUE),
    JP_Sales = sum(JP_Sales, na.rm = TRUE),
    Other_Sales = sum(Other_Sales, na.rm = TRUE),
    Global_Sales = sum(Global_Sales, na.rm = TRUE)
  ) %>%
  pivot_longer(cols = -Genre, names_to = "Region", values_to = "Sales")

# Encontrando o gênero mais vendido por região
top_genero_por_regiao <- vendas_por_genero_regiao %>%
  group_by(Region) %>%
  top_n(n = 1, wt = Sales) %>%
  ungroup()

ggplot(top_genero_por_regiao, aes(x = Region, y = Sales, fill = Genre)) +
  geom_bar(stat = "identity", position = "dodge") +
  theme_minimal() +
  labs(title = " ", x = "Região", y = "Vendas Totais", fill = "Gênero") +
  scale_fill_brewer(palette = "Set3") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))