rm(list=ls())


library(dplyr)
library(ggplot2)


df <- read.table("UM_valid_cc_roost_NEAR_crown_pts.txt", sep = ",", header = TRUE)

crown_score <- df %>%
                select(UM_FID_ID, dist_to_cr)%>%
                group_by(UM_FID_ID)%>%
                summarise(crown_score = sum(dist_to_cr))

crown_score
