#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
library(shiny)

library(keras)

setwd("/Users/new/Documents/github_projects/RShiny_CNN_deploy/Image_Classification_CAMH")
# Load the model
model <- load_model_tf("cnn-mnist/")


# Define the UI
ui <- fluidPage(
  # App title ----
  titlePanel("Hello TensorFlow!"),
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    # Sidebar panel for inputs ----
    sidebarPanel(
      # Input: File upload
      fileInput("image_path", label = "Input a JPEG image")
    ),
    # Main panel for displaying outputs ----
    mainPanel(
      # Output: Histogram ----
      textOutput(outputId = "prediction"),
      plotOutput(outputId = "image")
    )
  )
)

# Define server logic required to draw a histogram ----
server <- function(input, output) {
  
  image <- reactive({
    req(input$image_path)
    jpeg::readJPEG(input$image_path$datapath)
  })
  
  
  output$prediction <- renderText({
    
    img <- image() %>% 
      array_reshape(., dim = c(1, dim(.), 1))
    #predict classes is depreciated https://stackoverflow.com/questions/72486353/r-keras-beginner-question-predict-classes
    #predict_classes(model, img) does not work.
    paste0("The predicted class number is ", apply(predict(model, img), 1, which.max) -1)
  })
  
  output$image <- renderPlot({
    plot(as.raster(image()))
  })
  
}

shinyApp(ui, server)