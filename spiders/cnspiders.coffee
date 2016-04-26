superagent = require('superagent')
cheerio = require('cheerio')
sContent=require('./sContent')

spider = (page)->
  @page = page
spider.prototype = {
  getData: (response)->
    superagent.get(@page).end((err, res)->
      if err
        console.error(err)
      else
        console.log('the page is:'+@page)
        users = []
        topics = []
        $ = cheerio.load(res.text)
        $('#topic_list div.cell').each((idx, data)->
          $user = $(this).find('a').first()
          users.push(
            name: $user.find('img').attr('title').trim()
            img: $user.find('img').attr('src').trim()
            href: 'https://cnodejs.org' + $user.attr('href').trim()
          )
          $topic = $(this).find('div.topic_title_wrapper')
          topics.push(
            istop: $topic.find('span').first().text().trim()
            title: $topic.find('a.topic_title').attr('title').trim()
            href: 'https://cnodejs.org' + $topic.find('a.topic_title').attr('href').trim()
            replies: $(this).find('span.count_of_replies').text().trim()
            visits: $(this).find('span.count_of_visits').text().trim()
          )
        )
        console.log(users,topics)
#        response.send({
#          tilte: 'express'
#          data: {
#            users: users
#            topics: topics
#          }
#        })
    )
}
module.exports = spider
