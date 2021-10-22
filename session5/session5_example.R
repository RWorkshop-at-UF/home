
library(ggplot2)
library(dplyr)

## Base R plots | Scatter Plot -- <a href="https://www.rdocumentation.org/packages/graphics/versions/3.6.2/topics/plot">`plot()`</a> function
# Data set
df_i <-read.csv("data/finance_example.csv")
# Plot Cost of Revenue on Revenue
# Note: There are outliers
df_i %>%
  filter(
    Revenue < quantile(Revenue, 0.9, 
                       na.rm = T)) -> df

plot(df$Revenue, df$Cost.of.Revenue,
     main="This is a scatter plot",
     ylab="Cost of Revenue",
     xlab="Revenue")
# xlim=c(lower_bound, upper_bound)
# ylim=c(lower_bound, upper_bound)

# Plot histogram of Revenue
hist(df$Revenue,
     breaks = 30,
     freq = F,
     # if freq = F -> prob. density
     # if freq = T -> count
     main="This is a histogram",
     xlab="Revenue")


# Plot regression Line over a scatter plot
lmodel = lm(df$Cost.of.Revenue ~ df$Revenue)
# Bottom layer
plot(df$Revenue, df$Cost.of.Revenue,
     main="This is a scatter plot",
     ylab="Cost of Revenue",
     xlab="Revenue")
# Add a line Layer
abline(lmodel, col="red", lty=2, lwd=3)
# Add a legend layer
legend("topright",
       legend=c("obs cost of rev", "pred cost of rev"),
       col=c("black", "red"),
       pch=c(1,26),  # point character
       lty=c(0, 2)   # line types
)

# Plot regression Line over a scatter plot
lmodel = lm(df$Cost.of.Revenue ~ df$Revenue)
# Bottom layer
plot(df$Revenue, df$Cost.of.Revenue,
     main="This is a scatter plot",
     ylab="Cost of Revenue",
     xlab="Revenue")
# Add a line Layer
abline(lmodel, col="red", lty=2, lwd=3)
# Add a legend layer
legend("topright",
       legend=c("obs cost of rev", "pred cost of rev"),
       col=c("black", "red"),
       pch=c(1,26),  # point character
       lty=c(0, 2)   # line types
)

## Base R plots | Composing Multiple Plots 2.1
# Change the figure margins
par(mar=c(1,1,1,1))
# Set layout
layout(matrix(c(1,1,2,3), nrow=2, byrow=T), 
       widths=c(3,1), heights = c(1,2))
# plot1: Horizontal boxplot of revenue
boxplot(df$Revenue, horizontal=T)
# plot2: Plot of rev. vs. cost of rev.
plot(df$Revenue, df$Cost.of.Revenue)
# plot3: vertical boxplot of cost of rev.
boxplot(df$Cost.of.Revenue)

# fig=c(x1,x2, y1, y2) x & y range from 0 - 1
plot.new()
par(mar=c(1,1,1,1))
# plot1: Horizontal boxplot of revenue
par(fig=c(0,0.8,0.8,1), new=TRUE)
boxplot(df$Revenue, horizontal=T)
# plot2: Plot of rev. vs. cost of rev.
par(fig=c(0,0.8,0,0.8), new=TRUE)
plot(df$Revenue, df$Cost.of.Revenue)
# plot3: vertical boxplot of cost of rev.
par(fig=c(0.8,1,0,0.8), new=TRUE)
boxplot(df$Cost.of.Revenue)


par(mfrow=c(2,2))
# plot1: boxplot of revenue
boxplot(df$Revenue, horizontal = T)
# plot2: boxplot of cost of rev.
boxplot(df$Cost.of.Revenue, horizontal = T)
# plot3: histogram of revenue
hist(df$Revenue, breaks = 30, main="rev")
# plot4: histogram of cost of rev.
hist(df$Cost.of.Revenue, breaks=30, 
     main="cost. rev")



###############################################################################
###################################  ggplot2  #################################
###############################################################################
# Basic Syntax
ggplot() +       # Note: `+` is used to add ggplot elements!
  <geom_function>(data=<DATA>, mapping=aes(<mappings>))

# Global data
ggplot(data=<DATA>) +
  <geom_function>(mapping=aes(<mappings>))

# Global data and Mapping
ggplot(data=<DATA>, mapping=aes(<mappings>)) +
  <geom_function>()

df<-read.csv("data/finance_example.csv")
ggplot(data=df,
       # data: which dataset to plot
       mapping=aes(
         x=Revenue,
         y=Cost.of.Revenue)) +
  # aes: variables for x and y
  geom_point()                              
# geom_point: scatter plot

df<-read.csv("data/finance_example.csv")
# str(df)
ggplot(data=df,
       # data: which dataset to plot
       mapping=aes(x=Revenue,y=Cost.of.Revenue)) +
  # aes: variables for x and y
  geom_point()                              
# geom_point: scatter plot

  
## ggplot2 | Example
df %>%
  ggplot(mapping=aes(
    x=Revenue,
    y=Cost.of.Revenue,
    color=Revenue > quantile(df$Revenue,0.97, na.rm=T))) +
  # Other commonly used aes args
  # fill, size, shape, alpha
  geom_point()+ 
  guides(color=guide_legend(title="> 97% percentile"))                              

df %>%
  ggplot(mapping=aes(
    x=Revenue,
    y=Cost.of.Revenue,
    color=Revenue > quantile(df$Revenue,0.97, na.rm=T))) +
  geom_point()+ 
  guides(
    color=guide_legend(title="> 97% percentile")) 

## ggplot2 | Mapping vs. Setting
# Mapping
ggplot(data=df,
       mapping=aes(x=Revenue,
                   y=Cost.of.Revenue, 
                   color= Sector)) + # within aes
  geom_point()  
# Setting
ggplot(data=df,
       mapping=aes(x=Revenue,
                   y=Cost.of.Revenue),
       color= Sector) + # outside aes
  geom_point()

  
## ggplot2 | Mapping and Geometries
ggplot(data = df) + 
  stat_count(mapping = aes(x = Sector))+ 
  theme(axis.text.x = element_text(
    angle = 90, vjust = 0.5, hjust=1))
ggplot(data = df) +
  geom_bar(mapping = aes(x = Sector))+
  theme(axis.text.x = element_text(
    angle = 90, vjust = 0.5, hjust=1))

df %>%
  group_by(Sector) %>%
  summarize(freq=n()) %>%
  ggplot() +
  geom_bar(mapping = aes(x = Sector, y = freq), stat = "identity")+
  theme(axis.text.x = element_text(
    angle = 90, vjust = 0.5, hjust=1))

df %>%
  count(Sector, name="freq") %>%
  ggplot() + 
  geom_col(aes(x=Sector, y=freq))

df %>%
  ggplot() + 
  geom_bar(aes(
    x=Sector, 
    y=after_stat( count / sum(count)*100))
  )

  
## ggplot2 | Scales - Examples
df<-read.csv("data/finance_example.csv")

ggplot(data=df,
       aes(x=Revenue,
           y=Cost.of.Revenue)) +
  geom_point()
ggplot(data=df,
       mapping=aes(x=Revenue,y=Cost.of.Revenue)) +
  geom_point()+
  scale_x_continuous(
    limits=c(0, 2.5*10^11),
    breaks=seq(0, 2.5*10^11, by=10^11)
  )+ 
  ylim(0, 2*10^11)

ggplot(data=df,
       mapping=aes(x=Revenue,y=Cost.of.Revenue,
                   color=Sector)) +
  geom_point()+
  scale_x_continuous(
    trans="log10"
  )+ 
  ylim(0, 2*10^11)

  
  
## ggplot2 | Facets
read.csv("data/finance_example.csv") %>%
  filter(Revenue < quantile(Revenue, 0.9, 
                            na.rm = T)) %>%
  mutate(partition = rep(c(1, 1, 0, -1), len=nrow(.)))-> df

df %>%
  ggplot()+
  geom_point(aes(x=Revenue, y=Cost.of.Revenue))+
  # facet_wrap(~ Sector)                     # Facet is often the best way to avoid overplotting
  # facet_wrap(~ Sector, scales='free')      # free_y or free_x
  # facet_grid(partition ~ Sector)           # facet_grid graphic pivots
  # facet_wrap(~ drv+year)                   # Subsetting data

ggplot(df)+
  geom_bar(aes(y=Sector))+
  # facet_grid(Sector ~ .)
  facet_grid(Sector ~ ., scale="free_y" , space="free_y")

  
## ggplot2 | Coordinates
# Polar coordinates
df %>%
  ggplot()+
  geom_bar(aes(x=Sector))+
  coord_polar()
# Coord flip
df %>%
  ggplot()+
  geom_bar(aes(x=Sector))+
  coord_flip()
# Zoom-in
df %>%
  ggplot()+
  geom_bar(aes(x=Sector))+
  # scale_y_continuous(limits=c(0, 300))      
  coord_cartesian(ylim=c(0, 300))  

df %>%
  ggplot()+
  geom_bar(aes(x=Sector))+
  facet_wrap(~ partition)+
  theme_minimal()          # There are built-in themes

df %>%
  ggplot()+
  geom_bar(aes(x=Sector))+
  facet_wrap(~ partition)+
  theme_minimal()+
  labs(
    title="this is a title",
    caption="this is a caption",
    x="this is x-axis label",
    y="this is y-axis label"
  )+
  theme(
    axis.text = element_text(colour = "red", size = rel(1.5), family = "serif"),
    panel.grid.major = element_line("steelblue"),
    # panel.grid.major.y = element_blank(),
    panel.grid.major.x = element_blank()
  )
