Waterline = require('waterline')
mysqladapter = require('sails-mysql');
mongoadapter = require('sails-mongo')

adapters = {
  mongo: mongoadapter
  mysql: mysqladaper
  default: mongo
}
connects = {
  mongo: {
    adapter: 'mongo'
    url: 'mongodb://192.168.13.1/cnodes'
  },
  mysql: {
    adapter: 'mysql'
    url: 'mysql://root:sunsasi@192.168.13.1/cnodes'
  }
}

User = Waterline.Collection.extend(
  identity: 'users'
  connection: 'default'
  attributes:
    name: 'string'
    href: 'string'
    img: 'string'
)
