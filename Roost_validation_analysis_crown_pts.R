rm(list=ls())


library(dplyr)
library(ggplot2)
library(xtable)


df <- read.table("UM_valid_cc_roost_NEAR_crown_pts.txt", sep = ",", header = TRUE)
df_no <- read.table("UM_valid_cc_roost_NEAR_crown_pts_NO.txt", sep = ",", header = TRUE)
df_5_3 <- read.table("UM_valid_cc_roost_NEAR_crown_pts_5_3.txt", sep = ",", header = TRUE)
df_6_3 <- read.table("UM_valid_cc_roost_NEAR_crown_pts_6_3.txt", sep = ",", header = TRUE)


orig <- df %>%
                select(UM_FID_ID, dist_to_cr)%>%
                group_by(UM_FID_ID)%>%
                summarise(cs = sum(dist_to_cr))

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

csALL <- cbind(orig, mod_no[,2], mod_5_3[,2], mod_6_3[,2])

mods <- colSums(csALL[,2:length(csALL)])


table <- xtable(csALL)

print.xtable(table, type="html", file="test.html")
