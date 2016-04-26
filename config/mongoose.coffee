mongoose = require('mongoose')
config = require('./config')

module.exports = ()->
  db = mongoose.connect(config.mongodb)
  require('../models/users')
  require('../models/topics')
  return db
