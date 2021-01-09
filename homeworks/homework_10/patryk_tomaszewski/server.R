library(DT)
library(ggplot2)
library(ggdark)
library(plotly)
library("readxl")
library(dplyr)
require(png)
require(openxlsx)
require(grid)
library(knitr)

loadFile <- function(prefix, suffix) {
  dat <- read_xlsx(paste0("./data/",prefix,"-1_achievement-results-",suffix,".xlsx"), skip = 4, .name_repair = "minimal") %>%
    select(3, 5) %>%
    na.omit() %>%
    filter(!grepl("TIMSS", Country, fixed = TRUE))
  names(dat)[names(dat) == "Average \r\nScale Score"] <- suffix
  dat
}

data <- full_join(loadFile("1","M4"), loadFile("3","M8"), "Country") %>% full_join(loadFile("2","S4"), "Country") %>% full_join(loadFile("4","S8"), "Country") %>%
  arrange(Country)

imgAreCached <- file.exists("imageStorage.txt")
imgStorage <- "{"
itemExtraData <- "{"

loadItem <- function(path, name, type, grade) {
  doc <- openxlsx::loadWorkbook(path)
  
  if(!imgAreCached) {
    imgStorage <<- paste0(imgStorage,
      "'",type,"-",grade,"-",name,"':'",
      image_uri(paste0(dirname(doc@.xData$media[1]),"/image4.png")),"'," # Workaround poniewaz doc@.xData$media nie zawsze wykrywa wszystkie pliki
    )
  }
  
  desc <- readWorkbook(doc, startRow = 2) %>% select(8) %>% na.omit() %>%  mutate(X8 = gsub("\n", "\\n", X8))
  itemExtraData <<- paste0(itemExtraData,
                          "'",type,"-",grade,"-",name,"':'",
                          desc[1,1],"\\n", desc[2,1],"\\n", desc[3,1],"',"
  )
  
  
  dat <- readWorkbook(doc, startRow = 5) %>%
    select(3, 4) %>%
    filter(!grepl("TIMSS", Country, fixed = TRUE))
  
  names(dat) <- c("Country", "Result")
  
  dat <- dat %>%
    mutate(Type = type, Grade = grade, Result = suppressWarnings(as.numeric(Result)), Item = name) %>%
    na.omit()
  dat
}

itemData <- loadItem("./data/1-10-1_benchmark-low-item-1-M4.xlsx", "Low item 1", "Math", "4")  %>%
      union(loadItem("./data/1-11-1_benchmark-intermediate-item-1-M4.xlsx", "Intermediate item 1", "Math", "4")) %>%
      union(loadItem("./data/1-11-2_benchmark-intermediate-item-2-M4.xlsx", "Intermediate item 2", "Math", "4")) %>%
      union(loadItem("./data/1-12-1_benchmark-high-item-1-M4.xlsx", "High item 1", "Math", "4")) %>%
      union(loadItem("./data/1-12-2_benchmark-high-item-2-M4.xlsx", "High item 2", "Math", "4")) %>%
      union(loadItem("./data/1-12-3_benchmark-high-item-3-M4.xlsx", "High item 3", "Math", "4")) %>%
      union(loadItem("./data/1-13-1_benchmark-advanced-item-1-M4.xlsx", "Advanced item 1", "Math", "4")) %>%
      union(loadItem("./data/1-13-2_benchmark-advanced-item-2-M4.xlsx", "Advanced item 2", "Math", "4")) %>%
      union(loadItem("./data/1-13-3_benchmark-advanced-item-3-M4.xlsx", "Advanced item 3", "Math", "4")) %>%
      union(loadItem("./data/1-13-4_benchmark-advanced-item-4-M4.xlsx", "Advanced item 4", "Math", "4")) %>%
      
      union(loadItem("./data/2-10-1_benchmark-low-item-1-S4.xlsx", "Low item 1", "Science", "4")) %>%
      union(loadItem("./data/2-11-1_benchmark-intermediate-item-1-S4.xlsx", "Intermediate item 1", "Science", "4")) %>%
      union(loadItem("./data/2-11-2_benchmark-intermediate-item-2-S4.xlsx", "Intermediate item 2", "Science", "4")) %>%
      union(loadItem("./data/2-12-1_benchmark-high-item-1-S4.xlsx", "High item 1", "Science", "4")) %>%
      union(loadItem("./data/2-12-2_benchmark-high-item-2-S4.xlsx", "High item 2", "Science", "4")) %>%
      union(loadItem("./data/2-12-3_benchmark-high-item-3-S4.xlsx", "High item 3", "Science", "4")) %>%
      union(loadItem("./data/2-13-1_benchmark-advanced-item-1-S4.xlsx", "Advanced item 1", "Science", "4")) %>%
      union(loadItem("./data/2-13-2_benchmark-advanced-item-2-S4.xlsx", "Advanced item 2", "Science", "4")) %>%
      union(loadItem("./data/2-13-3_benchmark-advanced-item-3-S4.xlsx", "Advanced item 3", "Science", "4")) %>%
      union(loadItem("./data/2-13-4_benchmark-advanced-item-4-S4.xlsx", "Advanced item 4", "Science", "4")) %>%
      
      
      union(loadItem("./data/3-11-1_benchmark-intermediate-item-1-M8.xlsx", "Intermediate item 1", "Math", "8")) %>%
      union(loadItem("./data/3-11-2_benchmark-intermediate-item-2-M8.xlsx", "Intermediate item 2", "Math", "8")) %>%
      union(loadItem("./data/3-11-3_benchmark-intermediate-item-3-M8.xlsx", "Intermediate item 3", "Math", "8")) %>%
      union(loadItem("./data/3-12-1_benchmark-high-item-1-M8.xlsx", "High item 1", "Math", "8")) %>%
      union(loadItem("./data/3-12-2_benchmark-high-item-2-M8.xlsx", "High item 2", "Math", "8")) %>%
      union(loadItem("./data/3-12-3_benchmark-high-item-3-M8.xlsx", "High item 3", "Math", "8")) %>%
      union(loadItem("./data/3-12-4_benchmark-high-item-4-M8.xlsx", "High item 4", "Math", "8")) %>%
      union(loadItem("./data/3-13-1_benchmark-advanced-item-1-M8.xlsx", "Advanced item 1", "Math", "8")) %>%
      union(loadItem("./data/3-13-2_benchmark-advanced-item-2-M8.xlsx", "Advanced item 2", "Math", "8")) %>%
      union(loadItem("./data/3-13-3_benchmark-advanced-item-3-M8.xlsx", "Advanced item 3", "Math", "8")) %>%
      union(loadItem("./data/3-13-4_benchmark-advanced-item-4-M8.xlsx", "Advanced item 4", "Math", "8")) %>%
      
      union(loadItem("./data/4-11-1_benchmark-intermediate-item-1-S8.xlsx", "Intermediate item 1", "Science", "8")) %>%
      union(loadItem("./data/4-11-2_benchmark-intermediate-item-2-S8.xlsx", "Intermediate item 2", "Science", "8")) %>%
      union(loadItem("./data/4-11-3_benchmark-intermediate-item-3-S8.xlsx", "Intermediate item 3", "Science", "8")) %>%
      union(loadItem("./data/4-12-1_benchmark-high-item-1-S8.xlsx", "High item 1", "Science", "8")) %>%
      union(loadItem("./data/4-12-2_benchmark-high-item-2-S8.xlsx", "High item 2", "Science", "8")) %>%
      union(loadItem("./data/4-12-3_benchmark-high-item-3-S8.xlsx", "High item 3", "Science", "8")) %>%
      union(loadItem("./data/4-12-4_benchmark-high-item-4-S8.xlsx", "High item 4", "Science", "8")) %>%
      union(loadItem("./data/4-13-1_benchmark-advanced-item-1-S8.xlsx", "Advanced item 1", "Science", "8")) %>%
      union(loadItem("./data/4-13-2_benchmark-advanced-item-2-S8.xlsx", "Advanced item 2", "Science", "8")) %>%
      union(loadItem("./data/4-13-3_benchmark-advanced-item-3-S8.xlsx", "Advanced item 3", "Science", "8")) %>%
      union(loadItem("./data/4-13-4_benchmark-advanced-item-4-S8.xlsx", "Advanced item 4", "Science", "8"))

itemData$Item <- factor(itemData$Item, levels = paste0(rep(c("Low", "Intermediate", "High", "Advanced"), each=5), " item ", rep(1:5, 4)))
imgStorage <- paste0(imgStorage, "}")
itemExtraData <- paste0(itemExtraData, "}")

if(imgAreCached) {
  imgStorage <- readChar("imageStorage.txt", file.info("imageStorage.txt")$size)
} else {
  fileConn<-file("imageStorage.txt")
  write(imgStorage, fileConn)
  close(fileConn)
}

function(input, output, session){
  
  colorData <- function(dat) {
    if(dim(dat)[1] > 0) {
      dat$fill <- "#787878"
      dat$fill[dat$Country == input$country_primary] <- "#b6e3ac"
      dat$fill[dat$Country == input$country_secondary] <- "#f0e0b6"
    }
    dat
  }
  
  prepareData <- function(type) {
    type <- paste0(type, substring(input$tabs, 1, 1))
    allM <- data %>%
      rename("Score" = type) %>%
      filter(!is.na(Score))
    allM$Country <- factor(allM$Country, levels = arrange(allM, allM$Score)$Country)
    colorData(allM)
  }
  
  formatPlot <- function(dat, title) {
    ggplot(dat, aes(x = Country, y = Score)) + 
      geom_bar(stat="identity", fill=dat$fill) +
      dark_theme_gray() + 
      theme(
        plot.background = element_rect(fill="transparent"),
        axis.ticks.x = element_blank(),
        axis.text.x = element_blank(),
        panel.grid.major.x = element_blank()
      ) +
      labs(title = title) +
      ylim(0, 650)
  }
  
  output$all_maths <- renderPlotly({
    p <- formatPlot(prepareData("M"), "Average math score")
    ggplotly(p)
  })
  
  output$all_science <- renderPlotly({
    science <- prepareData("S")
    output$error_primary <- renderText({ ifelse(any(science$Country == input$country_primary), "", "Missing data") })
    output$error_secondary <- renderText({ ifelse(any(science$Country == input$country_secondary), "", "Missing data") })
    p <- formatPlot(science, "Average science score")
    ggplotly(p)
  })
  
  
  
  
  formatComparison <- function(type) {
    dat <- itemData %>%
      filter((Country == input$country_primary | Country == input$country_secondary) 
           & (Grade == as.numeric(substring(input$tabs, 1, 1)))
           & (Type == type))
    dat <- colorData(dat)
    if(input$country_primary != input$country_secondary) {
      dat$Country = factor(dat$Country, levels = c(input$country_primary, input$country_secondary))
    }
    
    p <- ggplot(dat, aes(x = Item, y = Result, Country = Country)) + 
      dark_theme_gray() + 
      theme(
        plot.background = element_rect(fill="transparent"),
        axis.ticks.x = element_blank(),
        panel.grid.major.x = element_blank()
      ) +
      labs(title = paste0(type, " items comparison"), y = "Percent with full credit") +
      scale_y_continuous(breaks = 0:4*25, labels = paste0(0:4*25, "%"), limits = c(0, 100))
    
    if(dim(dat)[1] > 0) {
      p <- p + geom_bar(stat="identity", position="dodge", fill=dat$fill) +
               scale_x_discrete(breaks = paste0(rep(c("Low", "Intermediate", "High", "Advanced"), each=5), " item ", rep(1:5, 4)),
                                labels = paste0(rep(c("L", "I", "H", "A"), each=5), rep(1:5, 4)))
    }
    ggplotly(p) %>% 
      htmlwidgets::onRender(paste0("
        function(el, x) {
          imgCache = ",imgStorage,"
          imgDesc = ",itemExtraData,"
          
          if(!document.getElementById('item_image_inner')) {
            var img = document.createElement('img')
            img.id = 'item_image_inner'
            img.style.maxWidth = '100%'
            img.style.maxHeight = '670px'
            img.style.margin = 'auto'
            img.style.display = 'block'
            document.getElementById('item_image').appendChild(img)
          }
          
          el.on('plotly_hover', function(d) {
            data = d.points[0].data.text
            if(Array.isArray(data)) data = data[d.points[0].pointIndex]
            data = data.slice(0, data.indexOf('<'))
            data = data.slice(data.indexOf(':')+2)
            imgPath = '", type, "-", substring(input$tabs, 1, 1), "-'+data
            if(!data) return
            
            document.getElementById('item_image_inner').src = imgCache[imgPath]
            document.getElementById('item_name').textContent = data
            document.getElementById('item_desc').textContent = imgDesc[imgPath]
          })
        }
    "))
  }
  
  output$compare_maths   <- renderPlotly({formatComparison("Math")})
  output$compare_science <- renderPlotly({formatComparison("Science")})
  
  
  sel1 <- sample(data$Country, 1)
  sel2 <- sample(data$Country[data$Country != sel1], 1)
  updateSelectInput(session, "country_primary", choices = data$Country, selected = sel1)
  updateSelectInput(session, "country_secondary", choices = data$Country, selected = sel2)
  
}