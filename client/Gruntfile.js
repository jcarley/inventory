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
      sass: '<%= project.assets %>/sass',
      javascripts: '<%= project.assets %>/javascripts',
      css: '<%= project.assets %>/css',
      tmp: '<%= project.assets %>/tmp'
    },

    clean: [
      '<%= project.javascripts %>',
      '<%= project.css %>',
      '<%= project.tmp %>',
      '<%= project.dist %>',
      '.tmp'
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

    ngAnnotate: {
      main: {
        options: {
          singleQuotes: true
        },
        files: [{
          expand: true,
          src: ['<%= project.javascripts %>/**/*.js']
        }]
      }
    },

    uglify: {
      options: {
        screwIE8: true,
        sourceMap: false,
        mangle: false,
        report: 'min'
      },
    },

    useminPrepare: {
      html: '<%= project.app %>/index.html',
      options: {
        dest: '<%= project.dist %>'
      }
    },

    // Performs rewrites based on rev and the useminPrepare configuration
    usemin: {
      html: ['<%= project.dist %>/{,*/}*.html'],
      css: ['<%= project.dist %>/styles/{,*/}*.css'],
      options: {
        assetsDirs: [
          '<%= project.dist %>/assets/javascripts',
          '<%= project.dist %>/assets/css'
        ]
      }
    },

    copy: {
      dist: {
        expand: true,
        cwd: '<%= project.app %>',
        src: [
          'index.html',
          'assets/css/style.css'
        ],
        dest: '<%= project.dist %>',
        flatten: false,
        filter: 'isFile'
      }
    },

    sass: {
      dev: {
        options: {
          style: 'expanded',
          compass: false
        },
        files: {
          '<%= project.assets %>/css/style.css':'<%= project.sass %>/style.scss'
        }
      }
    },

    karma: {
      unit: {
        configFile: 'karma.conf.js'
      }
    },

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
  grunt.loadNpmTasks('grunt-usemin');
  grunt.loadNpmTasks('grunt-karma');
  grunt.loadNpmTasks('grunt-contrib-watch');

  grunt.registerTask('cssbuild', [
    'sass:dev'
  ]);

  grunt.registerTask('jsbuild', [
    'coffee:dev', 'ngAnnotate'
  ]);

  grunt.registerTask('build', [
    'jsbuild',
    'cssbuild'
  ]);

  grunt.registerTask('deploy', [
    'clean',
    'coffee:dev',
    'sass:dev',
    'ngAnnotate',
    'useminPrepare',
    'concat',
    'uglify',
    'copy:dist',
    'cssmin',
    'usemin'
  ]);


  grunt.registerTask('default', [
    'watch'
  ]);

};
