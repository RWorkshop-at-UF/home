

# This file contains R Script to Session1

###############  Before we Begin...  #################################

# 1. Create a working directory on your desktop
# 2. Download Session1_Dataset and extract the files in your wd
# 3. Load this script in R Studio


###############  R Studio Interface  #################################

x<-1:5         # Check the 3rd pane
plot(x)        # check the 4th pane
Sys.sleep(60)  # Check the 2nd pane (stop symbol) -- How to interrupt R


###############  How to Install R Packages ############################

install.packages("dplyr")
install.packages(c("readxl", "ggplot2", "dplyr", "openxlsx"))
install.packages("devtools")
devtools::install_github("RWorkshop-at-UF/pkg_example")


###############  How to Load R Packages  ##############################

library(dplyr) # Returns an error if the requested pkg not found
require(dplyr) # Returns FALSE if the requested pkg not found

# How do we load multiple functions at once?
pkg <- c("readxl", "ggplot2")           
sapply(pkg, require, character.only = TRUE)

# Load the package "welcome"
library(welcome)
GreetingsFrom("Tek") # There is one function "GreetingsFrom()" in the "welcome" package

# Without loading a package
welcome::GreetingsFrom("Tek")  # package_name::function_name

# How to uninstall a package from the system
remove.packages("welcome")

# How to source functions and data set from another R script?
source("data/another_script.R")
common_func1()
common_data


###############  Working with Directories in R  ########################

# Root directory
setwd("/")
getwd()

# Home directory
setwd("~")
getwd()

# Current directory
setwd(".")
getwd()

# Move to the parent directory
setwd("./..")
getwd()      
setwd("C:/Users/Tek/Desktop/RWorkshop")      # change the PATH!
setwd("C:\\Users\\Tek\\Desktop\\RWorkshop")  # `\` requires 'escape' -> \\
getwd()

# Try to navigate to your working directory
setwd(choose.dir())
getwd()


###############  Examine a directory  ###############################

# list.dirs()
# list.files()
# dir()

list.files(pattern=".*\\.html")     # list any file with .html extension
dir(pattern=".*\\.html")            # list any file with .html extension


###############  Create a new directory and file  ####################

######  Motivation
#  -- What if you plan to collect multiple data set?
#  -- Run multiple data set/models and save them separately
#  -- Keep output temporarily, but then erase afterward

# Create a new directory
dir.create("new_dir")
# The above code may generate a warning if the directory already exists
dir.create("new_dir", showWarnings=F)

# Create a new file
file.create("new_dir/new_text_file.txt")

# Remove a directory or a file
unlink("new_dir/new_text_file.txt")  # Remove a file
unlink("new_dir", recursive = T)     # Remove a directory


###############  How to read/write a data set  ########################

##### Read/Write csv file

df<-read.csv("data/csv_example.csv")   
# read.csv("data/semicol.csv", header = F, sep = ";")

# It is always a good practice to check your data after loading it
str(df)       # Returns the structure of the object
head(df)      # Returns first n observations (default 6)
tail(df, 100) # Returns last 100 observations
View(df)      # uppercase V. Displays the entire data in a new tab

# read csv from an online source
x="https://raw.githubusercontent.com/nytimes/covid-19-data/master/us.csv"
mydata<-read.csv(x)  # I am going to name it "mydata" this time

# Other packages and functions that reads csv format
# May need to install additional packages
mydata2 <- readr::read_csv(x)
mydata3 <- data.table::fread(x)

# Comparison
system.time(read.csv(x));
system.time(readr::read_csv(x));
system.time(data.table::fread(x));

# Write csv
write.csv(df, "data/new_csv.csv", row.names = F)


##### Read/Write excel extension (.xlsx)

# There is no base R function to read the xlsx extension
# Need to install additional packages
# Consider the following packages and functions
readxl::read_excel()
xlsx::read.xlsx()
openxlsx::read.xlsx()

# Example
readxl::read_excel("data/xlsx_example.xlsx", 2)

# write xlsx
writexl::write_excel()
openxlsx::write.xlsx()
xlsx::write.xlsx()

# Example
x=list(sheet_one=mtcars, sheet_two=iris)
openxlsx::write.xlsx(x, "data/new_xlsx.xlsx")


##### Read/Write .rds file

# First, let's read a csv file then save as an RDS file
thermo <- read.csv("data/thermostat_amazon.csv")
saveRDS(thermo, "data/thermostat_amazon.rds")

# Read rds
thermo_rds<-readRDS("data/thermostat_amazon.rds")

# Check the size difference
file.size("data/thermostat_amazon.csv")/10^6
file.size("data/thermostat_amazon.rds")/10^6

# rds or rdata extensions are fast and efficient


##### Read/Write lines

readLines("data/text_file_example.txt")  # Not restricted to txt format
readLines("session1_master.Rmd")

x=c("first line", "second line", "third line")
writeLines(x, "data/new_txt.txt")


##### Read/Write .json extension

jsonlite::fromJSON("data/json_example.json")
jsonlite::fromJSON("https://api.fda.gov/drug/event.json?limit=3")

# Create a nested list to save it as json file
nested_list<-list(vec=c(1,2), mat=list(mat1=diag(2), mat2=matrix(0,3,4)))
# Transform into as json format
now_json<-jsonlite::toJSON(nested_list, pretty=T)
# save the data as .json extension
write(now_json, "data/new_json.json")


###############  Operator syntax  #############################

###### Assignment operators
x<-1
y=1:5
c("left", "to", "right")->z

# Difference between <- and <<-
g=function(){
  not_saved <-"saved inside a function envvironment";
}
g()
f=function(){
  saved<<-"saved to the global environment"
}
f()


##### Naming Conventions

# Remove space(s)
`space here`<-"there is a space"     # You can do it but...
space_here<-"this is better"

# Avoid using names that has special meanings or
`next`<-"you can do it but..."
next
`next`

# Avoid having "."
.<-1                  # You can do it but...
.+.

na.me<-"This type of naming may have a special meaning"
na.me


##### Mathematical Operators
# Think R as a calculator
1+2
-1*10
2^2
17/2
17%/%2
17%%2

# There are other base math functions
sqrt(4)
sin(pi/2)
exp(1)
log(exp(1))
log10(10)


##### Relational Operators
# Inequalities
x <- 10        # define x
x > 10         # try < and <= as well
x >= 10
x == 10
x != 10
TRUE==FALSE
FALSE==FALSE
1:5 %in% 3:10  # Among sequential integers in 1-5, 3, 4, 5 is also in sequence 3-10

0==F; 1==T  # TRUE and FALSE could also be 1 and 0
T+T

# Some relational Operators also work for strings
a="apple"; b="banana"
a == b
a != b
!(a != b)

fruits <- c("apple", "banana", "mango")
fruits == "apple"
fruits == c("apple", "banana")     # This will not work
fruits %in% c("apple", "banana")
c("apple", "banana") %in% fruits

##### Logical Operators
# Not x (Negate x)
!T
!F
!c(TRUE, F, 0, 1, 6)
!"chracter"              # Logical operators cannot be used with strings

# OR  (Union)            # Technically, it is "Ladies OR Gentlemen"
# `|` is the element-wise "OR" operator
T|T
T|F
F|F             
c(T, T, F) | c(T, F, F)


# `||` is the length-one logical "OR"
c(T, F, F) || c(F, F, F)  # Only compares the first element on either sides
c(F, T, T) || c(F, T, T)  # FALSE. b/c first two is F when everything else is TRUE

# AND  (Intersection)
# `&` is the element-wise "AND" operator
T&T
T&F
F&F             
c(T, T, F) & c(T, F, F)

# `&&` is the length-one logical "AND"
c(T, F, F) && c(T, F, F)  # Only compares the first element on either sides
c(T, T, T) && c(F, T, T)  # FALSE. b/c first two is F when everything else is TRUE

# `||` and `&&` is useful when writing the if statement ()

# Examples
x<-5
x >= 3 & x < 6

y=c(1, 3, 5, 7)
y <= 3 | y > 6
y <= 3 || y > 6
y >= 3 & y < 6
y >= 3 && y < 6  


###############  Operator Precedence  ############################
# Basically the order of operations
# Operators with higher precedence will be evaluated first

# Example
#* or / will be evaluated before + and -


##################  Your Turn!  ##################################

# Try to figure out the answer without running the code

# 71 %/% 4 / 13 %% 10

# a=5
# c=(a=a-1)*(b=a=a+2)


##################  Useful Hot Keys & More  #######################

# make comments in R: ctrl+shift+c
Make this into a comment
This line as well

# Run the following line:
print("Good Job")

# Run the following lines:
x<-"Again,"
y<-"Wonderful Job!"
print(paste(x, y, collapse=" "))

# Clearing the console: ctrl+l  -- Warning!

# Move between source editor and console: ctrl+1 or2

# Interrupt R: esc or the red stop sign
# Interrupt the sleep
Sys.sleep(60)

# removing objects -- Warning!!!!!!
rm("fruits")                            # Remove fruits
rm(list=c("x", "y"))                    # Remove x and y
rm(list=setdiff(ls(), c("f", "next")))  # Remove Everything except f and next
rm(list=ls())                           # Remove Everything
