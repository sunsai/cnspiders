superagent = require('superagent')
cheerio = require('cheerio')

spider = (page)->
  @page = page
spider.prototype ={
  getData: (response)->
    superagent.get(@page).end((err, res)->
      if err
        console.error(err)
      else
        $ = cheerio.load(res.text)
        $('#topic_list div.cell+a').each(->
          console.log($(this).attr('href'))
          console.log('================================')
        )
        response.send({
          tilte: 'express'
          data: ""
        })
    )
}
module.exports = spider
