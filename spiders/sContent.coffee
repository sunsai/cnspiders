superagent = require('superagent')
cheerio = require('cheerio')

sContent = (page)->
  @page = page
sContent.prototype = {
  getData: (response)->
    superagent.get(@page).end((err, res)->
      if err
        console.error(err)
      else
        $ = cheerio.load(res.text)
        
        response.send({
          picID:''
          picContent:''
        })
    )
}
module.exports = sContent
