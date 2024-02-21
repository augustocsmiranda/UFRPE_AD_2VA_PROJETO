library(shiny)
library(ggplot2)
library(dplyr)
library(tidyr)

# Certifique-se de que 'vendas_jogos' está carregado e disponível aqui
# Por exemplo: vendas_jogos <- read.csv("vgsales.csv")
# Certifique-se de que a coluna 'Year' é numérica e não contém NAs
vendas_jogos$Year <- as.numeric(vendas_jogos$Year)

# Definindo a UI
ui <- fluidPage(
  titlePanel("Análise de Correlação e Regressão"),
  sidebarLayout(
    sidebarPanel(
      selectInput("varX", "Escolha a variável X:", choices = names(vendas_jogos)),
      selectInput("varY", "Escolha a variável Y:", choices = names(vendas_jogos)),
      sliderInput("intervaloAnos", "Selecione o Intervalo de Anos:",
                  min = min(vendas_jogos$Year, na.rm = TRUE), 
                  max = max(vendas_jogos$Year, na.rm = TRUE), 
                  value = c(min(vendas_jogos$Year, na.rm = TRUE), max(vendas_jogos$Year, na.rm = TRUE)))
    ),
    mainPanel(
      plotOutput("plot_correlacao")
    )
  )
)

# Definindo a lógica do servidor
server <- function(input, output) {
  output$plot_correlacao <- renderPlot({
    vendas_filtradas <- vendas_jogos %>%
      filter(Year >= input$intervaloAnos[1], Year <= input$intervaloAnos[2]) %>%
      filter(!is.na(Year)) %>%
      # Certifique-se de que as variáveis selecionadas não contenham NAs
      filter(!is.na(.[[input$varX]]), !is.na(.[[input$varY]]))
    
    ggplot(vendas_filtradas, aes_string(x = input$varX, y = input$varY)) +
      geom_point() +
      geom_smooth(method = "lm", color = "blue") +
      labs(title = paste("Correlação e Regressão entre", input$varX, "e", input$varY),
           x = input$varX, y = input$varY)
  })
}

# Chamando o aplicativo Shiny
shinyApp(ui = ui, server = server)
