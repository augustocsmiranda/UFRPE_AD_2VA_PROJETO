# Carregar o pacote tidyverse
library(tidyverse)

# Ler o arquivo CSV
vendas_jogos <- read_csv("vgsales.csv")

# Exibir as primeiras linhas do dataframe
head(vendas_jogos)


###################
library(knitr)
kable(vendas_jogos, caption = "Sua Legenda Aqui")

##################

# Carregar a biblioteca DT
library(DT)

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
