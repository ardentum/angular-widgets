angular.module('angularWidgetsApp').directive 'awMenu', ->
  template = '''
      <div class="aw-menu" data-ng-click="focus(); $event.stopPropagation()">
        <div class="aw-menu__item"
          data-ng-repeat="item in items"
          data-ng-click="select(item)"
          data-ng-class="{'aw-menu__item_active': activeItem() == item, 'aw-menu__item_selected': isSelected(item)}">
          {{item}}
        </div>
      </div>
    '''

  container = angular.element(window)

  template: template
  replace:  true
  restrict: "E"

  scope:
    items: "="
    selectedItem: "=ngModel"

  link: (scope) ->
    # Index of highlighted menu item
    # Used for keyboard navigation
    activeIndex = -1

    scope.selectedItem = null

    scope.select = (item) ->
      scope.selectedItem = item
      activeIndex = scope.items.indexOf(scope.selectedItem)

    scope.isSelected = (item) ->
      scope.selectedItem == item

    scope.focused = false

    scope.blur = ->
      scope.focused = false
      activeIndex = -1

    scope.focus = ->
      scope.focused = true

    scope.navigateUp = ->
      activeIndex -= 1
      activeIndex = scope.items.length-1 if activeIndex < 0

    scope.navigateDown = ->
      activeIndex += 1
      activeIndex = 0 if activeIndex is scope.items.length

    scope.activeItem = ->
      scope.items[activeIndex]

    container.bind 'click', ->
      scope.$apply -> scope.blur()

    container.bind 'keydown', (event) ->
      return unless scope.focused

      scope.$apply ->
        switch event.keyCode
          when 38 then scope.navigateUp()
          when 40 then scope.navigateDown()
          when 13 then scope.select(scope.activeItem())
          else return

        event.preventDefault()