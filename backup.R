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
ovid <- Corpus(DirSource('dataset',encoding="UTF-8"),
               readerControl = list(reader = readPlain, language="english",load=TRUE))
# convert to lower case
ovid <- tm_map(ovid,FUN=content_transformer(tolower))
# remove whitespace
ovid <- tm_map(ovid, FUN=stripWhitespace)
# stem the document
ovid <- tm_map(ovid,FUN=stemDocument)
# remove filler words that generate too many n-grams
ovid <- tm_map(ovid,FUN=removeWords, stopwords("english"))
# remove numbers
ovid <- tm_map(ovid, FUN=removeNumbers)
# remove punctuation
ovid <- tm_map(ovid, FUN=removePunctuation)

# TBD: need to remove profanity

# need to tokenize to find 2-gram and 3-gram
myTokenizer<- function(x) {
        NGramTokenizer(x,Weka_control(min=2,max=3))
}

dtm<-DocumentTermMatrix(ovid,control=list(tokenize=myTokenizer))

freqr<-as.matrix(dtm)
freqr<-t(freqr)
#write.csv(freqr,file="ngrams/ngrams.txt",fileEncoding="UTF-8")

# 1: 'blogs.txt' 2:'news.txt' 3:'twitter.txt'

names<-rownames(freqr)
blogs<-freqr[freqr[,1]!=0,1]

news<-freqr[freqr[,2]!=0,2]

twitter<-freqr[freqr[,3]!=0,3]


