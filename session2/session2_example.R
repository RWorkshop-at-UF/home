

# Data Type
is.logical(1)
is.logical(1)

is.numeric(1)
is.integer(1)
is.integer(1L)

is.character(1)
is.character("1")

is.na(c(1,2,NA, NaN, Inf))
is.infinite(c(1,2,NA, NaN, Inf))
is.nan(c(1,2,NA, NaN, Inf))

as.character(5)
as.numeric("Inf")

typeof(1)
typeof(1L)
mode(1); mode(1L)



# Vector
# Create Null Vector
vector()                       
vector("numeric", length=3)    
numeric(3)

# combine c()
c(1,2, 3, 4,5, Inf, NaN)
c("Stuzin", "Hough", "Bryan", "Heavener", NA)
c(T, TRUE, F, FALSE)
# What happens when multiple data types are combined in a single vector?--Coercion (mixing objects)
c(TRUE, FALSE, NA, Inf)
c(1, T, "Stuzin", NA, Inf, NaN)

vect1=c(1,2,3)
vect2=c(4,5,6)
c(vect1, vect2)

# Named Vector
named_vec <- c(eastern="Florida", central="Iowa",       # Note it is "="
               mountain="Colorado",  pacific="California")

# Naming vector
named_vec <- c("Florida", "Iowa", "Colorado",  "California")
names(named_vec) <- c("eastern", "central", "mountain", "pacific")
named_vec

# Sequential Numbering
1:5
seq(5)
seq(1, 2, by=0.1)
seq_len(10)

# Replicate
rep(1:4, times=2)        # 12341234
rep(1:4, each=2)         # 11223344
rep(1:4, each=2, len=4)  # 1122
rep(1:4, c(2,1,2,1))
rep(c("a", "b", "c"), each=2)


# Exampining vectors
UF_bldg<-c("Stuzin", "Hough", "Bryan", "Heavener")
typeof(UF_bldg)
is.character(UF_bldg)
str(UF_bldg)
is.vector(UF_bldg)
length(UF_bldg)

# Check Names
names(UF_bldg)
# Assign names
names(UF_bldg)<-c("STZ", "HGS", "BRY", "HVNR")
# Remove names
names(UF_bldg)<-NULL


# Subsetting vectors
# By logical vector
UF_bldg[c(T, F, T, T)]

UF_bldg == "Hough"                          
UF_bldg %in% c("Stuzin", "Bryan")          
UF_bldg[UF_bldg %in% c("Stuzin", "Bryan")]

# Numeric examples
x<-1:5
x > 2 & x <= 4
x[x > 2 & x <= 4]
!(x > 2 & x <= 4)
x[!(x > 2 & x <= 4)]
subset(1:5, x > 2 & x <= 4 )

# Indexing
UF_bldg[c(1, 3:4)]   # subset the values by indexing
UF_bldg[-c(1, 3:4)]  # `-` indicates "exclude". Result same as "UF_bldg[2]"
UF_bldg[1]           # A single index does not require "c()"
UF_bldg[3:4]

# Use which function to convert logical vector to index
x<-1:5
x > 2 & x <= 4           # the output of  "x > 2 & x <= 4" is c(F, F, T, T, F)
which(x > 2 & x <= 4)    # the output is c(3, 4)
x[which(x > 2 & x <= 4)]

#Subset with Names
UF_bldg<-c("Stuzin", "Hough", "Bryan", "Heavener")
names(UF_bldg)<-c("STZ", "HGS", "BRY", "HVNR")
UF_bldg
UF_bldg[c("STZ", "HVNR")]


# How to modivy vector
UF_bldg<-c(UF_bldg, "Matherly")               # Add "Matherly" at the end
UF_bldg<-c("Matherly", UF_bldg)               # at the begining
UF_bldg<-append(UF_bldg, "Matherly", after=3)

x<-1:3
x[4]<-4
x[6]<-6

# Examples
UF_bldg<-c("Stuzin", "Hough", "Bryan", "Heavener")
names(UF_bldg)<-c("STZ", "HGS", "BRY", "HVNR")

UF_bldg<-c(UF_bldg, "Matherly")         # "Matherly" was added to the UF_bldg
# UF_bldg=="Matherly"                   # One way to locate "Matherly"
UF_bldg[UF_bldg=="Matherly"]<-"Gerson"  # Replace "Matherly" with "Gerson"
names(UF_bldg)[5]<-"GER"  


# Unique/remove duplicate
x<-c(1, 1, 2, 2, 2, 3)
unique(x)                      # 1 2 3 -- first unique observation
unique(x, fromLast = T) 
duplicated(x) 
duplicated(x, fromLast = TRUE)

# Re-ordering
x<-c(5,3,4,1,2)  # reorder to c(1, 2, 3, 4, 5)
x[c(4,5,2,3,1)] 
order(x); order(x, decreasing=T) # ordering can be ascending/descending
x[order(x)]
sort(x); sort(x, decreasing = T)


sort(UF_bldg)
sort(UF_bldg, decreasing=T)


# Converting vector type
x<-1:5; as.character(x)
x<-c("1", "2", "not a number", "Inf"); as.numeric(x)
x<-rep(c("Stuzin", "Hough", "Bryan"), c(2,1,3))
y<-factor(x)    # ordered(x) if ordinal
y 
z<-factor(x, levels=c("Stuzin", "Bryan", "Hough"))
z 
as.character(y); as.character(z)
x<-c(0,1,1,0,1,1,0);   y<-factor(x, levels=c(1,0));   y
as.numeric(y) # What happened? Why not 0, 1, 1, 0, 1, 1, 0?
as.numeric(as.character(y)) # Sol: Convert to character type first!
as.Date("2021-09-23")
as.Date("09/23/2021", format="%m/%d/%Y")
ISOdate(year="2021", month="09", day="23") # Also has other arguments
lubridate::ymd("2021-09-23")


# Vector operations
x<-1:5; x+2
x<-1:5; y<-6:10
y+x
-3*x
y/x
x^y
sqrt(x)

UF_bldg
paste0(UF_bldg, " Hall")


x<-1:10;
mean(x); sd(x); sum(x);
mean(c(1,2,NA,3))  
mean(c(1,2,NA,3), na.rm=T) 
summary(x)
x<-rep(c("A", "B", "C", "F"), c(3,5,2,1))
table(x)
prop.table(table(x))
x<-rep(c(1.2,-3,2.13,pi), c(3,5,2,1))
table(x) 

round(c(1, 1.1, 1.05))
round(c(1, 1.1, 1.02), 2)


# List
# Create List
# Empty
vector("list", length= 2)

# difference between c() and list()
c(named=1,2,3)
list(named=1, 2)
list(int_vec=1:5, char="a line of char strg", a_matrix=matrix(1:4, nrow=2))
list(int_vec=1:4, list(int_vec=5:8, char_vec=letters[1:4]))

Grey<-list(Blue = list(Green=1, Yellow=2), Red=c(3, 4))
length(Grey)
lengths(Grey)
names(Grey)
class(Grey); typeof(Grey);
str(Grey)

Grey[1]
Grey[[1]]
Grey[[1]][1]
Grey[[1]][[1]]

# Note: `[` returns a list
Grey[0]
Grey[1]
Grey[-1]
Grey[c(1:2)]
Grey[c(1,1)]

# Note: `[[` and `$` returns an element
Grey[[1]]        # identical(Grey[[1]], Grey$Blue)
Grey[[-1]]       # Grey[[-1]] == Grey$Red
Grey[[c(1,2)]]   # Grey[[c(1,2)]] == Grey[[1]][[2]]

Grey["Blue"]
Grey[c("Blue", "Red")]

Grey[["Blue"]]
Grey[[c("Blue", "Green")]]

Grey[c(T,F)]      # Grey[1]; Grey["Blue"]
Grey[c(F, T)]     # Grey[2]; Grey["Red"]
Grey[[T]]         # Grey[[1]];  Grey[["Blue"]]; Grey$Blue
Grey[[T]][c(F,T)] # Grey[[1]][2]; Grey[["Blue"]]["Yellow"];
Grey[[T]][[T]]  



list1 <- list(int_vec=1:4); list2=list(seq(0, 0.5, by=0.1))
list(list1, list2)
append(list1, list2) 

list1 <- list(int_vec=1:4); list2<-list(seq(0, 0.5, by=0.1))
list1[[2]]<-list2  
list1[2]<-list2

list1 <- list(int_vec=1:4, na_vec=c(1,2, NA, 3), na_elmt=NA, null_elmt=NULL)
list1[! is.na(list1)]  # complete.cases will not work

list1[is.na(list1)] <- 999
list1[lengths(list1) != 0]  # Note: NULL objects have length 0
Filter(Negate(is.null), list1)

names(list1)
names(list1)[3]<-"Not_NA"

list1 <- list(int_vec=1:2); list2<-list(seq_vec=seq(0, 0.2, by=0.1))
l<-list(list1, list2)
unlist(l)   
unlist(l, recursive = F)


# Matrix
matrix(nrow = 2, ncol = 3)
matrix(nrow = 2, ncol = 3,           # Can assign row and col names
       dimnames = list(paste0("r", 1:2), paste0("c", 1:3)))
matrix(1:12, nrow=3)    
matrix(1:12, nrow=3, byrow=T) 

mdat<-matrix(letters[1:4], nrow=2) # a matrix can be of character-type
rbind(mdat, paste0("new_r", 1:2))  # row-bind a vector to a matrix
mdat<-matrix(letters[1:4], nrow=2)
Mdat<-matrix(LETTERS[1:4], nrow=2)
cbind(mdat, Mdat)                  # column-bind two matrices
rbind(1:5, 6:7) 

x<-1:5; y<-6:7
max_length=max(length(x), length(y))
length(x)<-max_length; length(y)<-max_length  # x/y now same length
rbind(x, y)

mdat1<-matrix(c(1,1,2,3,1,2,1,2,1,1,2,2), nrow=4, 
              dimnames = list(paste0("r", 1:4), paste0("c", 1:3)))
mdat2<-matrix(c(1,2,3,4,1,1,2,2,1,2,1,2), nrow=4, 
              dimnames = list(paste0("r", 1:4), paste0("c", c(1,2,5))))
merge(mdat1, mdat2, all=F)
merge(mdat1, mdat2, all=TRUE)
merge(mdat1, mdat2, by="c2")                 # merge by column name
merge(mdat1, mdat2, by=c("c1", "c2"))        # Same as all = F
merge(mdat1, mdat2, by.x="c1", by.y="c2")    # when by is different for x & y
merge(mdat1, mdat2, by = "c1", all.x = TRUE) # Left join
merge(mdat1, mdat2, by = NULL)               # Outer join

Mdat<-matrix(LETTERS[1:6], nrow=3, 
             dimnames = list(paste0("r", 1:3), paste0("c", 1:2)))

str(Mdat)
dim(Mdat); nrow(Mdat); ncol(Mdat); length(Mdat) 
row.names(Mdat); colnames(Mdat)

mdat<-matrix(1:12, nrow = 3,       # Can assign row and col names
             dimnames = list(paste0("r", 1:3), paste0("c", 1:4)))
mdat[2, 1, drop=F] # row 2 and col 1; drop=F to keep the matrix structure
mdat[, 1:2]        # all rows; col 1 and 2 (blank means everything)
mdat[c(-2,-4), - c(1, 3)] # rows except 2 and 4; cols except 1 and 3
mdat[c("r1", "r3"), c("c2", "c4")]  # Must be a named matrix
mdat[c(T,F,T), c(F, T, T, F)] # any Boolean output (relational/logical 


olympic = rbind(
  USA=c(39, 41, 33, 113, 1, 1),
  China=c(38, 32, 18, 88, 2, 2),
  Japan=c(27, 14, 17, 58, 3, 5),
  GB=c(22, 21, 22, 65, 4, 4),
  ROC=c(20, 28, 23, 71, 5, 3),
  Netherlands=c(10, 12, 14, 36, 7, 9),
  France=c(10, 12, 11, 33, 8, 10))
colnames(olympic)<-c("gold", "silver", "bronze", 
                     "Total", "Rank_by_gold", "Rank_by_total")

olympic[olympic[, "gold"] > 30,]
olympic[olympic[, "gold"] > 30 & olympic[, "silver"]>40,]
sort(olympic[, "Rank_by_total"])            # Returns Value
order(olympic[, "Rank_by_total"])           # Returns order
olympic[order(olympic[, "Rank_by_total"]),]

mdat<-matrix(1:9, nrow=3)
mdat[mdat>5]<-999
mdat[mdat>5]<-c(1,2)
mdat<-matrix(1:9, nrow=3)
mdat[1,]<-999 
mdat<-matrix(1:9, nrow=3)
mdat[c(1,3), ]<-c(100, 200, 300)


mdat<-matrix(c(1,1, NA, 3, 3, 2, 4, NA, 4, 3, 3, 2), nrow=3)
mdat[is.na(mdat)]<-999
mdat[complete.cases(mdat), ]
mdat[complete.cases(mdat), , drop=F]

mdat[is.na(mdat)]<-c(NA,4) # in the prev. slide replaced with 999. But...
unique(mdat)               # row-wise operation (remove duplicated rows) 
mdat[!duplicated(mdat), ]  # Can also use the 'duplicated' function

t(unique(t(mdat)))        # transpose to remove duplicated columns

mdat                                      # dim(mdat);  3 4
row.names(mdat)                           # NULL; no row name assigned
colnames(mdat)                            # NULL; no column name either
row.names(mdat)<-c("r1", "r2", "r3")      # Assign row names
colnames(mdat)<-c("c1", "c2", "c3", "c4") # Assign column names

rbind(r1=1:3, r2=4:6, r3=7:9)
cbind(c1=1:3, c2=4:6, c3=7:9) 

long_mat<-matrix(1:1000, ncol=5)
head(long_mat, 3) 
summary(mdat)  
