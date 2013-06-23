angular.module("angular-table").service "metaCollector", [() ->

  capitaliseFirstLetter = (string) ->
    if string then string.charAt(0).toUpperCase() + string.slice(1) else ""

  extractWidth = (classes) ->
    width = /([0-9]+px)/i.exec classes
    if width then width[0] else ""

  isSortable = (classes) ->
    sortable = /(sortable)/i.exec classes
    if sortable then true else false

  getInitialSortDirection = (td) ->
    initialSorting = td.attr("initial-sorting")
    if initialSorting
      return initialSorting if initialSorting == "asc" || initialSorting == "desc"
      throw "Invalid value for initial-sorting: #{initialSorting}. Allowed values are 'asc' or 'desc'."
    return undefined

  {
    collectCustomHeaderMarkup: (thead) ->
      customHeaderMarkup = {}

      tr = thead.find "tr"
      for th in tr.find "th"
        th = angular.element(th)
        customHeaderMarkup[th.attr("attribute")] = th.html()

      customHeaderMarkup

    collectBodyDefinition: (tbody) ->
      bodyDefinition = {}
      bodyDefinition.tds = []
      bodyDefinition.initialSorting = undefined

      for td in tbody.find("td")
        td = angular.element(td)

        attribute = td.attr("attribute")
        title = td.attr("title") || capitaliseFirstLetter(td.attr("attribute"))
        sortable = td[0].attributes.sortable || isSortable(td.attr("class"))
        width = extractWidth(td.attr("class"))

        bodyDefinition.tds.push {attribute: attribute, title: title, sortable: sortable, width: width}

        initialSortDirection = getInitialSortDirection td
        if initialSortDirection
          throw "initial-sorting specified without attribute." if not attribute
          bodyDefinition.initialSorting = {}
          bodyDefinition.initialSorting.direction = initialSortDirection
          bodyDefinition.initialSorting.predicate = attribute


      bodyDefinition

  }
]