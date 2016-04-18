// Generated by CoffeeScript 1.10.0
(function() {
  var browsersync, gulp, miniCSS, miniHTML, miniJS, nodemon, run;

  gulp = require('gulp');

  nodemon = require('gulp-nodemon');

  miniJS = require('gulp-uglify');

  miniCSS = require('gulp-minify-css');

  miniHTML = require('gulp-minify-html');

  browsersync = require('browser-sync');

  run = require('run-sequence');

  gulp.task('default', function(callback) {
    return run(['clean'], ['develop'], ['server', 'watch'], callback);
  });

  gulp.task('clean', function(callback) {
    console.log('this is clean task.............................');
    return callback();
  });

  gulp.task('minijs', function() {
    return console.log('this is minijs task.............................');
  });

  gulp.task('minicss', function() {
    return console.log('this is minicss task.............................');
  });

  gulp.task('minihtml', function() {
    return console.log('this is minihtml task.............................');
  });

  gulp.task('build', function(callback) {
    return run(['clean'], ['minijs', 'minicss', 'minihtml'], callback);
  });

  gulp.task('develop', function(callback) {
    nodemon({
      script: 'bin/www',
      ext: 'js ejs coffee scss html',
      task: ['build']
    });
    return callback();
  });

  gulp.task('server', function() {
    return browsersync({
      proxy: 'http://localhost:3000',
      port: 8800
    });
  });

  gulp.task('watch', function() {
    return gulp.watch(['./routes/**/*.*', './spiders/**/*.*', './views/**/*.*'], ['reload']);
  });

  gulp.task('reload', function(callback) {
    return run(['bsreload'], callback);
  });

  gulp.task('bsreload', function() {
    return browsersync.reload();
  });

}).call(this);
