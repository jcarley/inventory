angular.module('Inventory', ['ngCookies', 'ngResource', 'ngSanitize', 'ngRoute', 'ui.bootstrap'])
  .config ($routeProvider) ->
    $routeProvider
      .when '/', {
        templateUrl: 'views/main.html',
        controller: 'MainCtrl'
      }
      .otherwise {
        redirectTo: '/'
      }
