express = require('express')
router = express.Router()
request = require('superagent')
cheerio = require('cheerio')
#mongoose = require('mongoose')

#User = mongoose.model('users')
BaseUlr = 'http://cnodejs.org/'
router.get('/', (req, res, next)->
  request.get(BaseUlr).end((err, cres)->
    if err
      return next(err)
    $ = cheerio.load(cres.text);
    tags = []
    $('a.topic-tab').each(()->
      tags.push({
        name: $(this).text().trim()
        href: $(this).attr('href')
      })
    )
    topics = []
    $('#topic_list div.cell').each(->
      $pt = $(this).find('div.topic_title_wrapper span').first()
      ptops = {
        class: if $pt.attr('class') then $pt.attr('class') else ''
        data: if $pt.text() then $pt.text().trim() else ''
      }

      topics.push({
        user: $(this).find('a.user_avatar img').attr('title').trim()
        userImg: $(this).find('a.user_avatar img').attr('src').trim()
        userUrl: BaseUlr + $(this).find('a.user_avatar').attr('href').trim()
        count_of_replies: $(this).find('span.count_of_replies').text().trim()
        count_seperator: $(this).find('span.count_seperator').text().trim()
        count_of_visits: $(this).find('span.count_of_visits').text().trim()
        last_time: $(this).find('span.last_active_time').text().trim()
        last_time_href: BaseUlr + $(this).find('a.last_time').attr('href') || ''
        last_time_img: $(this).find('a.last_time img').attr('src') || ''
        put_top: ptops
        topic_title: $(this).find('a.topic_title').attr('title').trim()
        topic_href: BaseUlr + $(this).find('a.topic_title').attr('href').trim()
      })
    );
#    res.send(topics)
    res.render('index', {
      title: 'sai'
      tags: tags
      topics: topics
    })
  )
)
module.exports = router
