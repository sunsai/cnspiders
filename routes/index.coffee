express = require('express')
router = express.Router()
mongoose = require('mongoose')

User = mongoose.model('users')

router.get('/', (req, res)->
  u1 = new User(
    name: 'klausgao'
  )
  u1.findByname((err, docs)->
    if err
      console.log(err)
      return
    res.send(
      title: 'cnnode'
      data: docs
    )
  )
)
module.exports = router
