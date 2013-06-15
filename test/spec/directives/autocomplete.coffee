'use strict'

describe 'Directive: autocomplete', () ->
  beforeEach module 'angularWidgetsApp'

  element = {}

  it 'should make hidden element visible', inject ($rootScope, $compile) ->
    element = angular.element '<autocomplete></autocomplete>'
    element = $compile(element) $rootScope
    expect(element.text()).toBe 'this is the autocomplete directive'
