
ngramfreq <- function(ovid,amin,bmin) {
        
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
        
        myTokenizer<- function(x) {
                NGramTokenizer(x,Weka_control(min=amin,max=bmin))
        }
        
        dtm<-DocumentTermMatrix(ovid,control=list(tokenize=myTokenizer))
        
        # Pain: Why bother to have a sparse matrix, if you just end up converting to
        # a regular matrix?
        
        freqr<-as.matrix(dtm)
        freqr<-t(freqr)
        
        blogs<-subset(freqr,freqr[,1]!=0,select=1)
        blogs<-blogs[order(blogs,decreasing=TRUE),]
        b<-data.frame(x=names(blogs),y=blogs)
        
        return(b)
}