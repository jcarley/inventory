(function() {
  angular.module('Inventory', ['ngCookies', 'ngResource', 'ngSanitize', 'ngRoute', 'ui.bootstrap']).config(["$routeProvider", function($routeProvider) {
    return $routeProvider.when('/', {
      templateUrl: 'views/main.html',
      controller: 'MainCtrl'
    }).otherwise({
      redirectTo: '/'
    });
  }]);

  angular.module('Inventory').controller('MainCtrl', ["$scope", function($scope) {
    return $scope.awesomeThings = ['HTML5 Boilerplate', 'AngularJS', 'Karma', 'SitePoint'];
  }]);

}).call(this);
