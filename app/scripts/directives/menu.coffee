angular.module('angularWidgetsApp').directive 'awMenu', ->
  container = angular.element(window)

  template: '''
    <div class="aw-menu" data-ng-click="focus(); $event.stopPropagation()">
      <div class="aw-menu__item"
        data-ng-repeat="item in items"
        data-ng-click="select(item)"
        data-ng-mouseenter="activateItem(item)"
        data-ng-class="{'aw-menu__item_active': activeItem() == item, 'aw-menu__item_selected': isSelected(item)}">
        {{item}}
      </div>
    </div>
  '''

  replace:  true
  restrict: "E"

  scope:
    items: "="
    blurable: "&"
    onSelect: "&"
    selectedItem: "=ngModel"


  link: (scope) ->
    # Index of highlighted menu item
    # Used for keyboard navigation
    activeIndex = 0

    scope.selectedItem = null

    scope.activateItem = (item) ->
      activeIndex = scope.items.indexOf(item)

    scope.select = (item) ->
      scope.selectedItem = item
      scope.activateItem(item)
      scope.onSelect(value: item)

    scope.isSelected = (item) ->
      scope.selectedItem == item

    scope.focused = false

    scope.blur = ->
      scope.focused = false
      activeIndex = 0

    scope.focus = ->
      scope.focused = true

    scope.navigate = (offset) ->
      activeIndex += offset

      # loop navigation
      activeIndex = scope.items.length-1 if activeIndex < 0
      activeIndex = 0 if activeIndex >= scope.items.length

    scope.activeItem = ->
      scope.items[activeIndex]

    container.bind 'click', ->
      scope.$apply -> scope.blur()

    container.bind 'keydown', (event) ->
      return if scope.blurable() && !scope.focused

      scope.$apply ->
        switch event.keyCode
          when 38 then scope.navigate(-1)
          when 40 then scope.navigate(+1)
          when 13 then scope.select(scope.activeItem()) if scope.activeItem()
          else return

        event.preventDefault()