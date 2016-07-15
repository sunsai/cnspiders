mongoose = require('mongoose')

UserSchema = new mongoose.Schema(
  name: {
    type: String
    exist: true
  }
  href: String
  img: String
)
UserSchema.statics.findOneByname = (name, callback)->
  return this.findOne({name: name}, callback)
mongoose.model('users', UserSchema)
