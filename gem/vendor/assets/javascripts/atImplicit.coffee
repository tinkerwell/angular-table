angular.module("angular-table").directive "atImplicit", [() ->
  {
    restrict: "AC"
    compile: (element, attributes, transclude) ->
      attribute = element.attr("attribute")
      element.append "{{item.#{attribute}}}"
  }
]