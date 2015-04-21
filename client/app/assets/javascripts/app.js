(function() {
  angular.module('Inventory', ['ngCookies', 'ngResource', 'ngSanitize', 'ngRoute', 'ui.bootstrap']).config(function($routeProvider) {
    return $routeProvider.when('/', {
      templateUrl: 'views/main.html',
      controller: 'MainCtrl'
    }).otherwise({
      redirectTo: '/'
    });
  });

}).call(this);

//# sourceMappingURL=app.js.map
