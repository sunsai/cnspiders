mongoose = require('mongoose')
mongoose.connect('mongodb://192.168.13.1/cnodes')

dataSchema = new mongoose.Schema(
  user: {
    type: String
    exist: true
    trim: true
  }
)
User = mongoose.model('userdata', dataSchema)

superagent = require('superagent')
cheerio = require('cheerio')
async = require('async')
url = require('url')
BaseUrl = "https://cnodejs.org/"
TotalPage = 10
PageUrls = (url.resolve(BaseUrl, '?tab=all&page=' + page) for page in [1..TotalPage])
cns(PageUrls) if PageUrls.length > 0

cns = (pages)->
  async.mapLimit(pages, 2, (page, callback)->
    console.log('sipdering page:', page)
    superagent.get(page).end((err, res)->
      if err
        callback('spider err')
      else
        $ = cheerio.load(res.text)
        $('div.cell>a.user_avatar>img').each(->
          ut = new User(
            user: $(this).attr('title').trim()
          )
          ut.save((err)->
            if err
              callback('save err')
          )
        )
        callback(null, page + 'is spider ok!!!!')
    )
  , (err, result)->
    console.log(err)
    console.log(result)
  )
