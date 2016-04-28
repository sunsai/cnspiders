mongoose = require('mongoose')
mongoose.connect('mongodb://192.168.13.1/cnodes')

_ = require('lodash')
UserSchema = new mongoose.Schema(
  name: {
    type: String
    exist: true
    trim: true
  }
  href: String
  img: String
)
UserSchema.methods.findByname = (callback)->
  return this.model('users').find({name: this.name}, callback)
User = mongoose.model('users', UserSchema)

