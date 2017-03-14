library(rvest)
library(taskscheduleR)

## access old data
setwd("C:/Users/anujp_000/Dropbox/R Directory/Ebay/ebay")

searchterm<-'2016 Bowman Chrome'
updateFile<-'Bowman.csv'


old<-read.csv(updateFile)
old<-old[,c(2:4)]


##get data and append to old data
searchSold<-function(term){
  
  newterm<-gsub(' ','%20',term)
  
  url<-paste0('http://www.ebay.com/sch/i.html?_from=R40&_sacat=0&_nkw=', newterm, '&LH_Complete=1&LH_Sold=1&rt=nc&_trksid=p2045573.m1684')
  
  html<-read_html(url)
  
  items<-html_nodes(html, "h3.lvtitle")
  items<-html_text(items)
  
  prices<-html_nodes(html, ".bidsold")
  prices<-html_text(prices)
  
  soldwhen<-html_nodes(html, ".tme")
  soldwhen<-html_text(soldwhen)
  
  df <- data.frame(items, prices, soldwhen)
  
  df<-sapply(df, function(x) gsub("[\r\n\t]", "", x) )
  
  df<-data.frame(df)
  
  return (df)
}

new<-searchSold(searchterm)


full<-rbind(new, old)
full<-unique(full)

write.csv(full, updateFile)
