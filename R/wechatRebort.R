#' send a test message using qiye Wechat
#'
#' @param webhook an api link from Qiye wechat
#' @param content a string
#' @param mentioned_list a list type
#'
#' @return a respose type
#'
#' @export
#'
#' @examples
#' webhook <- "https://qyapi.weixin.qq.com/cgi-bin/webhook/send?key=XXXXXXXXXXX"
#' response <- sendText(webhook,"hello world!")
#'
#' response <- sendText(webhook,"hello world!",list("someone","@all"))
#'
sendText <- function(webhook,content,mentioned_list = NULL){
  if (is.null(mentioned_list) | is.list(mentioned_list)){
    post_body <- list('msgtype' = 'text',
                      'text' = list('content' = content,
                                    'mentioned_list' = mentioned_list))

    message <- httr::POST(
      url = webhook,
      httr::add_headers('Content-Type' = 'application/json'),
      encode = 'json',
      body = post_body
    )
  }else{
    stop("mentioned_list argument must be a list or takes NULL")
  }
}

#' Send Makrdown Message using Qiye Wechat
#'
#' @param webhook  an api link from Qiye wechat
#' @param markdown a string with markdown
#'
#' @return a respose type
#'
#' @export
#'
#' @note see https://work.weixin.qq.com/api/doc/90000/90136/91770 for more infomation about
#' supported markdown languages
#'
#' @examples
#' webhook <-  "https://qyapi.weixin.qq.com/cgi-bin/webhook/send?key=XXXXXXXXXXX"
#' markdown <- paste0('实时新增用户反馈<font color=\"warning\">132例</font>，请相关同事注意。
#' > 类型:<font color=\"comment\">用户反馈</font>
#' > 普通用户反馈:<font color=\"comment\">117例</font>
#' > VIP用户反馈:<font color=\"comment\">15例</font>')
#' response <- sendMarkdown(webhook, markdown)

sendMarkdown <- function(webhook, markdown){
  post_body <- list("msgtype" = "markdown",
                    "markdown" = list("content" = markdown)
  )

  message <- httr::POST(
    url = webhook,
    httr::add_headers('Content-Type' = 'application/json'),
    encode = 'json',
    body = post_body
  )
}

#' Send Images Using Qiye Wechat
#'
#' @param webhook  an api link from Qiye wechat
#' @param image_filepath the filepath of the image
#'
#' @return a respose type
#' @export
#'
#' @note
#'webhook <-  "https://qyapi.weixin.qq.com/cgi-bin/webhook/send?key=XXXXXXXXXXX"
#' sendImages(webhook,"full file path")
sendImages <- function(webhook, image_filepath){
  image_md5sum <- tools::md5sum(image_filepath)

  # calculate base 64
  image_base64 <- base64enc::base64encode(image_filepath)


  post_body <- list('msgtype' = 'image',
                    'image' = list('base64' = image_base64,
                                   "md5"=  image_md5sum))

  message <- httr::POST(
    url = webhook,
    httr::add_headers('Content-Type' = 'application/json'),
    encode = 'json',
    body = post_body
  )
}

#' Create an article for the news type messages
#'
#' @param title The new title
#' @param discription The discription of the news
#' @param url a url for the message
#' @param picurl a picture url
#'
#' @return an article list
#' @export
#'
#' @examples
#' article <- article(title = "中秋节礼品领取",
#' discription =  "今年中秋节公司有豪礼相送",
#' url = "www.qq.com",
#' picurl = "some url")
article <- function(title, discription, url, picurl=NULL){
  list("title" = title,
       "description" = discription,
       "url" = url,
       "picurl" = picurl)
}

#' Send articles using Qiye Wechat
#'
#' @param webhook  an api link from Qiye wechat
#' @param articles a list of articles to send
#'
#' @return a response type
#' @export
#'
#' @examples
#' webhook <-  "https://qyapi.weixin.qq.com/cgi-bin/webhook/send?key=XXXXXXXXXXX"
#' article_1 <- article(title = "中秋节礼品领取",
#' discription =  "今年中秋节公司有豪礼相送",
#' url = "www.qq.com")
#' article_2 <- article(title = "中秋节礼品领取",
#' discription =  "今年中秋节公司有豪礼相送",
#' url = "www.qq.com")
#' articles <- list(article_1,article_2)
#' sendNews(webhook = webhook, articles = articles)
sendNews <- function(webhook,articles){
  post_body <- list("msgtype" = "news",
                    "news" = list("articles" = articles))
  message <- httr::POST(
    url = webhook,
    httr::add_headers('Content-Type' = 'application/json'),
    encode = 'json',
    body = post_body
  )
}
