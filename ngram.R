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
ovid_blogs <- Corpus(DirSource('dataset/blogs',encoding="UTF-8"),
               readerControl = list(reader = readPlain, language="english",load=TRUE))

ovid_news <- Corpus(DirSource('dataset/news',encoding="UTF-8"),
                     readerControl = list(reader = readPlain, language="english",load=TRUE))

ovid_twitter <- Corpus(DirSource('dataset/twitter',encoding="UTF-8"),
                    readerControl = list(reader = readPlain, language="english",load=TRUE))

print('Finished reading in data...')

# TBD: need to remove profanity

source('ngramfreq.R')

print('Creating 1-gram blog frequency table')
b1<-ngramfreq(ovid_blogs,1,1)

print('Creating 2-gram blog frequency table')
b2<-ngramfreq(ovid_blogs,2,2)

print('Creating 3-gram blog frequency table')
b3<-ngramfreq(ovid_blogs,3,3)


