express = require('express')
router = express.Router()

router.get('/', (req, res)->
  res.render('signin', {
    title: 'sai'
  })
)
module.exports = router
