var exec = require('child_process').exec;
var gulp = require('gulp');
var liveReload = require('gulp-livereload');
var nib = require('nib');
var nodemon = require('nodemon');
var stylus = require('gulp-stylus');

var paths = {
  client: {
    hx: {
      all: 'src/mtg/client/**/*.hx'
    },
    js: {
      all: 'temp/client/**/*.js'
    },
    html: {
      index: 'src/mtg/client/html/index.html',
      all: 'src/mtg/client/html/**/*.html',
    },
    styl: {
      index: 'src/mtg/client/styl/index.styl',
      all: 'src/mtg/client/styl/**/*.styl',
    },
    assets: {
      all: 'src/mtg/client/assets/**/*'
    }
  },
  server: {
    hx: {
      all: 'src/mtg/server/**/*.hx'
    },
    js: {
      all: 'temp/server/**/*.js'
    }
  },
  dist: {
    client: {
      root: 'dist/public',
      assets: 'dist/public/assets'
    },
    server: {
      root: 'dist',
      index: 'dist/server.js'
    }
  }
};

gulp.task('client-hx', function(cb) {
  exec('haxe build_client.hxml', cb);
});

gulp.task('client-js', ['client-hx'], function() {
  return gulp.src(paths.client.js.all)
    .pipe(gulp.dest(paths.dist.client.root))
    .pipe(liveReload());
});

gulp.task('client-html', function() {
  return gulp.src(paths.client.html.all)
    .pipe(gulp.dest(paths.dist.client.root))
    .pipe(liveReload());
});

gulp.task('client-styl', function() {
  return gulp.src(paths.client.styl.index)
    .pipe(stylus({ use: nib() }))
    .pipe(gulp.dest(paths.dist.client.root))
    .pipe(liveReload());
});

gulp.task('client-assets', function() {
  return gulp.src(paths.client.assets.all)
    .pipe(gulp.dest(paths.dist.client.assets))
    .pipe(liveReload());
});

gulp.task('server-hx', function(cb) {
  exec('haxe build_server.hxml', cb);
});

gulp.task('server-js', ['server-hx'], function() {
  return gulp.src(paths.server.js.all)
    .pipe(gulp.dest(paths.dist.server.root));
});

gulp.task('build', ['client-js', 'client-html', 'client-styl', 'client-assets', 'server-js']);

gulp.task('serve', ['build'], function() {
  nodemon({
    script: paths.dist.server.index,
    ext: 'js',
    ignore: [paths.dist.client.root],
    watch: [paths.dist.server.index]
  });
});

gulp.task('watch', ['serve'], function() {
  liveReload.listen();
  gulp.watch(paths.client.hx.all, ['client-js']);
  gulp.watch(paths.client.html.all, ['client-html']);
  gulp.watch(paths.client.styl.all, ['client-styl']);
  gulp.watch(paths.client.assets.all, ['client-assets']);
  gulp.watch(paths.server.hx.all, ['server-js']);
});

gulp.task('default', ['watch']);
