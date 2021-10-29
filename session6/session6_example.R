
  
  
## String Manipulation in R | String Basics -- How to create a string?

"This is a string"
'This is also a string'
'Single quote string with "double quote" inside'
"Double quote string with 'single quote' inside"

# Convert to characters
as.chracter()
# is.character() # to check the type

# Cases
toupper("change this to uppercase letters")
tolower("CHANGE THIS TO LOWERCASE LETTERS")

# Size of a character vector
chr <- "Hello World"; length(chr); nchar(chr)

# Combining Strings 
paste("1st", "2nd", "3rd", sep = ", ")
paste(c("1st", "2nd", "3rd"), collapse = ", ")
# paste() vs. paste0() -- The default sep arg is different
paste("a", "b", "c")         # sep=" "
paste0("a", "b", "c")        # sep=""


# your Turn!
# 1. Use the `Yelp.com` url address
# 2. There are 24 restaurant information pages -- 10 reviews per page
# 3. Create a list of 24 URL addresses

url = "https://www.yelp.com/search?find_desc=Restaurants&find_loc=Gainesville%2C%20FL&ns=1&start="

# Hint
# Create a sequence of numbers<br>
# Use `paste0()` to concatenate numbers to the address

# How to split a string
chr <- "alpha, bravo, charlie"
strsplit(chr, ", ")  # Returns a list

# How to identify the location of a pattern
gregexpr("a", "banana")
regexpr("a", "banana") # Returns only the first location

# How to extract substrings
substring("garbage important trash special", c(9, 25), c(17, 31))
substring(c(
  "garbage important trash",
  "garbage special trash"),
  first=9, last=c(17, 15))


# your Turn!
# Extract "alpha", "bravo", "charlie", "delta", "echo" from
# Output: c("alpha", "bravo", "charlie", "delta", "echo")

chr="alpha, bravo, charlie, delta, echo"



# grep Syntax
# grep(pattern, string/string vector,
#      Value=T, # for rep and grep
#      ignore.cases=F, perl=F, ...)
# Example
chr <- c("I am learning", "How to handle characters")
# Return Index
grep("i", chr, ignore.case = T)
# Return value
grep("i", chr, ignore.case = T, value = T)
# Return Boolean
grepl("i", chr, ignore.case = T)

# gsub Syntax
# gsub(pattern, replacement, string/string vector, 
#      ignore.cases=F, perl=F, ...)
# Example
chr <- c("bananA", "smoothie")
gsub("a", "i", chr, ignore.case = T) # replaces all
sub("a", "i", chr, ignore.case = T)  # replaces only the first


# Regex
# Example: Remove Numbers
chr <- "RWorkshop2021@ufl.edu"
gsub("[[:digit:]]", "",chr)
gsub("\\d", "",chr)
gsub("[0-9]", "",chr)

# Example: Alphabet
gsub("[[:alpha:]]", "",chr)
gsub("[A-Za-z]", "",chr)

# Example
gsub("[a-c]", "", "banan.")
gsub("[^a-c]", "", "banan")
gsub("a.", "", "banana")

# example
gsub(".", "", "...banana", perl=T)  # Need to Escape!
gsub("\\.", "", "...banana", perl=T)

# Example
chr=c("ggle", "gogle", "google", "gooogle", "goooogle")
grep("go?gle", chr, value=T)
grep("go*gle", chr, value=T)
grep("go+gle", chr, value=T)
grep("go{2,}gle", chr, value=T)
grep("go{1,3}gle", chr, value=T)

# Example
gsub("a", "A", "An anaconda living in the amazon area")
gsub("^a", "A", "An anaconda living in the amazon area")
gsub("a$", "A", "An anaconda living in the amazon area")
gsub("\\<a", "A", "An anaconda living in the amazon area")
gsub("a\\>", "A", "An anaconda living in the amazon area")
gsub("\\ba", "A", "An anaconda living in the amazon area")
gsub("\\Ba", "A", "An anaconda living in the amazon area")

# Example
grep("ise", c("summarize", "summarise"), value=T)
grep("i(s|z)e", c("summarize", "summarise"), value=T)
gsub(".* (.*) but.*","\\1","I what \"this\" but not that")
gsub("\\s{2,}", " ", "  please   remove empty   whitespaces  ")
gsub("^ +| +$", "", "  please   remove empty   whitespaces  ")  # trimws()
cat("This is line1\nThis is line2\n\tThis is a tab")


# Your Turn!
# Is this a valid price?
# Only return $100, $10.7, $.99
is_price=c("$100", "$10.7", "$.99", "10", "$7,77", "$9.999")

# Return 4.99
chr = "I've bought 6-pack beer on sale for 4.99 dollars"


# Your Turn! Amazon Data
# Read the data
df<-read.csv("data/thermostat_amazon.csv", stringsAsFactors = F)

# Change the "star" column to integer value only
# Create three columns --  "year", "month", "day"
# Create a new column "verified" -- Assign 1 if column "info_2" contains "Verified Purchase" and 0 o.w.

unique(df$info_2)
table(df$info_2)
df$verified=ifelse(grepl("Verified Purchase",df$info_2),1,0)

# Remove punctuations that repeated more than 2 consecutive times
df$info_3[2]; df$info_3[4]; df$info_3[8]; 

# Remove All punctuations