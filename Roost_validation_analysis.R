rm(list=ls())

library(dplyr)
library(ggplot2)

df <- read.table("UM_valid_cc_roost_NEAR.txt", sep = ",", stringsAsFactors= FALSE,
                 header = TRUE)

quantile(df$NEAR_DIST)

df$bin <- as.character("value")


for(i in 1:length(df$NEAR_DIST)){
if(df$NEAR_DIST[i] < 1){
        df$bin[i] <- "0-1m"
} else if (df$NEAR_DIST[i] >= 1 & df$NEAR_DIST[i] < 2){
        df$bin[i] <- "1-2m"
} else if (df$NEAR_DIST[i] >= 2 & df$NEAR_DIST[i] < 3){
        df$bin[i] <- "2-3m"
} else if (df$NEAR_DIST[i] >= 3 & df$NEAR_DIST[i] < 4){
        df$bin[i] <- "3-4m"
} else {
        df$bin[i] <- "4m+"
}
}


## Hist and density plot
ggplot(df, aes(NEAR_DIST))+
        geom_histogram(aes(y = ..density..), binwidth = 1)+
        geom_density(fill = "red", alpha = 0.2)+
        theme_bw()+
        xlab("Distance from roost tree (m)")+
        ylab("Probability density")

## Hist only
ggplot(df, aes(NEAR_DIST))+
        geom_histogram(binwidth = 1)+
        theme_bw()+
        xlab("Distance from roost tree (m)")+
        ylab("Count (n=43)")

