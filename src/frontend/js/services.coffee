"use strict"

module = angular.module 'tjd.viz.services', []

module.factory 'd3', ['$window', ($window) -> $window.d3 ]
