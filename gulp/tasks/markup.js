var path = require('path');
var gulp = require('gulp');
var config = require('../config');
var browserSync = require('browser-sync');
var swig = require('gulp-swig');
var data = require('gulp-data');

var getJsonData = function(file) {
  if (path.extname(file.path) === '.html') {
    var dir = '../.' + config.templates.src;
    var fileName = path.basename(file.path, '.html') + '.json';
    return require(dir + fileName);
  }
};

gulp.task('markup', function() {
  return gulp.src(config.markup.src)
    .pipe(data(getJsonData))
    .pipe(swig())
    .pipe(gulp.dest(config.markup.dest))
    .pipe(browserSync.reload({
      stream: true
    }));
});
