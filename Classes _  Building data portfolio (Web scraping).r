# -*- coding: utf-8 -*-

# -- IMDB --

# # **Mini Project 01 -IMDB web scraping**


library(tidyverse)
library(rvest)

url = "https://www.imdb.com/search/title/?groups=top_100&sort=user_rating,desc"

# read html
imdb <- read_html(url)
imdb

title <- imdb %>%
    html_nodes("h3.lister-item-header") %>%
    html_text2()

title[1:10]

rating <- imdb %>%
    html_nodes("div.ratings-imdb-rating") %>%
    html_text2() %>%
    as.numeric

rating[1:10]

num_votes <- imdb %>%
    html_nodes("p.sort-num_votes-visible") %>%
    html_text2()

    ## build a dataset
df<- data.frame(
    title = title,
    rating = rating,
    num_votes = num_votes
)

head(df)

# -- SpecPhone --

# # **Mini Project 02 - Specphone Phone Database**


url <- read_html("https://specphone.com/Samsung-Galaxy-A04.html")

att <- url %>%
    html_nodes("div.topic") %>%
    html_text2()

value <- url %>%
    html_nodes("div.detail") %>%
    html_text2()

data.frame(attrubite = att, value = value)

# All samsung smartphone
samsung_url <- read_html("https://specphone.com/brand/Samsung")

links <- samsung_url %>%
    html_nodes("li.mobile-brand-item a") %>%
    html_attr("href")

links

full_links <-paste0("https://specphone.com",links)

result <- data.frame()

for (link in full_links[1:5]){
    ss_topic <- link %>%
        read_html() %>%
        html_nodes("div.topic") %>%
        html_text2()

    ss_detail <- link %>%
        read_html() %>%
        html_nodes("div.detail") %>%
        html_text2()
    
    tmp <- data.frame(attribute = ss_topic,
                    value = ss_detail)

    result <- bind_rows(result,tmp)
    print("progress...")
}

##print(result)

print(head(result),3)

## wirte CSV
write_csv(result,"result_ss_phone.csv")

