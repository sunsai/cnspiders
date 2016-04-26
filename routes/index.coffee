express = require('express')
router = express.Router()
spider = require('../spiders/cnspiders')
superagent = require('superagent')
cheerio = require('cheerio')
url = require('url')
qs = require('querystring')
async = require('async')
#/* GET home page. */
BaseUrl = "https://cnodejs.org/"
router.get('/', (req, res)->
  totalPage = 10;
  superagent.get('https://cnodejs.org/').end((err, response)->
    if err
      console.error(err)
    else
      $ = cheerio.load(response.text)
      page = $('div.pagination ul li:last-child a').attr('href').trim()
#      totalPage = qs.parse(url.parse(page).query).page
      allPages = (url.resolve(BaseUrl,'?tab=all&page='+item) for item in[1...totalPage])
      async.mapLimit(allPages,2, (page, callback)->
        console.log('spider :'+page)
        setTimeout(()->
          console.log('begin:'+page)
          superagent.get(page).end((err,content)->
            if err
              callback(err)
            else
              $ = cheerio.load(content.text)
              users=[]
              $('#topic_list div.cell').each((idx, data)->
                $user = $(this).find('a').first()
                users.push(
                  name: $user.find('img').attr('title').trim()
                  img: $user.find('img').attr('src').trim()
                  href: 'https://cnodejs.org' + $user.attr('href').trim()
                )
              ))
        ,100)
      ,(err,result)->
        console.log(err)
        console.log(result)
      )
    )
)
module.exports = router
