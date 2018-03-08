library(dplyr)
library(tidyr)
library("tidyverse")

dir <- "~/Desktop/RStudio/Data_Wrangling_Excercise_1"
file <- "refine_original.csv"
file.output <- "refine_clean.csv"



# 0: Load the data in RStudio
refine.original <- read.csv(file.path(dir, file))

# 1: Clean up brand names
refine.clean <- refine.original
refine.clean$company <- gsub("AKZO","akzo",refine.clean$company)
refine.clean$company <- gsub("Akzo","akzo",refine.clean$company)
refine.clean$company <- gsub("akz0","akzo",refine.clean$company)
refine.clean$company <- gsub("ak zo","akzo",refine.clean$company)
refine.clean$company <- gsub("Phillips","philips",refine.clean$company)
refine.clean$company <- gsub("phillips","philips",refine.clean$company)
refine.clean$company <- gsub("phllips","philips",refine.clean$company)
refine.clean$company <- gsub("phllipS","philips",refine.clean$company)
refine.clean$company <- gsub("phillipS","philips",refine.clean$company)
refine.clean$company <- gsub("phlips","philips",refine.clean$company)
refine.clean$company <- gsub("Van Houten","van houten",refine.clean$company)
refine.clean$company <- gsub("van Houten","van houten",refine.clean$company)
refine.clean$company <- gsub("Unilever","unilever",refine.clean$company)
refine.clean$company <- gsub("unilver","unilever",refine.clean$company)
refine.clean$company <- gsub("phillps","philips",refine.clean$company)
refine.clean$company <- gsub("fillips","philips",refine.clean$company)

# 2: Separate product code and number
refine.clean <- separate(refine.clean, Product.code...number, c("product_code", "product_number"), sep = "-")

# 3: Add product categories
product_category <- refine.clean$product_code

refine.clean <- mutate(refine.clean, product_category)

refine.clean$product_category[refine.clean$product_category == "p"] <- "Smartphone"
refine.clean$product_category[refine.clean$product_category == "x"] <- "Laptop"
refine.clean$product_category[refine.clean$product_category == "v"] <- "Television"
refine.clean$product_category[refine.clean$product_category == "q"] <- "Tablet"

refine.clean <- refine.clean[,c(1,2,8,3,4,5,6,7)]

# 4: Add full address for geocoding
x <- refine.clean
x <- unite(x, full_address, c('address','city','country'), sep = ",")

# 5: 

x <- mutate(x, company_philips = ifelse(company=='philips',1,0))
x

write.csv(x, file = paste0(dir, "/", file.output), row.names = F)