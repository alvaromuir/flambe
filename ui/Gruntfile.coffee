#!
# * Gruntfile
# * @author Alvaro Muir, @alvaromuir
# 
"use strict"

###
Livereload and connect variables
###
LIVERELOAD_PORT = 35729
lrSnippet = require("connect-livereload")(port: LIVERELOAD_PORT)
mountFolder = (connect, dir) ->
  connect.static require("path").resolve(dir)


###
Grunt module
###
module.exports = (grunt) ->
  
  ###
  Dynamically load npm tasks
  ###
  require("matchdep").filterDev("grunt-*").forEach grunt.loadNpmTasks
  
  ###
  FireShell Grunt config
  ###
  grunt.initConfig
    pkg: grunt.file.readJSON("package.json")
    
    ###
    Set project info
    ###
    project:
      src: "src"
      app: "app"
      assets: "<%= project.app %>/assets"
      css: ["<%= project.src %>/scss/style.scss"]
      js: ["<%= project.src %>/js/*.js"]

    ###
    Project banner
    Dynamically appended to CSS/JS files
    Inherits text from package.json
    ###
    tag:
      banner: "/*!\n" + " * <%= pkg.name %>\n" + " * <%= pkg.title %>\n" + " * <%= pkg.url %>\n" + " * @author <%= pkg.author %>\n" + " * @version <%= pkg.version %>\n" + " * Copyright <%= pkg.copyright %>. <%= pkg.license %> licensed.\n" + " */\n"
    

    # Coffeescript and Jade
    coffee:
      dist:
        files: [
          expand: true
          cwd: "<%= project.src %>/js"
          src: "{,*/}*.coffee"
          dest: "<%= project.app %>/assets/js"
          ext: ".js"
        ]

    jade:
      html:
        options:
          pretty: true
          client: false
        files:
          '<%= project.app %>/': ['<%= project.src %>/{,*/}*.jade']

    ###
    Connect port/livereload
    https://github.com/gruntjs/grunt-contrib-connect
    Starts a local webserver and injects
    livereload snippet
    ###
    connect:
      options:
        port: 9000
        hostname: "*"

      livereload:
        options:
          middleware: (connect) ->
            [lrSnippet, mountFolder(connect, "app")]

    
    ###
    Clean files and folders
    https://github.com/gruntjs/grunt-contrib-clean
    Remove generated files for clean deploy
    ###
    clean:
      dist: ["<%= project.assets %>/css/style.unprefixed.css", "<%= project.assets %>/css/style.prefixed.css"]

  
    
    ###
    Concatenate JavaScript files
    https://github.com/gruntjs/grunt-contrib-concat
    Imports all .js files and appends project banner
    ###
    concat:
      dev:
        files:
          "<%= project.assets %>/js/scripts.min.js": "<%= project.js %>"

      options:
        stripBanners: true
        nonull: true
        banner: "<%= tag.banner %>"

    
    ###
    Uglify (minify) JavaScript files
    https://github.com/gruntjs/grunt-contrib-uglify
    Compresses and minifies all JavaScript files into one
    ###
    uglify:
      options:
        banner: "<%= tag.banner %>"

      dist:
        files:
          "<%= project.assets %>/js/scripts.min.js": "<%= project.js %>"

    
    ###
    Compile Sass/SCSS files
    https://github.com/gruntjs/grunt-contrib-sass
    Compiles all Sass/SCSS files and appends project banner
    ###
    sass:
      dev:
        options:
          style: "expanded"
          banner: "<%= tag.banner %>"

        files:
          "<%= project.assets %>/css/style.unprefixed.css": "<%= project.css %>"

      dist:
        options:
          style: "expanded"

        files:
          "<%= project.assets %>/css/style.unprefixed.css": "<%= project.css %>"

    
    ###
    Autoprefixer
    Adds vendor prefixes if need automatcily
    https://github.com/nDmitry/grunt-autoprefixer
    ###
    autoprefixer:
      options:
        browsers: ["last 2 version", "safari 6", "ie 9", "opera 12.1", "ios 6", "android 4"]

      dev:
        files:
          "<%= project.assets %>/css/style.min.css": ["<%= project.assets %>/css/style.unprefixed.css"]

      dist:
        files:
          "<%= project.assets %>/css/style.prefixed.css": ["<%= project.assets %>/css/style.unprefixed.css"]

    
    ###
    CSSMin
    CSS minification
    https://github.com/gruntjs/grunt-contrib-cssmin
    ###
    cssmin:
      dev:
        options:
          banner: "<%= tag.banner %>"

        files:
          "<%= project.assets %>/css/style.min.css": ["<%= project.src %>/components/normalize-css/normalize.css", "<%= project.assets %>/css/style.unprefixed.css"]

      dist:
        options:
          banner: "<%= tag.banner %>"

        files:
          "<%= project.assets %>/css/style.min.css": ["<%= project.src %>/components/normalize-css/normalize.css", "<%= project.assets %>/css/style.prefixed.css"]

    
    ###
    Build bower components
    https://github.com/yatskevich/grunt-bower-task
    ###
    bower:
      dev:
        dest: "<%= project.assets %>/components/"

      dist:
        dest: "<%= project.assets %>/components/"

    
    ###
    Opens the web server in the browser
    https://github.com/jsoverson/grunt-open
    ###
    open:
      server:
        path: "http://localhost:<%= connect.options.port %>"

    
    ###
    Runs tasks against changed watched files
    https://github.com/gruntjs/grunt-contrib-watch
    Watching development files and run concat/compile tasks
    Livereload the browser once complete
    ###
    watch:
      concat:
        files: "<%= project.src %>/js/{,*/}*.js"
        tasks: ["concat:dev"]

      sass:
        files: "<%= project.src %>/scss/{,*/}*.{scss,sass}"
        tasks: ["sass:dev", "cssmin:dev", "autoprefixer:dev"]

      livereload:
        options:
          livereload: LIVERELOAD_PORT

        files: ["<%= project.app %>/{,*/}*.html", "<%= project.assets %>/css/*.css", "<%= project.assets %>/js/{,*/}*.js", "<%= project.assets %>/{,*/}*.{png,jpg,jpeg,gif,webp,svg}"]

      coffee:
        files: ["<%= project.src %>/js/{,*/}*.coffee"]
        tasks: ["coffee:dist"]

      jade:
        files: ["<%= project.src %>/jade/{,*/}*.jade"]
        tasks: ["jade:html"]
  
  ###
  Default task
  Run `grunt` on the command line
  ###
  grunt.registerTask "default", ["sass:dev", "coffee:dist", "jade:html", "cssmin:dev", "bower:dev", "autoprefixer:dev", "concat:dev", "connect:livereload", "open", "watch"]
  
  ###
  Build task
  Run `grunt build` on the command line
  Then compress all JS/CSS files
  ###
  grunt.registerTask "build", ["sass:dist", "coffee:dist", "jade:html", "bower:dist", "autoprefixer:dist", "cssmin:dist", "clean:dist", "uglify"]