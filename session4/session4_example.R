library(dplyr)
library(lubridate)

setwd("C:\\Users\\Tek\\Desktop\\RWorkshop\\session4")
# df<- read.csv("data/thermostat_amazon.csv")
str(df)
# View(df)

table(df$info_2)

df %>% 
  mutate(
    verfied=ifelse(grepl(".*Verified.*", info_2), "yes", "no"),
    days_to_review=gsub("Pattern: (.*) Day.*", "\\1", info_2) %>%
      gsub("[^[:digit:]-]", "", .) %>%
      gsub("^1", "", .) %>%
      sapply(function(x){switch(x, "5-1-1"=5, "5-2"=3, "7-"=7, NA)}) %>%
      as.numeric(),
    star_rating=as.numeric(gsub(" out.*", "", star)),
    date=gsub("on ","", date),
    Year=gsub(".*, (.*)", "\\1", date),
    Day=gsub(".* (.*), .*", "\\1", date),
    Month=gsub("(.*) .*, .*", "\\1", date),
    Month2=match(Month, month.name)
  ) %>%
  rowwise() %>%
  mutate(
    date=paste(c(Month2, Day, Year), collapse = "-")
) %>%
  dplyr::select(everything(), -Year, -Day, -Month, -Month2)->df

# str(df)
View(df)

write.csv(df, "data/example.csv", row.names = F)
df<- read.csv("data/example.csv")


table(df[duplicated(df2$author)|duplicated(df2$author, fromLast = T), "author"])
which(duplicated(df2$author))

lapply(unique(df2$product), 
       function(x){
         subset(df2, product==x, select="star_rating") %>%
           mean(na.rm=T)})

subset(df2, product=="Hunter_44157", select="star_rating") %>%
  unlist() %>%
  mean()
