express = require('express')
router = express.Router()
superagent = require('superagent')
cheerio = require('cheerio')
async = require('async')
url = require('url')
qs = require('querystring')

mongoose = require('mongoose')
User = mongoose.model('users')
Topic = mongoose.model('topics')

BaseUrl = "https://cnodejs.org/"
TotalPage = 1
PageUrls = []
users = []
router.get('/', (req, res, next)->
  superagent.get(BaseUrl).end((err, rest)->
    if err
      console.error(err)
      next(err)
    $ = cheerio.load(rest.text)
    TotalPage = qs.parse(url.parse($('div.pagination ul li:last-child a').attr('href')).query).page
    PageUrls = (url.resolve(BaseUrl, '/?tab=all&page=' + page) for page in [1..TotalPage])
    cnSpiders(PageUrls) if PageUrls.length > 0
    res.send(
      title: 'sai'
      TotalPage: TotalPage
      PageUrlsL: PageUrls
    )
  )
)
cnSpiders = (pageurls)->
  async.mapLimit(PageUrls, 10, (page, callback)->
    console.log('starting sipder page:', page)
    superagent.get(page).end((err, pageText)->
      if err
        console.log(page, 'spider err')
        callback('err')
      else
        $page = cheerio.load(pageText.text)
        $page('div.cell').each(->
          $user = $(this).find('a.user_avatar')
          users.push(
            name: $user.find('img').attr('title').trim()
            href: url.resolve(BaseUrl, $user.attr('href').trim())
            img: $user.find('img').attr('src').trim()
          )
          ut = new User(
            name: $user.find('img').attr('title')
            href: url.resolve(BaseUrl, $user.attr('href').trim())
            img: $user.find('img').attr('src').trim()
          )
          ut.save((err)->
            callback('ut save err') if err
          )
          tp = new Topic(
            istop: $(this).find('div.topic_title_wrapper>span').first().text()
            title: $(this).find('a.topic_title').attr('title').trim()
            href: url.resolve(BaseUrl, $(this).find('a.topic_title').attr('href').trim())
            replies: $(this).find('span.count_of_replies').text().trim()
            visits: $(this).find('span.count_of_visits').text().trim()
          )
          tp.save((err)->
            callback('tp save err') if err
          )
        )
        callback(null, page + 'is spidering ok')
    )
  , (err, result)->
    console.log(err)
    console.log(users.length) if users.length > 0
    console.log(users) if users.length > 0
    console.log(result)
  )
module.exports = router
