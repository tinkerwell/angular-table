angular.module("angular-table").factory "setupFactory", [() ->

  orderByExpression = "| orderBy:predicate:descending"
  limitToExpression = "| limitTo:fromPage() | limitTo:toPage()"

  setupTr = (element, repeatString) ->
    tbody = element.find "tbody"
    tr = tbody.find "tr"
    tr.attr("ng-repeat", repeatString)
    tbody

  StandardSetup = (attributes) ->
    repeatString = "item in #{attributes.list} #{orderByExpression}"
    @compile = (element, attributes, transclude) ->
      setupTr element, repeatString

    @link = () ->
    return

  PaginationSetup = (attributes) ->

    sortContext = attributes.sortContext || "global"

    if sortContext == "global"
      repeatString = "item in #{attributes.pagination}.list #{orderByExpression} #{limitToExpression}"
    else if sortContext == "page"
      repeatString = "item in #{attributes.pagination}.list #{limitToExpression} #{orderByExpression} "
    else
      throw "Invalid sort-context: #{sortContext}."

    @compile = (element, attributes, transclude) ->
      tbody = setupTr element, repeatString

      if typeof attributes.fillLastPage != "undefined"
        tds = element.find("td")
        tdString = ""
        for td in tds
          tdString += "<td>&nbsp;</td>"

        fillerTr = angular.element("<tr>#{tdString}</tr>")
        fillerTr.attr("ng-repeat", "item in #{attributes.pagination}.getFillerArray() ")

        tbody.append(fillerTr)

    @link = ($scope, $element, $attributes) ->
      paginationName = attributes.pagination
      $scope.fromPage = () ->
        if $scope[paginationName] then $scope[paginationName].fromPage()

      $scope.toPage = () ->
        if $scope[paginationName] then $scope[paginationName].itemsPerPage

    return

  (attributes) ->
    if attributes.list
      return new StandardSetup(attributes)
    if attributes.pagination
      return new PaginationSetup(attributes)
    return

]