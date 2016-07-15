express = require('express')
router = express.Router()

router.get('/', (req, res)->
  res.render('signup', {
    title: 'sai'
  })
)
router.post('/signup', (req, res)->
  console.log(req.body.tUser)
  console.log(req.body.temail)
  res.send(req.body)
)
module.exports = router
