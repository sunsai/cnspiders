gulp = require('gulp')
nodemon = require('gulp-nodemon')
miniJS =require('gulp-uglify')
miniCSS =require('gulp-minify-css')
miniHTML =require('gulp-minify-html')
browsersync = require('browser-sync')
run = require('run-sequence')

gulp.task('default', (callback)->
  run(['clean'],['develop'],['server','watch'],callback)
);
gulp.task('clean',(callback)->
  console.log('this is clean task.............................')
  callback()
)
gulp.task('minijs',()->
  console.log('this is minijs task.............................')
)
gulp.task('minicss',()->
  console.log('this is minicss task.............................')
)
gulp.task('minihtml',()->
  console.log('this is minihtml task.............................')
)
gulp.task('build',(callback)->
  run(['clean'],['minijs','minicss','minihtml'],callback)
)
gulp.task('develop', (callback)->
  nodemon({
    script: 'bin/www',
    ext: 'js ejs coffee scss html',
    task:['build']
  })
  callback()
)
gulp.task('server',()->
  browsersync({
    proxy: 'http://localhost:3000'
    port: 8800
  })
)
gulp.task('watch', ()->
  gulp.watch(['./routes/**/*.*','./spiders/**/*.*','./views/**/*.*'], ['reload'])
)
gulp.task('reload',(callback)->
  run(['bsreload'],callback)
)
gulp.task('bsreload',->
  browsersync.reload()
)


