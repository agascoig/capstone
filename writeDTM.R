
writeDTM <- function(aa) {
        for (j in 1:aa$nrow) {
                freqr<-as.matrix(aa)
                freqr<-t(freqr)
                write.csv(freqr,file=paste("ngrams/",aa$dimnames$Docs[j],sep=""),fileEncoding="UTF-8")
        }
}