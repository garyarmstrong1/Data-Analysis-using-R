# Sentimental Analysis using R

Lexicons are the sentimental database there are mainly three sentimental lexicons
- bing 
- afinn
- nrc

Depending upon the problem we need to choose the sentimental lexicon

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
 
 While the __bing__ lexicon classifies words into 2 sentiments, positive or negative, there are 10 sentiments conveyed in the __nrc__ lexicon.

A word like __and__ is neutral and unlikely to be included in a sentiment lexicon.

```
# geocoded_tweets has been pre-defined
geocoded_tweets

# Access bing lexicon: bing
bing <- get_sentiments("bing")

# Use data frame with text data
geocoded_tweets %>%
  # With inner join, implement sentiment analysis using `bing`
  inner_join(bing)
```

state   word             freq sentiment
   <chr>   <chr>           <dbl> <chr>    
 1 alabama abuse           7186. negative 
 2 alabama abused          3073. negative 
 3 alabama accomplish      5957. positive 
 4 alabama accomplished   13121. positive 
 5 alabama accomplishment  3036. positive 
 6 alabama accurate       28262. positive 
