"use strict"

module = angular.module 'tjd.viz.routes', [
  'tjd.viz.home' 
]

module.config ['$routeProvider', ($routeProvider) ->
  $routeProvider
    .when('/',
      templateUrl: '/templates/home.html'
      controller: 'HomeCtrl'
    )
]

