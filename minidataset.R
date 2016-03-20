
setwd("/users/alg/jhu/capstone")
source("randomSubset.R")

randomSubset("final/en_US/en_US.blogs.txt","dataset/blogs/blogs.txt")
randomSubset("final/en_US/en_US.news.txt","dataset/news/news.txt")
randomSubset("final/en_US/en_US.twitter.txt","dataset/twitter/twitter.txt")

