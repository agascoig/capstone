#
# Alex Gascoigne
# 3/18/2016
# Do basic data analysis for Coursera Data Science Capstone project.

require(tm)
require(RWeka)
require(SnowballC)

# avoid brain damage in RWeka: this is necessary or DocumentTermMatrix call fails
options(mc.cores=1)

setwd('/users/alg/jhu/capstone')

if (!file.exists("dataset"))
   source("minidataset.R")

# read in the data
ovid <- Corpus(DirSource('dataset'),
               readerControl = list(reader = readPlain, language="english",load=TRUE))
# convert to lower case
ovid <- tm_map(ovid,FUN=content_transformer(tolower))
# remove whitespace
ovid <- tm_map(ovid, FUN=stripWhitespace)
# stem the document
ovid <- tm_map(ovid,FUN=stemDocument)
# remove filler words that generate too many n-grams
ovid <- tm_map(ovid,FUN=removeWords, stopwords("english"))

# TBD: need to remove profanity

# need to tokenize: identify words, punctuation, and numbers
myTokenizer<- function(x) {
        NGramTokenizer(x,Weka_control(min=2,max=3))
}

dtm<-DocumentTermMatrix(ovid,control=list(tokenize=myTokenizer))

# now find 3-grams that appear at least 5 times
three_gram<-findFreqTerms(dtm,lowfreq=5,highfreq=Inf)
