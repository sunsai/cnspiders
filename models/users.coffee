mongoose = require('mongoose')

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
mongoose.model('users', UserSchema)
