api_url <- "http://127.0.0.1:8080/predict"

ui <- shiny::fluidPage(
  shiny::titlePanel("Penguins Mass Predictor"),
  shiny::sidebarLayout(
    shiny::sidebarPanel(
      shiny::sliderInput(
        inputId = "bill_length",
        label = "Bill Length (mm)",
        min = 30,
        max = 60,
        value = 45,
        step = 0.1
      ),
      shiny::selectInput(
        inputId = "sex",
        label = "Sex",
        c("Male", "Female")
      ),
      shiny::selectInput(
        inputId = "species",
        label = "Species",
        c("Adelie", "Chinstrap", "Gentoo")
      ),
      # Get model predictions
      shiny::actionButton(
        inputId = "predict",
        label = "Predict"
      )
    ),
    shiny::mainPanel()
  )
)

server <- function(input, output, session) {

}

shiny::shinyApp(ui = ui, server = server)