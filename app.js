var express = require('express');
var path = require('path');
var favicon = require('serve-favicon');
var logger = require('morgan');
var cookieParser = require('cookie-parser');
var session = require('express-session')
var bodyParser = require('body-parser');
var glob = require('glob');
var config = require('./config/config');

var mongoose = require('mongoose');
mongoose.connect(config.mongodb);
var db = mongoose.connection;
db.on('error', function () {
    throw new Error('unable to connect to database at ' + config.mongodb);
});

var models = glob.sync('./models/*.js', {nodir: true});
// console.log('-------------------------------------')
// console.log(models);
models.forEach(function (model) {
    console.log(model);
    require(model);
});

// // 引入 mongoose 配置文件
// var mongoose = require('./config/mongoose');
// // 执行配置文件中的函数，以实现数据库的配置和 Model 的创建等
// var db = mongoose();
var app = express();

var env = process.env.NODE_ENV || 'development';
app.locals.ENV = env;
app.locals.ENV_DEVELOPMENT = env == 'development';

// view engine setup

app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');

// app.use(favicon(__dirname + '/public/img/favicon.ico'));
app.use(logger('dev'));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({
    extended: true
}));
app.use(cookieParser());
app.use(session({
    secret: '12345',
    // name: 'testapp',   //这里的name值得是cookie的name，默认cookie的name是：connect.sid
    cookie: {maxAge: 60 * 1000},  //设置maxAge是80000ms，即80s后session和相应的cookie失效过期
    resave: false,
    saveUninitialized: true,
}))
// req.locals.user = '';
app.use(function (req, res, next) {
    app.locals.user = req.session.user;
    next();
})
app.use(express.static(path.join(__dirname, 'public')));

var index = require(config.routes.path + config.routes.index);
app.use('/', index);
files = glob.sync(config.routes.path + '*.js', {nodir: true});
files.forEach(function (file) {
    var route = require(file);
    var filename = path.parse(file).name;
    app.use('/' + filename, route);
});


/// catch 404 and forward to error handler
app.use(function (req, res, next) {
    var err = new Error('Not Found');
    err.status = 404;
    next(err);
});

/// error handlers

// development error handler
// will print stacktrace

if (app.get('env') === 'development') {
    app.use(function (err, req, res, next) {
        res.status(err.status || 500);
        res.render('error', {
            message: err.message,
            error: err,
            title: 'error'
        });
    });
}

// production error handler
// no stacktraces leaked to user
app.use(function (err, req, res, next) {
    res.status(err.status || 500);
    res.render('error', {
        message: err.message,
        error: {},
        title: 'error'
    });
});


module.exports = app;
