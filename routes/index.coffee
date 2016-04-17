express = require('express')
router = express.Router()
spider = require('../spiders/cnspiders')
#/* GET home page. */

router.get('/', (req, res)->
  sp = new spider('https://cnodejs.org/')
  sp.getData(res)
)

module.exports = router;
