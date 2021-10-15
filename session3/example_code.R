
# Session 3 & 4 Example Codes

###############################################################
#####################  Control Structures #####################
###############################################################

#####################  if-else Statement  #####################

# Try the following codes with different xs
 
x <- 5
if(x > 2){
  print("x is greater than 2")
}

x <- 1
if(x > 2){
  print("x is greater than 2")
} # Nothing happens if FALSE

if(x > 2){
  print("x is greater than 2")
} else {
  print("x is less or equal to 2")
} # Use the else statement

if(x > 5){
  print("x is greater than 5")
} else if(x > 2){
  print("x is greater than 2")
} else {
  print("x is less or equal to 2")
}

#####################  if-else Statement  #####################

x <- 5
ifelse(x>2, "x is greater than 2", "x is less or equal to 2")
x <- 1
ifelse(x>2, "x is greater than 2", "x is less or equal to 2")


### Compare if-else statement and if-else function

x<-1:5

# if-else
if(x >= 4){
  paste0(x, " is high-rated")
} else if (x >= 2){
  paste0(x, " is mediocre")
} else{
  paste0(x, " is low-rated")
}  # NOT the desired output


# ifelse()
ifelse(x >= 4, paste0(x, " is high-rated"),
       ifelse(x >= 2, paste0(x, " is mediocre"), 
              paste0(x, " is low-rated")
       ) # close the 2nd ifelse function
)   # close the 1st ifelse function
# Vectorized!


#####################  Switch Statement  #####################

switch("b", "a"="alpha", "b"="beta", "zeta")  # match by character
switch(1, "a"="alpha", "b"="beta", "zeta")    # match by index
switch("c", "a"="alpha", "b"="beta", "zeta")  # returns "zeta" if no match

# sapply is covered later in this session
sapply(1:6, function(x){
  switch(x,
         `1`=paste0(x, " is low-rated"),
         `2`=paste0(x, " is mediocre"),
         `3`=paste0(x, " is mediocre"),
         `4`=paste0(x, " is high-rated"),
         `5`=paste0(x, " is high-rated"),
         paste0(x, " is not an integer btw 1-5")
  )}
)


###############################################################
###########################  Loops  ###########################
###############################################################

#########################  for Loops  #########################

# Back to our leap year example from Session 1
# Task 1: Count the number of leap years between 1900 - 2000
# Task 2: What are the actual leap years? Print them!

count <- 0
leap_years=NULL

for(x in 1900:2000){
  if( (x %% 4 == 0) & ((x %% 100 !=0) | (x %% 400 == 0)) ){
    count = count+1   # R does not have += or ++
    leap_years = c(leap_years, x)
  }
}
count                 # 25
leap_years            # 1904, 1908, 1912, ..., 2000 


### Nested for loops (for loop within another for loop)
# Have multiple index values i, j, ...
for (i in 1:2){                       # indexing iterations is very common
  for(j in c("apple", "banana"))      # but... can be any vector or list
    print(paste(i, j , collapse=" ")) # without {}. Not recommended
}


# Print every cell in a matrix
mdat=matrix(1:20, nrow=4, byrow=T)
for(r in 1:nrow(mdat)){
  for(c in 1:ncol(mdat)){
    print(paste0("the value of row:", r, " & col:", c, " is ", mdat[r, c]))
  }
}


### break statement

for(i in 1:5){
  if(i == 3) break 
  print(i)
}


### next statement

for(i in 1:5){
  if(i == 3) next
  print(i)
}


### Check the efficiency between the two codes
# Method1: re-assign x after every iteration 

proc.time() -> ptm  # Sys.time() works
x <- NULL

for(i in 1:10^4){
  set.seed(i)       # to replicate
  x = c(x, rnorm(1))# new x after ea. iter.
  # print(i)        # to check progress
}
proc.time() - ptm


# Method2: pre-defined y
proc.time() -> ptm
y <- numeric(10^4)

for(i in 1:length(y)){
  set.seed(i)
  y[i] = rnorm(1) # fill-in x
  # print(i)
}
proc.time() - ptm


#######################  While Loops  #######################

# Example
count <- 1
while(count < 4){
  print(paste0(count, " mississippi ... "))
  count=count+1
}
print("zzZ")

# Example
count <- 1
while(count < 4){
  print(paste0(count, " mississippi ... "))
  count=count+1
}
print("zzZ")



###############################################################
#########################  Functions  #########################
###############################################################

# A function has three components: Argument(s), body, and environment

f <- function(x){
  x+2
}
# function name: f
# argument: x
# body: x+2
f(2)

f <- function(x){
  return(x+2)
  print("not printed")
}
# Use the "return" function to specify the function output
# o.w. your function will return the last line
f(2)

f <- function(x){
  x+2
  print("not printed")
}
f(2)


### Setting default inputs

g <- function(x=1, y = 2){ # set defaults for x and y
  x+y
}
g()       # 1 + 2
g(x=3)    # 3 + 2
g(y=3)    # 1 + 3
g(5, 10)  # 5 + 10


### Passing down additional arguments using the ... argument

# You have two functions: f1 and f2
# Let's embed f1 inside f2

# Method 1: Compute f1 and use the output as an input for f2
f1 <- function(x, y){
  x+y
}
f2 <- function(a, b){
  a*b
}
f2(5, f1(1,2))


# Method 2: You can specify all the arguments of the embedded function f1

f2 <- function(a, x, y){
  a * f1(x, y) 
}
f2(5, 1, 2)


# Method 3: You can use the ... function to pass
# Efficient!

f2 <- function(a, ...){
  a * f1(...) 
}
# f2(5, 1, 2)
f2(5, x=1, y=2)

f2 <- function(a, ...){
  a * f1(x=..1, y=..2) 
}
# ..N to refer position
f2(5, 1, 2)


### Compose multiple functions
# Task
# First, take square root of every element in x
# Then, take natural log
# Last, take the average of the values

x <- 1:10

# Method 1: Creates new objects
step1 <- sqrt(x)
step2 <- log(step1)
mean(step2)


# Method 2: Nest functions
mean(log(sqrt(x)))
# Compact but...
# Can stretch out
# Diff. to read


# Method 3: Use the pipe operator
x |>
  sqrt() |>
  log() |>
  mean()


### |> vs. %>%  (there are a lot of other pipe operators)
# without a pipe
x <- c(1, 10, 100)
log10(x)

# base pipe |>
x |>
  log10()

library(magrittr)
x %>%
  log10()


### How to use placeholder with %>% operator

f(x, y) # "roughly" equivalent to
y %>%
  f(x, .)

f<-function(x,y) x^y
1 %>%
  f(2)    # 1^2

# compare the difference
1 %>%
  f(2,.)  # 2^1

1:10 %>%
  {c(avg=mean(.), stdev=sd(.))}

c(4, 2) %>%      # l = 4; w =w
  {.[1] * .[2]}  # Area of a Rectangle


###############################################################
###################  Handling Errors in R  ####################
###############################################################

# Why is this important?

a_list=list(1, 2, "a", 4)
# Note: a list can have different object types

for(i in a_list){
  print(i+2)
}
# Error Introduced b/c of "a"+2
# the for loop breaks and exits

# FYI, you can "mute" error messages but...
options(error = expression(NULL)) 

stop("this error")


tryCatch({
  statements
},
error=function(e){
  error-handling-code
},
warning=function(w){
  warning-handling-code
},
message=function(m){
  message-handling-code
},
finally={
  statements
})

tc <- function(x){
  tryCatch({
    x+2
  },
  error=function(...){
    if(is.character(x))
      paste0(x, " is a character")
  })
}

tc(2)

tc("2")

tc(NA)

# Recall previous example
a_list=list(1,2,"a",4)
for(i in a_list){
  print(
    tryCatch(
      {i+2}, 
      error=function(e){NA}  # If error, return NA
    )
  )
}

tc <- function(x){
  tryCatch({x},
           error=function(e){print("error-handling-code")},
           warning=function(w){print("warning-handling-code")},
           message=function(m){print("message-handling-code")},
           finally = {message("final message")}
  )}

# Check how to generate messages when writing a function
good_f <- function(){print("good")}
err_f  <- function(){stop("this is an error")}
warn_f <- function(){warning("this is a warning")}
msg_f  <- function(){message("this is a message")}

tc(good_f()); tc(err_f()); tc(warn_f()); tc(msg_f())

# Basic Syntax
apply(x, margin, FUN, ...)
# x: a matrix/array (important!)
# margin: 1 <- row, 2 <- column, 1:2 <- each cell
# FUN: a function to apply
# ...: additional arguments for the FUN

df<-data.frame(col1=1:4, col2=c(1,2, NA, NA), col3=c(NA, "2", "3", "4"))

# Take the avg. of column 1 & 2
# apply(df[, 1:2], 2, mean)          # NA in 2nd col
apply(df[, 1:2], 2, mean, na.rm=T)

# Count the number of NAs in each column
apply(df, 2, function(x){sum(is.na(x))})

# Sum each column
# Desired output: 10 3 9
df<-data.frame(
  col1=1:4,
  col2=c(1,2, NA, NA),
  col3=c("N/A", "2", "3", "4"))

# Recall tryCatch
apply(df, 2, function(x){tryCatch({sum(x)}, error=function(e)NA)})
# At least we expect the result to be 10 NA NA
# But why all NA?

apply(df, 2, function(x, ...){sum(as.numeric(x), ...)}, na.rm=T)
# Read the warnings msg. What was the trigger?

lapply(x, FUN, ...)  # "list" apply
# x: a vector or a list
# lapply function returns a list

sapply(x, FUN, ...)  # "simple" apply.
# A wrapper for lapply()
# Simplify the output if possible

l=list(a=matrix(1:9, nrow=3), b=matrix(7:10, nrow=2), c=matrix(4:15, nrow=4))

options(digits = 2)
lapply(l, function(x){
  c(avg=mean(x), std=sd(x))
})

options(digits = 2)
sapply(l, function(x){
  c(avg=mean(x), std=sd(x))
})

# 1st row
lapply(l, "[", 1, )

lapply(l, "[", , 2)   # 2nd col
lapply(l, "[", 1, 2)  # 1st row, 2nd column
# "[[" can also be used as an argument 

ll=list(A=list(a=matrix(1:9, nrow=3), b=matrix(7:10, nrow=2)), c=matrix(4:15, nrow=4))
lapply(ll, "[", 1)
lll=list(A=list(a=matrix(1:9, nrow=3), b=list(matrix(7:10, nrow=2), c(1,2,3))), c=matrix(4:15, nrow=4))
lapply(lll, "[[", 2)
lapply(lll, "[", 2)

