angular.module("angular-table").service "metaCollector", [() ->

  capitaliseFirstLetter = (string) ->
    if string then string.charAt(0).toUpperCase() + string.slice(1) else ""

  extractWidth = (classes) ->
    width = /([0-9]+px)/i.exec classes
    if width then width[0] else ""

  isSortable = (classes) ->
    sortable = /(sortable)/i.exec classes
    if sortable then true else false

  {
    collectCustomHeaderMarkup: (thead) ->
      customHeaderMarkup = {}

      tr = thead.find "tr"
      for th in tr.find "th"
        th = angular.element(th)
        customHeaderMarkup[th.attr("attribute")] = th.html()

      customHeaderMarkup

    collectBodyDefinitions: (tbody) ->
      bodyDefinitions = []

      tds = tbody.find "td"
      for td in tds
        td = angular.element(td)

        attribute = td.attr("attribute")
        title = td.attr("title") || capitaliseFirstLetter(td.attr("attribute"))
        sortable = td[0].attributes.sortable || isSortable(td.attr("class"))
        width = extractWidth(td.attr("class"))

        bodyDefinitions.push {attribute: attribute, title: title, sortable: sortable, width: width}

      bodyDefinitions

  }
]