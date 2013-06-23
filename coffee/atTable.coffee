angular.module "angular-table", []

angular.module("angular-table").directive "atTable", ["metaCollector", "setupFactory", (metaCollector, setupFactory) ->

  constructHeader = (customHeaderMarkup, bodyDefinitions) ->
    tr = angular.element("<tr></tr>")

    for td in bodyDefinitions
      th = angular.element("<th style='cursor: pointer;'></th>")
      title = customHeaderMarkup[td.attribute] || td.title
      th.html("#{title}")

      if td.sortable
        th.attr("ng-click", "predicate = '#{td.attribute}'; descending = !descending;")
        icon = angular.element("<i style='margin-left: 10px;'></i>")
        icon.attr("ng-class", "getSortIcon('#{td.attribute}')")
        th.append(icon)

      th.attr("width", td.width)
      tr.append(th)

    tr

  validateInput = (attributes) ->
    if attributes.pagination and attributes.list
      throw "You can not specify a list if you have specified a pagination. The list defined for the pagnination will automatically be used."
    if not attributes.pagination and not attributes.list
      throw "Either a list or pagination must be specified."

  {
    restrict: "AC"
    scope: true
    compile: (element, attributes, transclude) ->
      validateInput attributes

      thead = element.find "thead"
      tbody = element.find "tbody"

      tds = element.find "td"
      if thead[0]
        customHeaderMarkup = metaCollector.collectCustomHeaderMarkup(thead)
        bodyDefinition = metaCollector.collectBodyDefinition(tbody)

        tr = thead.find "tr"
        tr.remove()
        thead.append constructHeader(customHeaderMarkup, bodyDefinition.tds)

      setup = setupFactory attributes
      setup.compile(element, attributes, transclude)

      {
        post: ($scope, $element, $attributes) ->

          if bodyDefinition.initialSorting
            $scope.predicate = bodyDefinition.initialSorting.predicate
            $scope.descending = (bodyDefinition.initialSorting.direction == "desc")

          $scope.getSortIcon = (predicate) ->
            return "icon-minus" if predicate != $scope.predicate
            if $scope.descending then "icon-chevron-down" else "icon-chevron-up"

          setup.link($scope, $element, $attributes)
      }
  }
]

