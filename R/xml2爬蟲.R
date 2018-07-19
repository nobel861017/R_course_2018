#用xml2爬美國中情局(CIA)的解密文件資料庫
query = 'Kennedy'    # keyword for query
pages = c(0,9,19)    # pages where you want to search

# basic CIA (CREST project) URL: 'https://www.cia.gov/library/readingroom/search/site/'
result.urls = paste('https://www.cia.gov/library/readingroom/search/site/', 
                    paste(query, paste('page=', pages, sep=''), sep='?'),  
                    sep='')
result.urls

require(xml2)
# 讀取url，將html頁面儲存成一個物件
html.page = read_html(url(result.urls[1]))
# 根據上圖的資訊，寫一個xpath
xpath = "//*[@class='search-results apachesolr_search-results']/li/h3/a" 
target = xml_find_all(html.page, xpath)
# 解密文件的「標題」
title = xml_text(target)
# 解密文件的「超連結」
download.url = unlist(xml_attr(target, "href"))
# 最後，將這頁的資訊儲存成一個data frame
page.info = data.frame(title=title, url=download.url, stringsAsFactors = F)
tail(page.info)
#page.info

html.page = read_html(url(result.urls[1]))

# find nodes which match the 'pattern' of xpath
xpath = "//*[@class='current-search-item current-search-item-text current-search-item-results']" 
target = xml_find_all(html.page, xpath)

# the result of search items
xml_text(target)

html.page = read_html(url(result.urls[1]))

# find nodes which match the 'pattern' of xpath
xpath = "//*[@class='pager-last last']/a"
target = xml_find_all(html.page, xpath)

# last page url
last.page.url = xml_attr(xml_find_all(html.page, xpath), "href")
last.page.url

strsplit(last.page.url, split="page=")[[1]][2]

