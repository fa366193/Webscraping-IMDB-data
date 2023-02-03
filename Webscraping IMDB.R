#Libraries needed
library(tidyverse)
library(plotly)
library(rvest)
library(XML)
library(xml2)

install.packages("rvest")
install.packages("XML")
install.packages("xml2")


## Webscraping##
# IMDB Top 250 Movies
url = "http://www.imdb.com/chart/top?ref_=nv_wl_img_3"

page = read_html(url)

movie.nodes <- html_nodes(page,'.titleColumn a')

movie.link = sapply(html_attrs(movie.nodes),`[[`,'href')
movie.link = paste0("http://www.imdb.com",movie.link)
movie.cast = sapply(html_attrs(movie.nodes),`[[`,'title')
movie.name = html_text(movie.nodes)

sec <- html_nodes(page,'.secondaryInfo')

year = as.numeric(gsub(")","",                         
                       gsub("\\(","",                 
                            html_text( sec )                 
                       )))

rating.nodes = html_nodes(page,'.imdbRating')

# Check One node
xmlTreeParse(rating.nodes[[20]])

rating.nodes = html_nodes(page,'.imdbRating strong')
votes = as.numeric(gsub(',','',
                        gsub(' user ratings','',
                             gsub('.*?based on ','',
                                  sapply(html_attrs(rating.nodes),`[[`,'title')
                             ))))

rating = as.numeric(html_text(rating.nodes))

top250 <- data.frame(movie.name, movie.cast, movie.link,year,votes,rating)

#Finding movies released between the year 2000 and 2001
ConditionalIMDB<-subset(top250,year >= 2000 & year <= 2001)
row.names(ConditionalIMDB) <- NULL

#Listing movies
ConditionalIMDB[c("movie.name","year")]










