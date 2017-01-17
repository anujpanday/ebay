library(rvest)
html <- read_html("http://www.ebay.com/sch/i.html?_from=R40&_sacat=0&LH_Complete=1&LH_Sold=1&_nkw=2016+bowman+chrome&_ipg=200&rt=nc")
items<-html_nodes(html, "h3.lvtitle")

items<-html_text(items)
items[6]
