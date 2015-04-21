'use strict';

module.exports = function(grunt) {

  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),

    project: {
      name: '<%= pkg.name %>',
      app: 'app',
      dist: 'dist',
      assets: '<%= project.app %>/assets',
      coffeescripts: '<%= project.assets %>/coffeescripts',
      javascripts: '<%= project.assets %>/javascripts',
      css: '<%= project.assets %>/css',
      tmp: '<%= project.assets %>/tmp'
    },

    clean: [
      '<%= project.javascripts %>',
      '<%= project.css %>',
      '<%= project.tmp %>'
    ],

    coffee : {
      options: {
        sourceMap: true
      },
      dev: {
        expand: true,
        flatten: false,
        cwd: '<%= project.coffeescripts %>',
        src: ['**/*.coffee'],
        dest: '<%= project.javascripts %>',
        ext: '.js'
      }
    },

    useminPrepare: {
      html: '<%= project.app %>/index.html',
      options: {
        dest: '<%= project.dist %>',
        flow: {
          html: {
            steps: {
              js: ['concat', 'uglifyjs'],
              css: ['cssmin']
            },
            post: {}
          }
        }
      }
    },

    copy: {
      js: {
        expand: true,
        cwd: 'app/bower_components/',
        src: [
          'jquery/dist/jquery.js',
          'angular/angular.js',
          'angular-resource/angular-resource.js',
          'angular-ui-router/release/angular-ui-router.js',
          'angular-fontawesome/dist/angular-fontawesome.js',
          'bootstrap-sass-official/assets/javascripts/bootstrap.js',
          'underscore/underscore.js',
          'fullcalendar/dist/fullcalendar.js'
        ],
        dest: '<%= project.assets %>/vendor/assets/javascripts/',
        flatten: true,
        filter: 'isFile'
      },
      css: {
        expand: true,
        cwd: 'app/bower_components/',
        src: [
          'font-awesome/css/font-awesome.css',
          'fullcalendar/dist/fullcalendar.css'
        ],
        dest: '<%= project.assets %>/vendor/assets/css/',
        flatten: true,
        filter: 'isFile'
      }

    },

    ngAnnotate: {
      main: {
        src:'<%= project.assets %>/tmp/app.js',
        dest: '<%= project.assets %>/tmp/app.js'
      }
    },

    uglify: {
      options: {
        screwIE8: true,
        sourceMap: false,
        mangle: false,
        report: 'min'
      },
      dist: {
        files: [{
          expand: true,
          cwd: 'app/assets/vendor/assets/javascripts',
          src: '**/*.js',
          dest: 'app/assets/javascripts/vendor.js'
        }]
      },
      main: {
        files: {
          '<%= project.assets %>/tmp/app.min.js': [
            '<%= project.assets %>/tmp/app.js'
          ]
        }
      },
      vendor: {
        files: {
          '<%= project.assets %>/tmp/vendor.min.js': [
            '<%= project.assets %>/tmp/jquery.js',
            '<%= project.assets %>/tmp/angular.js',
            '<%= project.assets %>/tmp/angular-resource.js',
            '<%= project.assets %>/tmp/angular-ui-router.js',
            '<%= project.assets %>/tmp/angular-fontawesome.js',
            '<%= project.assets %>/tmp/bootstrap.js'
          ]
        }
      }
    },

    concat: {
      js: {
        options: {
          nonull: true,
          sourceMap: true
        },
        files: {
          '<%= project.assets %>/javascripts/app.min.js': [
            '<%= project.assets %>/tmp/jquery.min.js',
            '<%= project.assets %>/tmp/angular.min.js',
            '<%= project.assets %>/tmp/angular-resource.min.js',
            '<%= project.assets %>/tmp/angular-ui-router.min.js',
            '<%= project.assets %>/tmp/angular-fontawesome.min.js',
            '<%= project.assets %>/tmp/bootstrap.min.js',
            '<%= project.assets %>/tmp/app.min.js'
          ]
        }
      }
    },

    sass: {
      dev: {
        options: {
          style: 'compressed',
          compass: false
        },
        files: {
          '<%= project.assets %>/css/style.css':'<%= project.css %>'
        }
      }
    },

    // cssmin: {
      // options: {
        // shorthandCompacting: false,
        // roundingPrecision: -1
      // },
      // target: {
        // files: {
          // '<%= project.assets %>/css/style.css': [
            // '<%= project.assets %>/tmp/style.css'
          // ]
        // }
      // }
    // },

    watch: {
      js: {
        files: ['<%= project.assets %>/coffeescripts/{,*/}/*.coffee'],
        tasks: ['jsbuild']
      },
      sass: {
        files: '<%= project.assets %>/sass/{,*/}*.{scss,sass}',
        tasks: ['cssbuild']
      }
    }
  });

  grunt.loadNpmTasks('grunt-contrib-copy');
  grunt.loadNpmTasks('grunt-contrib-clean');
  grunt.loadNpmTasks('grunt-contrib-concat');
  grunt.loadNpmTasks('grunt-contrib-sass');
  grunt.loadNpmTasks('grunt-contrib-cssmin');
  grunt.loadNpmTasks('grunt-contrib-coffee');
  grunt.loadNpmTasks('grunt-ng-annotate');
  grunt.loadNpmTasks('grunt-contrib-uglify');
  grunt.loadNpmTasks('grunt-contrib-watch');

  grunt.registerTask('cssbuild', [
    'sass:dev'
  ]);

  grunt.registerTask('jsbuild', [
    'coffee:compileJoined', 'copy', 'ngAnnotate', 'uglify', 'concat:js'
  ]);

  grunt.registerTask('build', [
    'jsbuild', 'cssbuild'
  ]);

  grunt.registerTask('default', [
    'watch'
  ]);

};
