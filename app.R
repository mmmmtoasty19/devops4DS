
# ====== Globals ======

api_url <- "http://127.0.0.1:8080/predict"

# ====== UI ======

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
    shiny::mainPanel(
      shiny::h2("Penguin Parameters"),
      shiny::verbatimTextOutput("vals"),
      shiny::h2("Predicted Penguin Mass (g)"),
      shiny::textOutput("pred")
    )
  )
)

# ====== Server ====== 

server <- function(input, output, session) {
  vals <- shiny::reactive({
    list(
      bill_length_mm = input$bill_length,
      species_Chinstrap = input$species == "Chinstrap",
      species_Gentoo = input$species == "Gentoo",
      sex_male = input$sex == "Male"
    )
  })

  # Fetch prediction from API
  pred <- shiny::eventReactive(
    input$predict,
    httr2::request(api_url) |>
      httr2::req_body_json(list(vals())) |>
      httr2::req_perform() |>
      httr2::resp_body_json(),
    ignoreInit = TRUE
  )

  # Render to UI
  output$pred <- shiny::renderText(pred()$predict[[1]])
  output$vals <- shiny::renderPrint(vals())
}

shiny::shinyApp(ui = ui, server = server)