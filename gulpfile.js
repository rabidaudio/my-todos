var gulp = require('gulp');
var del = require('del');
var swank = require('swank');
var gulpif = require('gulp-if');
var autoprefixer = require('gulp-autoprefixer');
var jade = require('gulp-jade');
var sass = require('gulp-sass');
var rename = require('gulp-rename');
var uglify = require('gulp-uglify');
var sourcemaps = require('gulp-sourcemaps');
var browserify = require('browserify');
var coffeeify = require('coffeeify');
var hbsfy = require('hbsfy');
var source = require('vinyl-source-stream');
var buffer = require('vinyl-buffer');
var gutil = require('gulp-util');
var mocha = require('gulp-mocha');
var mochaPhantomJS = require('gulp-mocha-phantomjs');

require('coffee-script/register')

var development = (process.env['NODE_ENV'] !== 'production'); // set this env var in prod


var paths = {
  out_path: 'dist',
  styles: {
    main: 'styles/main.scss',
    all: 'styles/**/*.scss',
    dest: 'dist/css/'
  },
  scripts:{
    main: 'scripts/main.coffee',
    all: ['scripts/**/*.coffee', 'scripts/**/*.hbs', 'scripts/**/*.js'],
    dest: 'dist/js/'
  },
  pages:{
    main: 'index.jade',
    dest: 'dist/',
    all: 'index.jade',
    destclean: ['dist/*.html', 'dist/!(vendor)/**/*.html']
  },
  bower:{
    src: 'bower_components/**/*',
    dest: 'dist/vendor'
  }
};

/********** CLEAN **********/
gulp.task('clean:scripts', function(cb) {
  del(paths.scripts.dest, cb);
});
gulp.task('clean:styles', function(cb) {
  del(paths.styles.dest, cb);
});
gulp.task('clean:pages', function(cb) {
  del(paths.pages.destclean, cb);
});
gulp.task('clean:bower', function(cb) {
  del(paths.bower.dest, cb);
});

gulp.task('clean:all', function(cb) {
  del([paths.out_path+'/**/*', '!'+paths.out_path+'/.gitkeep'], cb);
});


/********** BUILD **********/
gulp.task('scripts', ['clean:scripts'], function () {
  var b = browserify({
    entries: './'+paths.scripts.main,
    debug: development,
    // defining transforms here will avoid crashing your stream
    transform: [coffeeify, hbsfy],
    extensions: ['.coffee', '.hbs']
  });
  return b.bundle()
    .pipe(source('app.js'))
    .pipe(buffer())
    .pipe(gulpif(development, sourcemaps.init({loadMaps: true})))
    // Add transformation tasks to the pipeline here.
    .pipe(gulpif(!development, uglify()))
    .on('error', gutil.log)
    .pipe(gulpif(development, sourcemaps.write('./')))
    .pipe(gulp.dest(paths.scripts.dest));
});

gulp.task('styles', ['clean:styles'], function () {
    gulp.src(paths.styles.main)
      .pipe(gulpif(development, sourcemaps.init())) //sourcemaps only if in development mode
      .pipe(sass()) //compile sass
      .pipe(autoprefixer()) //add vendor prefixes
      .pipe(gulpif(development, sourcemaps.write()))
      .pipe(gulp.dest(paths.styles.dest));
});

gulp.task('pages', ['clean:pages'], function (){
  gulp.src(paths.pages.main)
    .pipe(jade())
    .pipe(gulp.dest(paths.pages.dest));
});

gulp.task('bower', ['clean:bower'], function (){
  gulp.src(paths.bower.src).pipe(gulp.dest(paths.bower.dest)); //copy all
});

/********* TEST **********/
gulp.task('test:unit', function (){
  gulp.src(['test/unit/**/*.js', 'test/unit/**/*.coffee'], { read: false })
    .pipe(mocha({
      reporter: 'dot',
    }));
});

gulp.task('test:integration', function (){
  gulp.src('test/integration.html')
    .pipe(mochaPhantomJS({reporter: 'dot'}));
});

gulp.task('test', ['test:unit', 'test:integration']);

/********** RUN **********/
var resources = ['pages', 'scripts', 'styles', 'bower'];

gulp.task('watch', function () {
  resources.forEach(function(r){
    gulp.watch(paths[r].all, [r]); //e.g. gulp.watch(paths.scripts.src, ['scripts']);
  });
});

gulp.task('serve', function(cb){
  swank({
    watch: true,
    path: paths.out_path,
    log: true
  }, function(err, warn, url){
    gutil.log('Server running:', url);
    cb();
  });
});

gulp.task('build', resources);

gulp.task('default', ['build', 'watch', 'serve']);