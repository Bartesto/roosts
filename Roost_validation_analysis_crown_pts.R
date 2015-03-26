rm(list=ls())

## Load libraries
library(dplyr)
library(tidyr)
library(ggplot2)
library(xtable)
library(grid)


# df <- read.table("UM_valid_cc_roost_NEAR_crown_pts.txt", sep = ",", header = TRUE)
df_no <- read.table("UM_valid_cc_roost_NEAR_crown_NO_pts.txt", sep = ",", header = TRUE)
df_5_3 <- read.table("UM_valid_cc_roost_NEAR_crown_pts_5_3.txt", sep = ",", header = TRUE)
df_6_3 <- read.table("UM_valid_cc_roost_NEAR_crown_pts_6_3.txt", sep = ",", header = TRUE)
df_7_3 <- read.table("UM_valid_cc_roost_NEAR_crown_pts_7_3.txt", sep = ",", header = TRUE)

# not same number of crowns now as crowns have grown into each other
df_8_3 <- read.table("UM_valid_cc_roost_NEAR_crown_pts_8_3_15cr.txt", sep = ",", header = TRUE)
df_9_3 <- read.table("UM_valid_cc_roost_NEAR_crown_pts_9_3_14cr.txt", sep = ",", header = TRUE)
df_10_3 <- read.table("UM_valid_cc_roost_NEAR_crown_pts_10_3_14cr.txt", sep = ",", header = TRUE)
df_11_3 <- read.table("UM_valid_cc_roost_NEAR_crown_pts_11_3_13cr.txt", sep = ",", header = TRUE)
df_12_3 <- read.table("UM_valid_cc_roost_NEAR_crown_pts_12_3_13cr.txt", sep = ",", header = TRUE)

## Crown score per each crown summarised from differential between validation pts
## and modelled crowns _ NOTE due to hungry algorithm in eCog, not same number of
## crowns in each model
mod_no <- df_no %>%
        select(UM_FID_ID, dist_to_cr)%>%
        group_by(UM_FID_ID)%>%
        summarise(cs_no = sum(dist_to_cr))

mod_5_3 <- df_5_3 %>%
        select(UM_FID_ID, dist_to_cr)%>%
        group_by(UM_FID_ID)%>%
        summarise(cs_5_3 = sum(dist_to_cr))

mod_6_3 <- df_6_3 %>%
        select(UM_FID_ID, dist_to_cr)%>%
        group_by(UM_FID_ID)%>%
        summarise(cs_6_3 = sum(dist_to_cr))

mod_7_3 <- df_7_3 %>%
        select(UM_FID_ID, dist_to_cr)%>%
        group_by(UM_FID_ID)%>%
        summarise(cs_7_3 = sum(dist_to_cr))


mod_8_3 <- df_8_3 %>%
        select(UM_FID_ID, dist_to_cr)%>%
        group_by(UM_FID_ID)%>%
        summarise(cs_8_3 = sum(dist_to_cr))

mod_9_3 <- df_9_3 %>%
        select(UM_FID_ID, dist_to_cr)%>%
        group_by(UM_FID_ID)%>%
        summarise(cs_9_3 = sum(dist_to_cr))

mod_10_3 <- df_10_3 %>%
        select(UM_FID_ID, dist_to_cr)%>%
        group_by(UM_FID_ID)%>%
        summarise(cs_10_3 = sum(dist_to_cr))

mod_11_3 <- df_11_3 %>%
        select(UM_FID_ID, dist_to_cr)%>%
        group_by(UM_FID_ID)%>%
        summarise(cs_11_3 = sum(dist_to_cr))

mod_12_3 <- df_12_3 %>%
        select(UM_FID_ID, dist_to_cr)%>%
        group_by(UM_FID_ID)%>%
        summarise(cs_12_3 = sum(dist_to_cr))


## Overall "score" for each model
mod_no <- sum(mod_no[,2])
mod_5 <- sum(mod_5_3[,2])
mod_6 <- sum(mod_6_3[,2])
mod_7 <- sum(mod_7_3[,2])
mod_8 <- sum(mod_8_3[,2])
mod_9 <- sum(mod_9_3[,2])
mod_10 <- sum(mod_10_3[,2])
mod_11 <- sum(mod_11_3[,2])
mod_12 <- sum(mod_12_3[,2])

## Put overall scores into a vector
allMods <- c(mod_no, mod_5, mod_6, mod_7, mod_8, mod_9, mod_10, mod_11, mod_12)
#names(allMods) <- c("cs_no", "cs_5_3", "cs_6_3", "cs_7_3", "cs_8_3", 
#                    "cs_9_3", "cs_10_3", "cs_11_3", "cs_12_3")

## To create a variable that is change to last model need to create 2 temp vectors
## to use in calcs
a <- allMods[2:length(allMods)] # Miss 1st as cat compare to self
b <- allMods[1:length(allMods)-1] # Remove last to keep same length and work in calc
d <- (b-a)/b*100 # % change from last model score
e <- c(0,d) # Pad with leading zero to make same length

## Vector of row model names
Mnames <- c("cs_no", "cs_5_3", "cs_6_3", "cs_7_3", "cs_8_3", 
            "cs_9_3", "cs_10_3", "cs_11_3", "cs_12_3")

## Yah a data frame with column names!!
allDF <- data.frame(Mnames, allMods, e)
names(allDF) <- c("model", "score", "delta")


## Fix factor order in whole dataset so xaxis prints in sensible order (levels argument)
allDF$model <- with(allDF, factor(model, levels = c("cs_no", "cs_5_3", "cs_6_3",
                                                            "cs_7_3", "cs_8_3", "cs_9_3",

                                                    "cs_10_3", "cs_11_3", "cs_12_3")))

## Create copy of all data to subset
sDF <- allDF
sDF$model <- as.character(sDF$model)# Turn to character otherwise levels gets screwed

sub2 <- sDF[3:9,] # subset from 6_3 model

## IMPORTANT recreate levels
sub2$model <- with(sub2, factor(model, levels = c("cs_6_3","cs_7_3", "cs_8_3", "cs_9_3",
                                                 "cs_10_3", "cs_11_3", "cs_12_3")))



## Plots for all data

ggplot(allDF, aes(x=model, y=score, group=1)) +
        geom_point() +
        geom_line()

ggplot(allDF, aes(x=model, y=delta, group=1)) +
        geom_point() +
        geom_line()
## Plots for sub1

ggplot(sub1, aes(x=model, y=score, group=1)) +
        geom_point() +
        geom_line()

ggplot(sub1, aes(x=model, y=delta, group=1)) +
        geom_point() +
        geom_line() +
        geom_hline(yintercept=mmin, colour = "red", linetype = 2) +
        theme_bw()

## Plots for sub2

ggplot(sub2, aes(x=model, y=score, group=1)) +
        geom_point() +
        geom_line()

ggplot(sub2, aes(x=model, y=delta, group=1)) +
        geom_point() +
        geom_line()  +
        geom_hline(yintercept=mmin, colour = "red", linetype = 2) +
        theme_bw()





## double plot
allDF$m <- 1:9
sub2$Model <- 1:7
mainlab <- c("cs_6_3","cs_7_3", "cs_8_3", "cs_9_3","cs_10_3", "cs_11_3", "cs_12_3")

## Set up for plots
## View port set sup picture in picture window ( position x, position y, width, height)
vp <- viewport(.75, .7, .4, .4) 
mmin <- min(sub2[,3])
## helper function to call and plot both plots
bothplots <- function(){
        print(mainplot)
        print(subplot, vp = vp)
}

## Main plot using subset data
mainplot <- ggplot(sub2, aes(x=Model, y=delta)) +
                        ylim(c(0,20)) +
                        geom_point() +
                        ylab("% change to prior model") +
                        scale_x_discrete( 
                                         labels = c("cs_6_3",
                                                    "cs_7_3", "cs_8_3", "cs_9_3",
                                                    "cs_10_3", "cs_11_3", "cs_12_3"))+
                        geom_line()  +
                        geom_hline(yintercept=mmin, colour = "red", linetype = 2) +                        
                        theme_bw() +
                        theme(axis.text.x=element_text(angle=75, hjust=1)) +
                        ggtitle("Percentage change from last model - models 6 through 12")

## Sub plot using all data with highlighted region
subplot <- ggplot(allDF, aes(x=model, y=delta, group=1)) +
                        ylim(c(0,70)) +
                        geom_point() +
                        geom_line()  +
                        xlab(NULL)+
                        ylab(NULL) +
                        #title("Percentage change from last model") +
                        geom_rect(data = NULL, aes(xmin = 3, xmax = 9,
                                  ymin = 0, ymax = Inf), fill = "red", alpha = 0.05) +
                        theme_bw() +
                        theme(axis.text.x=element_text(angle=75, hjust=1)) +
                        ggtitle("All models") +
                        theme(plot.title = element_text(size = 15))



png(filename = "Plot in Plot.png", width = 600, height = 480)
bothplots()
dev.off()


full()

## Table out not for above
table <- xtable(csALL)
print.xtable(table, type="html", file="test.html")
