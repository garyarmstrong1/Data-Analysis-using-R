rm(list = ls()); gc()
########Packages Installation############
install.packages("stringr")
install.packages("imager")
install.packages("abind")
install.packages("magritter")
install.packages("plyr")
install.packages("tidyverse")
install.packages("grid")



#########Loading Libraries##############
library(tidyverse)
library(stringr)
library(imager)
library(abind)
library(grid)


########Function Definition##########
drawImageWithText <- function(img, text, thresh, fontSize = 10,
                              fileName = "myfile.png",
                              resize = TRUE, saveToDisk = FALSE) {
##############Data Cleaning Operations###########
text <- paste(text, collapse = " ")
text <- str_replace_all(text, "\n+", " ")
text <- str_replace_all(text, " +", " ")
text <- str_split(text, "")[[1]]
# RESIZING THE IMAGE FILE TO 700*500 RESOLUTION
if (resize) img <- resize(img, 700, 500)
# CONVERTING THE IMAGE INTO GRAYSCALE AS AN ARRAY/MATRIX
imgGSMat <- img %>% grayscale %>% as.matrix %>% t()
# DEFINING THE FAT CHARACTERS (TAKING MORE SPACE)
fatChars <- c(LETTERS[-which(LETTERS == "I")], "m", "w", "@")
# DEFINING THE SKINNY CHARACTERS (TAKING LESS SPACE)
skinnyChars <- c("l", "I", "i", "t", "'", "f")
# PARAMETERS FOR STORING THE IMAGE ON HDD
if (saveToDisk) png(fileName, width(img), height(img))
grid.newpage()
# PIXEL COUNTER
counter <- 0
# ITERATING THROUGH THE ROWS OF THE IMAGE PIXEL MATRIX
for (i in seq(1, nrow(imgGSMat) - fontSize, fontSize + floor(fontSize / 3))) {
  # ITERATING THROUGH THE COLUMNS OF THE IMAGE PIXEL MATRIX
  for (j in seq(1, ncol(imgGSMat) - fontSize, fontSize)) {
    # IF THE PIXEL INTENSITY IS GREATER THAN THRESHOLD
    if (imgGSMat[i, j] < thresh) {
      counter <- ifelse(counter < length(text), counter + 1, 1)
      beforeLastChar <- ifelse(counter > 2, lastChar, " ")
      lastChar <- ifelse(counter > 1, char, " ")
      char <- text[counter]
      # PLOTTING THE ACTUAL CHARACTER
      grid.text(char,
                x = 0.01 + j/ncol(imgGSMat) +
                  0.004 * (lastChar %in% fatChars) -
                  0.003 * (lastChar %in% skinnyChars) +
                  0.003 * (beforeLastChar %in% fatChars) -
                  0.002 * (beforeLastChar %in% skinnyChars),
                y = 1 - i / nrow(imgGSMat) - 0.01,
                gp = gpar(fontsize = fontSize),
                just = "left")
    }
  }
}
# SAVING TO HDD IS KEPT OFF
if (saveToDisk) dev.off()
}

# LOADING THE INPUT IMAGE
img <- load.image ("C:\\Users\\SANTOSHSRINIVAS\\Desktop\\R programming\\image processing\\Santosh.jpg")


# LOADING THE INPUT STRING
text <- readLines("C:\\Users\\SANTOSHSRINIVAS\\Desktop\\R programming\\image processing\\speech.txt")

# CALLING FUNCTION TO REPLACE PIXELS WITH CHARACTERS
drawImageWithText(img, text, thresh = 0.40, fontSize = 4) 
