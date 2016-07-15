express = require('express')
router = express.Router()

router.get('/', (req, res)->
  res.render('api', {
    title: 'sai'
  })
)
module.exports = router
