angular.module "angular-table", []

angular.module("angular-table").service "attributeExtractor", () ->
  {
    extractWidth: (classes) ->
      width = /([0-9]+px)/i.exec classes
      if width then width[0] else ""

    isSortable: (classes) ->
      sortable = /(sortable)/i.exec classes
      if sortable then true else false

    extractTitle: (td) ->
      td.attr("title") || td.attr("attribute")

    extractAttribute: (td) ->
      td.attr("attribute")

  }

angular.module("angular-table").directive "atTable", ["attributeExtractor", (attributeExtractor) ->

  capitaliseFirstLetter = (string) ->
    string.charAt(0).toUpperCase() + string.slice(1)

  constructHeader = (element) ->
    thead = element.find "thead"

    if thead[0]

      tr = thead.find "tr"

      existing_ths = {}

      for th in tr.find "th"
        th = angular.element(th)
        existing_ths[th.attr("attribute")] = th.html()

      tr.remove()

      tds = element.find("td")

      tr = $("<tr></tr>")
      for td in tds
        td = angular.element(td)
        attribute = attributeExtractor.extractAttribute(td)
        th = $("<th style='cursor: pointer; -webkit-user-select: none;'></th>")
        title = existing_ths[attribute] || capitaliseFirstLetter(attributeExtractor.extractTitle(td))
        th.html("#{title}")

        sortable = td[0].attributes.sortable || attributeExtractor.isSortable(td.attr("class"))
        if sortable
          th.attr("ng-click", "predicate = '#{attribute}'; descending = !descending;")
          icon = angular.element("<i style='margin-left: 10px;'></i>")
          icon.attr("ng-class", "getSortIcon('#{attribute}')")
          th.append(icon)

        width = attributeExtractor.extractWidth(td.attr("class"))
        th.attr("width", width)
        tr.append(th)

      thead.append tr

  {
    restrict: "AC"
    scope: {
      list: "="
      scope: "="
      query: "="
      pager: "="
    }
    compile: (element, attributes, transclude) ->

      constructHeader(element)

      tbody = element.find "tbody"
      tr = tbody.find "tr"

      tr.attr("ng-repeat", "item in list | limitTo:fromPage() | limitTo:toPage() | orderBy:predicate:descending")

      {
        post: ($scope, $element, $attributes) ->
          $scope.getSortIcon = (predicate) ->
            return "icon-minus" if predicate != $scope.predicate
            if $scope.descending then "icon-chevron-down" else "icon-chevron-up"

          $scope.fromPage = () ->
            if $scope.pager
              $scope.pager.fromPage()
            else
              $scope.list.length

          $scope.toPage = () ->
            if $scope.pager
              $scope.pager.itemsPerPage
            else
              $scope.list.length
      }
  }
]

angular.module("angular-table").directive "atImplicit", ["attributeExtractor", (attributeExtractor) ->
  {
    restrict: "AC"
    compile: (element, attributes, transclude) ->
      attribute = attributeExtractor.extractAttribute element
      element.append "{{item.#{attribute}}}"
  }
]

angular.module("angular-table").directive "atPager", ["attributeExtractor", (attributeExtractor) ->
  {
    replace: true
    restrict: "E"
    template: "
      <div class='pagination' style='margin: 0px;'>
        <ul>
          <li ng-class='{disabled: currentPage <= 0}'>
            <a href='' ng-click='goToPage(currentPage - 1)'>&laquo;</a>
          </li>
          <li ng-class='{active: currentPage == page}' ng-repeat='page in pages'>
            <a href='' ng-click='goToPage(page)'>{{page + 1}}</a>
          </li>
          <li ng-class='{disabled: currentPage >= numberOfPages - 1}'>
            <a href='' ng-click='goToPage(currentPage + 1); normalize()'>&raquo;</a>
          </li>
        </ul>
      </div>"
    scope: {
      itemsPerPage: "@"
      instance: "="
      list: "="
    }
    link: ($scope, $element, $attributes) ->
      $scope.currentPage = 0

      # $scope.itemsPerPage = 7

      $scope.update = () ->
        $scope.numberOfPages = Math.ceil($scope.list.length / $scope.itemsPerPage)
        $scope.pages = for x in [0..($scope.numberOfPages - 1)]
          x

      $scope.fromPage = () ->
        $scope.itemsPerPage * $scope.currentPage - $scope.list.length

      $scope.goToPage = (page) ->
        if page < 0
          page = 0
        else if page > $scope.numberOfPages - 1
          page = $scope.numberOfPages - 1

        $scope.currentPage = page

      $scope.update()

      $scope.instance = $scope

      $scope.$watch "list", () ->
        $scope.update()
  }
]