"use strict"

module = angular.module 'tjd.viz.home', [
  'tjd.viz.services'
]

module.controller 'HomeCtrl', ['$scope', 'd3', '$log', ($scope, d3, $log) ->
  $scope.startBalance = 10000
  $scope.deposit = 1000
  $scope.interest = 0.08
  $scope.maxYear = 30

  draw = ->
    w = 800
    h = 500
    barWidth = 10
    maxYear = +$scope.maxYear + 1
    numYTicks = 10
    xPad = 150
    yPad = 40
    startBalance = +$scope.startBalance
    deposit = +$scope.deposit
    annualInterest = +$scope.interest
    monthlyInterest = Math.pow(1 + annualInterest, 1/12) - 1
    data = (for n in [0..maxYear]
      Math.pow(1 + monthlyInterest, 12*n) * startBalance + (1 - Math.pow(1 + monthlyInterest, 12*n+1))/(1 - (1 + monthlyInterest)) * deposit
    )
    maxMoney = _.max(data)


    $('#time-graph').empty()

    timeGraph = d3.select('#time-graph').append('svg:svg')
    x = d3.scale.linear().domain([0, maxYear]).range([xPad, w + xPad])
    y = d3.scale.linear().domain([0, maxMoney]).rangeRound([0, h])
    timeGraph.attr('width', w + xPad).attr('height', h + yPad)
      
    tooltip = d3.select('#time-graph').append('div').
      attr('class', 'tooltip').
      style('opacity', '0')

    rules = timeGraph.selectAll('g.rule').
      data(y.ticks(numYTicks)).
      enter().append('svg:g').
        attr('class', 'rule').
      append('svg:line').
        attr('x1', xPad).
        attr('x2', xPad + w).
        attr('y1', (d) -> h - y(d)).
        attr('y2', (d) -> h - y(d)).
        attr('stroke', '#ccc')

    bars = timeGraph.selectAll('rect').
      data(data).
      enter().
      append('svg:rect').
      attr('x', (datum, index) -> x(index)).
      attr('y', (datum) -> h - y(datum)).
      attr('height', (datum) -> y(datum)).
      attr('width', barWidth).
      attr('fill', '#2d578b').
      on('mouseover', (d) ->
        tooltip.transition().
          duration(200).
          style('opacity', .9)
        tooltip.html(d3.format(',.2f')(d)).
          style('left', "#{d3.event.pageX}px").
          style('top', "#{d3.event.pageY - 28}px")).
      on('mouseout', (d) ->
        tooltip.transition()
          .duration(500)
          .style('opacity', 0))

    bars.append('title').
      text((datum) -> datum)

    timeGraph.selectAll('test.xaxis').
      data(data).
      enter().append('svg:text').
      attr('x', (datum, index) -> x(index) + barWidth).
      attr('y', h).
      attr('dx', -barWidth/2).
      attr('text-anchor', 'middle').
      text((datum, idx) -> idx).
      attr('transform', 'translate(0, 18)').
      attr('class', 'x-axis')

    timeGraph.selectAll('test.yaxis').
      data(y.ticks(numYTicks)).
      enter().append('svg:text').
      attr('x', xPad - 10).
      attr('y', (datum) -> h - y(datum)).
      attr('text-anchor', 'end').
      text((datum) -> _.str.numberFormat(datum, 2))


  inputs = ['goal', 'startBalance', 'deposit', 'interest', 'maxYear']
  for input in inputs
    $scope.$watch input, draw
]
