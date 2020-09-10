# WechatRobert
使用腾讯企业微信机器人发送信息
```
# 从github下载WechatRobert
install.packages("devtools")
library(devtools)
install_github("rayruilinwang/qiyeWechatRobert")
```
## 1.使用本包发送文本信息
```
webhook <- "api-key"
sendText(webhook, content, mentioned_list = NULL)
```
## 2.使用本包发送文本信息并@对应人
```
sendText(webhook,"hello world!",list("someone","@all")
```
## 3. 发送markdown文本
[支持的markdown文本参见本链接](https://work.weixin.qq.com/api/doc/90000/90136/91770)
```
markdown <- paste0('实时新增用户反馈<font color=\"warning\">132例</font>，请相关同事注意。
> 类型:<font color=\"comment\">用户反馈</font>
> 普通用户反馈:<font color=\"comment\">117例</font>
> VIP用户反馈:<font color=\"comment\">15例</font>')
response <- sendMarkdown(webhook, markdown)
```
## 4. 发送图片
```
sendImages(webhook,"full file path")
```
## 5. 发送新闻类型推送
```
# 创建新闻文章
article <- article(title = "中秋节礼品领取",
discription =  "今年中秋节公司有豪礼相送",
url = "www.qq.com",
picurl = "some url")

webhook <-  "https://qyapi.weixin.qq.com/cgi-bin/webhook/send?key=XXXXXXXXXXX"

article_1 <- article(title = "中秋节礼品领取",
discription =  "今年中秋节公司有豪礼相送",
url = "www.qq.com")

article_2 <- article(title = "中秋节礼品领取",
discription =  "今年中秋节公司有豪礼相送",
url = "www.qq.com")

# 进行新闻文章的推送
articles <- list(article_1,article_2)
sendNews(webhook = webhook, articles = articles)
```
