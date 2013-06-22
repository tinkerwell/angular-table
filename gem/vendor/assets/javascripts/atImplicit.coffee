angular.module("angular-table").directive "atImplicit", [() ->
  {
    restrict: "AC"
    compile: (element, attributes, transclude) ->
      attribute = element.attr("attribute")
      throw "at-implicit specified without attribute: #{element.html()}" if not attribute
      element.append "{{item.#{attribute}}}"
  }
]