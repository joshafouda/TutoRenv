library(shiny)
library(dplyr)
library(ggplot2)

# UI de l'application Shiny
ui <- fluidPage(
  titlePanel("Analyse de la Dataframe Iris avec dplyr et ggplot2"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("species", "Sélectionner l'espèce :", choices = unique(iris$Species), selected = "setosa"),
      actionButton("update", "Mettre à jour")
    ),
    
    mainPanel(
      tabsetPanel(
        tabPanel("Résumé des Données", tableOutput("summaryTable")),
        tabPanel("Graphique des Sépales", plotOutput("sepalPlot"))
      )
    )
  )
)

# Serveur de l'application Shiny
server <- function(input, output, session) {
  
  # Filtrer les données en fonction de l'espèce sélectionnée
  filteredData <- eventReactive(input$update, {
    iris %>% filter(Species == input$species)
  })
  
  # Créer un résumé des données
  output$summaryTable <- renderTable({
    filteredData() %>%
      summarise(
        Sepal.Length.Mean = mean(Sepal.Length),
        Sepal.Width.Mean = mean(Sepal.Width),
        Petal.Length.Mean = mean(Petal.Length),
        Petal.Width.Mean = mean(Petal.Width)
      )
  })
  
  # Créer un graphique des sépales
  output$sepalPlot <- renderPlot({
    ggplot(filteredData(), aes(x = Sepal.Length, y = Sepal.Width, color = Species)) +
      geom_point() +
      labs(
        title = paste("Relation entre la longueur et la largeur des sépales pour l'espèce", input$species),
        x = "Longueur des sépales",
        y = "Largeur des sépales"
      ) +
      theme_minimal()
  })
}

# Lancer l'application Shiny
shinyApp(ui = ui, server = server)
