mongoose = require('mongoose')

TopicSchema = new mongoose.Schema(
  istop: String
  title: String
  href: String
  replies: String
  visits: String
)
mongoose.model('topics', TopicSchema)
