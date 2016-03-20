#
# Create a smaller data set for Coursera Capstone Project
#


randomSubset <- function(infile, outfile) {
   con<-file(infile,"r",encoding="UTF-8")
   lines<-readLines(con,n=-1,warn=FALSE,skipNul=TRUE)
   close(con)
   b<-rbinom(length(lines),1,0.05)
  
   s<-lines[b!=0]
   
   con<-file(outfile,"a+",encoding="UTF-8")
   
   writeLines(s,con,sep="\n")
   close(con)
}
