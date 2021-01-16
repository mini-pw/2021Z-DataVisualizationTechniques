library(shiny)
library(ggplot2)
library(reshape2)
library(plotly)

function(input, output, session){
    
    output$plotly_1 <- renderPlotly({
        req(input$Polska == FALSE |input$Polska == TRUE)
        if (input$Kraje == "all"){
            if(input$Klasa == "fourth"){
                if(input$Przedmiot == "mathematics"){
                    M4$Country <- factor(M4$Country, levels = rev(M4$Country))
                    if(input$Polska == FALSE){
                        p <- ggplot(M4, aes_string(x = "Score", y = "Country")) + geom_col(fill = "#0099ff")  + 
                            ylab("") + xlim(0, 630) + theme_bw()
                    }
                    else{
                        M4.kolor <- ifelse(M4$Country=="Poland","red","#0099ff")
                        M4.kolor <- rev(M4.kolor)
                        p <- ggplot(M4, aes_string(x = "Score", y = "Country", fill = "Country")) + geom_col() +
                            scale_fill_manual(values = M4.kolor) +
                            ylab("") + xlim(0, 630) + theme_bw() + theme(legend.position = "none")
                    }
                }
                else{
                    S4$Country <- factor(S4$Country, levels = rev(S4$Country))
                    if(input$Polska == FALSE){
                        p <- ggplot(S4, aes_string(x = "Score", y = "Country")) + geom_col(fill = "#0099ff")  + 
                            ylab("") + xlim(0, 630) + theme_bw()
                    }
                    else{
                        S4.kolor <- ifelse(S4$Country=="Poland","red","#0099ff")
                        S4.kolor <- rev(S4.kolor)
                        p <- ggplot(S4, aes_string(x = "Score", y = "Country", fill = "Country")) + geom_col() +
                            scale_fill_manual(values = S4.kolor) +
                            ylab("") + xlim(0, 630) + theme_bw() + theme(legend.position = "none")
                    }
                }
            }
            else{
                if(input$Przedmiot == "mathematics"){
                    M8$Country <- factor(M8$Country, levels = rev(M8$Country))
                    p <- ggplot(M8, aes_string(x = "Score", y = "Country")) + geom_col(fill = "#0099ff")  + 
                        ylab("") + xlim(0, 630) + theme_bw()}
                else{
                    S8$Country <- factor(S8$Country, levels = rev(S8$Country))
                    p <- ggplot(S8, aes_string(x = "Score", y = "Country")) + geom_col(fill = "#0099ff")  + 
                        ylab("") + xlim(0, 630) + theme_bw()
                    }
            }
        } else {
            if(input$Klasa == "fourth"){
                if(input$Przedmiot == "mathematics"){
                    M4UE$Country <- factor(M4UE$Country, levels = rev(M4UE$Country))
                    if(input$Polska == FALSE){
                        p <- ggplot(M4UE, aes_string(x = "Score", y = "Country")) + geom_col(fill = "#0099ff")  + 
                            ylab("") + xlim(0, 630) + theme_bw()
                    }
                    else{
                        M4UE.kolor <- ifelse(M4UE$Country=="Poland","red","#0099ff")
                        M4UE.kolor <- rev(M4UE.kolor)
                        p <- ggplot(M4UE, aes_string(x = "Score", y = "Country", fill = "Country")) + geom_col() +
                            scale_fill_manual(values = M4UE.kolor) +
                            ylab("") + xlim(0, 630) + theme_bw() + theme(legend.position = "none")
                    }     
                }
                else{
                    S4UE$Country <- factor(S4UE$Country, levels = rev(S4UE$Country))
                    if(input$Polska == FALSE){
                        p <- ggplot(S4UE, aes_string(x = "Score", y = "Country")) + geom_col(fill = "#0099ff")  + 
                            ylab("") + xlim(0, 630) + theme_bw()
                    }
                    else{
                        S4UE.kolor <- ifelse(S4UE$Country=="Poland","red","#0099ff")
                        S4UE.kolor <- rev(S4UE.kolor)
                        p <- ggplot(S4UE, aes_string(x = "Score", y = "Country", fill = "Country")) + geom_col() +
                            scale_fill_manual(values = S4UE.kolor) +
                            ylab("") + xlim(0, 630) + theme_bw() + theme(legend.position = "none")
                    }     
                }
            }
            else{
                if(input$Przedmiot == "mathematics"){
                    M8UE$Country <- factor(M8UE$Country, levels = rev(M8UE$Country))
                    p <- ggplot(M8UE, aes_string(x = "Score", y = "Country")) + geom_col(fill = "#0099ff")  + 
                        ylab("") + xlim(0, 630) + theme_bw()}
                else{
                    S8UE$Country <- factor(S8UE$Country, levels = rev(S8UE$Country))
                    p <- ggplot(S8UE, aes_string(x = "Score", y = "Country")) + geom_col(fill = "#0099ff")  + 
                        ylab("") + xlim(0, 630) + theme_bw()
                }
            }
            
        }
        
        ggplotly(p)
    })
    
    output$plotly_3 <- renderPlotly({
        
        if (input$Rok3 == "2019"){
            if(input$Klasa3 == "fourth"){
                if(input$Przedmiot3 == "mathematics"){
                    M42019$Country <- factor(M42019$Country, levels = M42019$Country)
                    p <- ggplot(M42019, aes_string(x = "Country", y = "Score")) + geom_col(fill = "#0099ff") +
                        xlab("") + ylim(0, 630) + theme_bw() + theme(axis.text.x = element_text(angle = 45))
                }
                else{
                    S42019$Country <- factor(S42019$Country, levels = S42019$Country)
                    p <- ggplot(S42019, aes_string(x = "Country", y = "Score")) + geom_col(fill = "#0099ff") +
                        xlab("") + ylim(0, 630) + theme_bw() + theme(axis.text.x = element_text(angle = 45))
                }
            }
            else{
                if(input$Przedmiot3 == "mathematics"){
                    M82019$Country <- factor(M82019$Country, levels = M82019$Country)
                    p <- ggplot(M82019, aes_string(x = "Country", y = "Score")) + geom_col(fill = "#0099ff") +
                        xlab("") + ylim(0, 630) + theme_bw() + theme(axis.text.x = element_text(angle = 45))
                }
                else{
                    S82019$Country <- factor(S82019$Country, levels = S82019$Country)
                    p <- ggplot(S82019, aes_string(x = "Country", y = "Score")) + geom_col(fill = "#0099ff") + 
                        xlab("") + ylim(0, 630) + theme_bw() + theme(axis.text.x = element_text(angle = 45))
                }
            }
        } else if (input$Rok3 == "2015"){
            if(input$Klasa3 == "fourth"){
                if(input$Przedmiot3 == "mathematics"){
                    M42015$Country <- factor(M42015$Country, levels = M42015$Country)
                    p <- ggplot(M42015, aes_string(x = "Country", y = "Score")) + geom_col(fill = "#0099ff") + 
                        xlab("") + ylim(0, 630) + theme_bw() + theme(axis.text.x = element_text(angle = 45))
                }
                else{
                    S42015$Country <- factor(S42015$Country, levels = S42015$Country)
                    p <- ggplot(S42015, aes_string(x = "Country", y = "Score")) + geom_col(fill = "#0099ff") +
                        xlab("") + ylim(0, 630) + theme_bw() + theme(axis.text.x = element_text(angle = 45))
                }
            }
            else{
                if(input$Przedmiot3 == "mathematics"){
                    M82015$Country <- factor(M82015$Country, levels = M82015$Country)
                    p <- ggplot(M82015, aes_string(x = "Country", y = "Score")) + geom_col(fill = "#0099ff") + 
                        xlab("") + ylim(0, 630) + theme_bw() + theme(axis.text.x = element_text(angle = 45))
                }
                else{
                    S82015$Country <- factor(S82015$Country, levels = S82015$Country)
                    p <- ggplot(S82015, aes_string(x = "Country", y = "Score")) + geom_col(fill = "#0099ff") + 
                        xlab("") + ylim(0, 630) + theme_bw() + theme(axis.text.x = element_text(angle = 45))
                }
            }
            
        }
        else {
            if(input$Klasa3 == "fourth"){
                if(input$Przedmiot3 == "mathematics"){
                    M42011$Country <- factor(M42011$Country, levels = M42011$Country)
                    p <- ggplot(M42011, aes_string(x = "Country", y = "Score")) + geom_col(fill = "#0099ff") + 
                        xlab("") + ylim(0, 630) + theme_bw() + theme(axis.text.x = element_text(angle = 45))
                }
                else{
                    S42011$Country <- factor(S42011$Country, levels = S42011$Country)
                    p <- ggplot(S42011, aes_string(x = "Country", y = "Score")) + geom_col(fill = "#0099ff") +
                        xlab("") + ylim(0, 630) + theme_bw() + theme(axis.text.x = element_text(angle = 45))
                }
            }
            else{
                if(input$Przedmiot3 == "mathematics"){
                    M82011$Country <- factor(M82011$Country, levels = M82011$Country)
                    p <- ggplot(M82011, aes_string(x = "Country", y = "Score")) + geom_col(fill = "#0099ff") + 
                        xlab("") + ylim(0, 630) + theme_bw() + theme(axis.text.x = element_text(angle = 45))
                }
                else{
                    S82011$Country <- factor(S82011$Country, levels = S82011$Country)
                    p <- ggplot(S82011, aes_string(x = "Country", y = "Score")) + geom_col(fill = "#0099ff") + 
                        xlab("") + ylim(0, 630) + theme_bw() + theme(axis.text.x = element_text(angle = 45))
                }
            }
            
        }
        
        ggplotly(p)
    })
    
    output$plotly_22 <- renderPlotly({
        
        if(input$Klasa22 == "fourth"){
            if(input$Przedmiot22 == "mathematics"){
                M4pom <- M4plec %>% filter(Country == toString(input$Kraj22) | Country == toString(input$Kraj23))
                M4pom <- melt(M4pom, id.vars = "Country")
                if(! toString(input$Kraj22) == toString(input$Kraj23)){
                    M4pom$Country <- factor(M4pom$Country, levels = c(toString(input$Kraj22), toString(input$Kraj23)))
                }
                colnames(M4pom) <- c("Country", "Gender", "Score")
                p <- ggplot(M4pom, aes_string(x = "Country", y = "Score", fill = "Gender")) + 
                    geom_bar(stat = "identity", position = "dodge") + 
                    ylab("Score") + ylim(0, 640) + theme_bw() + labs(fill = "") + 
                    scale_fill_manual(values=c("#ff3399", "#0066ff")) + xlab("")
            }
            else{
                S4pom <- S4plec %>% filter(Country == toString(input$Kraj22) | Country == toString(input$Kraj23))
                S4pom <- melt(S4pom, id.vars = "Country")
                if(! toString(input$Kraj22) == toString(input$Kraj23)){
                    S4pom$Country <- factor(S4pom$Country, levels = c(toString(input$Kraj22), toString(input$Kraj23)))
                }
                colnames(S4pom) <- c("Country", "Gender", "Score")
                p <- ggplot(S4pom, aes_string(x = "Country", y = "Score", fill = "Gender")) + 
                    geom_bar(stat = "identity", position = "dodge") + 
                    ylab("Score") + ylim(0, 640) + theme_bw() + labs(fill = "") + 
                    scale_fill_manual(values=c("#ff3399", "#0066ff")) + xlab("")
            }
        }
        else{
            if(input$Przedmiot22 == "mathematics"){
                M8pom <- M8plec %>% filter(Country == toString(input$Kraj22) | Country == toString(input$Kraj23))
                M8pom <- melt(M8pom, id.vars = "Country")
                if(! toString(input$Kraj22) == toString(input$Kraj23)){
                    M8pom$Country <- factor(M8pom$Country, levels = c(toString(input$Kraj22), toString(input$Kraj23)))
                }
                colnames(M8pom) <- c("Country", "Gender", "Score")
                p <- ggplot(M8pom, aes_string(x = "Country", y = "Score", fill = "Gender")) + 
                    geom_bar(stat = "identity", position = "dodge") + 
                    ylab("Score") + ylim(0, 640) + theme_bw() + labs(fill = "") + 
                    scale_fill_manual(values=c("#ff3399", "#0066ff")) + xlab("")
            }
            else{
                S8pom <- S8plec %>% filter(Country == toString(input$Kraj22) | Country == toString(input$Kraj23))
                S8pom <- melt(S8pom, id.vars = "Country")
                if(! toString(input$Kraj22) == toString(input$Kraj23)){
                    S8pom$Country <- factor(S8pom$Country, levels = c(toString(input$Kraj22), toString(input$Kraj23)))
                }
                colnames(S8pom) <- c("Country", "Gender", "Score")
                p <- ggplot(S8pom, aes_string(x = "Country", y = "Score", fill = "Gender")) + 
                    geom_bar(stat = "identity", position = "dodge") + 
                    ylab("Score") + ylim(0, 640) + theme_bw() + labs(fill = "") + 
                    scale_fill_manual(values=c("#ff3399", "#0066ff")) + xlab("")
            }
        }
        
        ggplotly(p) %>%
            layout(legend = list(orientation = 'v', y = 0.5))
    })
    
    output$Kraj2 <- renderUI({
        if(input$Klasa2 == "fourth"){
          selectInput("Kraj2", "Country:", choices = (M4plec[,"Country"]), selected = "Poland")
        }
        else{
            selectInput("Kraj2", "Country:", choices = (M8plec[,"Country"]), selected = "England")
        }
    })
    
    output$Kraj22 <- renderUI({
        if(input$Klasa22 == "fourth"){
            selectInput("Kraj22", "Country to compare:", choices = (M4plec[,"Country"]), selected = "Singapore")
        }
        else{
            selectInput("Kraj22", "Country to compare:", choices = (M8plec[,"Country"]), selected = "Singapore")
        }
    })
    
    output$Kraj23 <- renderUI({
        if(input$Klasa22 == "fourth"){
            selectInput("Kraj23", "Country to compare:", choices = (M4plec[,"Country"]), selected = "Japan")
        }
        else{
            selectInput("Kraj23", "Country to compare:", choices = (M8plec[,"Country"]), selected = "Japan")
        }
    })
    
    output$Polska <- renderUI({
        if(input$Klasa == "fourth"){
            checkboxInput("Polska", 
                          label = "Show Poland",
                          value = FALSE)
        }
        
    })
    
}