# Sentimental Analysis using R

Lexicons are the sentimental database there are mainly three sentiment lexicons
- bing 
- afinn
- nrc

```
# Load dplyr and tidytext
library("dplyr")
library("tidytext")

# Choose the bing lexicon
get_sentiments("bing")

# Choose the nrc lexicon
get_sentiments("nrc") %>%
  count(sentiment) # Count words by sentiment
 ```
 
 
