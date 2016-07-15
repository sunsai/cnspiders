express = require('express')
router = express.Router()

router.get('/', (req, res)->
  res.render('getstart', {
    title: 'sai'
  })
)
module.exports = router
