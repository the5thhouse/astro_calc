fluidPage(
  
  # App title ----
  titlePanel("Get Your Natal Data"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      # Input: Slider for the number of bins ----
      textInput(inputId = "username", label = "Your Name"),
      dateInput(inputId = "birthdate", label = "Birth Date"),
      selectInput(inputId = "timezone", label = "Timezone (Click & Type to Search)", choices = OlsonNames())
      
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      # Output: Histogram ----
      #plotOutput(outputId = "distPlot")
      
    )
  )
)