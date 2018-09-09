fluidPage(
  tags$link(rel = 'stylesheet', type = 'text/css', href = 'natal_data.css'),
  tags$link(rel = 'stylesheet', type = 'text/css', href = 'print.min.css'),
  tags$script(type="text/javascript", src="print.min.js"),
  tags$link(rel = 'stylesheet', href='https://use.typekit.net/qae8ttq.css'),
  
  # App title ----
  titlePanel(div(img(src = "logo-01.png", height = 75),
  "Get Your Natal Data")),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      # Input: Slider for the number of bins ----
      "ENTER YOUR INFO HERE. THEN CLICK 'GO!'",
      textInput(inputId = "username", label = "Your Name", value = "Angela"),
      dateInput(inputId = "birthdate", label = "Birth Date", value = "1983-07-10"),
      numericInput(inputId = "birthhour", label = "Birth Hour (0 to 24)", 
                   value = 4, min = 0, max = 24),
      numericInput(inputId = "birthminute", label = "Birth Minute",
                   value = 56, min = 0, max = 60),
      selectInput(inputId = "timezone", label = "Timezone (Click & Type to Search)", 
                  choices = OlsonNames(), selected = "EST"),
      textInput(inputId = "birthplace", label = "Birth City", value = "Drexel Hill, PA"),
      actionButton(inputId = "calcbutton", label = "GO!")
      
      
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      # Output: Histogram ----
      #plotOutput(outputId = "distPlot")
      
      tableOutput("nataltable")
      
    )
  )
)