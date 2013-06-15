'use strict'

describe 'Directive: menu', () ->
  beforeEach module 'angularWidgetsApp'

  element = {}

  it 'should make hidden element visible', inject ($rootScope, $compile) ->
    element = angular.element '<menu></menu>'
    element = $compile(element) $rootScope
    expect(element.text()).toBe 'this is the menu directive'
