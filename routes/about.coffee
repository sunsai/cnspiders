express = require('express')
router = express.Router()

router.get('/', (req, res)->
  res.render('about', {
    title: 'sai'
  })
)
module.exports = router
