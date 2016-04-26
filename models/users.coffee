mongoose = require('mongoose')

UserSchema = new mongoose.Schema(
  name: String
  href: String
  img:String
)
mongoose.model('users', UserSchema)
