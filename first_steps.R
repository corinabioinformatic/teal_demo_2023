

##################### first steps ################################
#
# https://github.com/insightsengineering/teal
#
install.packages("teal", repos = c("https://insightsengineering.r-universe.dev", getOption("repos")))
# install.packages("pak")
pak::pak("insightsengineering/teal@*release")


library(teal)

app <- init(
  data = teal_data(
    dataset("iris", iris)
  ),
  modules = list(
    module(
      "iris histogram",
      server = function(input, output, session, data) {
        output$hist <- renderPlot(
          hist(data[["iris"]]()[[input$var]])
        )
      },
      ui = function(id, data, ...) {
        ns <- NS(id)
        list(
          shiny::selectInput(
            ns("var"),
            "Column name",
            names(data[["iris"]]())[1:4]
          ),
          plotOutput(ns("hist"))
        )
      }
    )
  )
)

shinyApp(app$ui, app$server)

#####################################################################
