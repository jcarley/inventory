'use strict';

module.exports = function(grunt) {

  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),

    project: {
      app: ['app'],
      assets: ['<%= project.app %>/assets'],
      css: ['<%= project.assets %>/sass/style.scss']
    },

    coffee : {
      compileJoined: {
        options: {
          join: true
        },
        files: {
          '<%= project.assets %>/tmp/app.js': '<%= project.assets %>/coffeescripts/**/*.coffee',
        }
      },
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
        sourceMap: true
      },
      main: {
        files: {
          '<%= project.assets %>/javascripts/app.min.js': [
            '<%= project.assets %>/tmp/app.js'
          ]
        }
      }
    },

    sass: {
      dev: {
        options: {
          style: 'expanded',
          compass: false
        },
        files: {
          '<%= project.assets %>/tmp/style.css':'<%= project.css %>'
        }
      }
    },

    cssmin: {
      options: {
        shorthandCompacting: false,
        roundingPrecision: -1
      },
      target: {
        files: {
          '<%= project.assets %>/css/style.css': [
            '<%= project.assets %>/tmp/style.css'
          ]
        }
      }
    },

    watch: {
      js: {
        files: ['<%= project.assets %>/coffeescripts/{,*/}/*.coffee'],
        tasks: ['coffee:compileJoined', 'ngAnnotate', 'uglify' ]
      },
      sass: {
        files: '<%= project.assets %>/sass/{,*/}*.{scss,sass}',
        tasks: [
          'sass:dev'
        ]
      }
    }
  });

  grunt.loadNpmTasks('grunt-contrib-sass');
  grunt.loadNpmTasks('grunt-contrib-cssmin');
  grunt.loadNpmTasks('grunt-contrib-coffee');
  grunt.loadNpmTasks('grunt-ng-annotate');
  grunt.loadNpmTasks('grunt-contrib-uglify');
  grunt.loadNpmTasks('grunt-contrib-watch');

  grunt.registerTask('build', [
    'coffee:compileJoined', 'ngAnnotate', 'uglify', 'sass:dev', 'cssmin:target'
  ]);

  grunt.registerTask('default', [
    'watch'
  ]);

};
