express = require('express')
mongoose = require('mongoose')
User = mongoose.model('users')
router = express.Router();
eventProxy = require('eventproxy')

router.get('/', (req, res)->
  res.render('signin', {
    title: 'sai'
    errinfo: ''
    success: ''
  })
)
router.post('/', (req, res)->
  console.log('======================')
  console.log(req.body)
  tUser = req.body.tUser
  tPass = req.body.tPass

  ep = new eventProxy()
  ep.on('errinfo', (msg)->
    res.status(422);
    res.render('signin', {
      title: 'sai'
      errinfo: msg
      success: ''
    })
  )
  if tUser is ''
    ep.emit('errinfo', '用户名不能为空！')
    return
  if tPass is ''
    ep.emit('errinfo', '密码不能为空！')
    return

  User.findOneByname(tUser, (err, user)->
    if err
      ep.emit('errinfo', '获取信息失败')
      return
    req.session.user = user;
    res.render('signin', {
      title: 'sai'
      errinfo: ''
      success: '登录成功！'
    })
  )
)
module.exports = router
