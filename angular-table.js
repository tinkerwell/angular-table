// author: Samuel Mueller http://github.com/ssmm

(function() {
  angular.module("angular-table", []);

  angular.module("angular-table").service("attributeExtractor", function() {
    return {
      extractWidth: function(classes) {
        var width;

        width = /([0-9]+px)/i.exec(classes);
        if (width) {
          return width[0];
        } else {
          return "";
        }
      },
      isSortable: function(classes) {
        var sortable;

        sortable = /(sortable)/i.exec(classes);
        if (sortable) {
          return true;
        } else {
          return false;
        }
      },
      extractTitle: function(td) {
        return td.attr("title") || td.attr("attribute");
      },
      extractAttribute: function(td) {
        return td.attr("attribute");
      }
    };
  });

  angular.module("angular-table").directive("atTable", [
    "attributeExtractor", function(attributeExtractor) {
      var capitaliseFirstLetter, constructHeader;

      capitaliseFirstLetter = function(string) {
        return string.charAt(0).toUpperCase() + string.slice(1);
      };
      constructHeader = function(element) {
        var attribute, existing_ths, icon, sortable, td, tds, th, thead, title, tr, width, _i, _j, _len, _len1, _ref;

        thead = element.find("thead");
        if (thead[0]) {
          tr = thead.find("tr");
          existing_ths = {};
          _ref = tr.find("th");
          for (_i = 0, _len = _ref.length; _i < _len; _i++) {
            th = _ref[_i];
            th = angular.element(th);
            existing_ths[th.attr("attribute")] = th.html();
          }
          tr.remove();
          tds = element.find("td");
          tr = $("<tr></tr>");
          for (_j = 0, _len1 = tds.length; _j < _len1; _j++) {
            td = tds[_j];
            td = angular.element(td);
            attribute = attributeExtractor.extractAttribute(td);
            th = $("<th style='cursor: pointer; -webkit-user-select: none;'></th>");
            title = existing_ths[attribute] || capitaliseFirstLetter(attributeExtractor.extractTitle(td));
            th.html("" + title);
            sortable = td[0].attributes.sortable || attributeExtractor.isSortable(td.attr("class"));
            if (sortable) {
              th.attr("ng-click", "predicate = '" + attribute + "'; descending = !descending;");
              icon = angular.element("<i style='margin-left: 10px;'></i>");
              icon.attr("ng-class", "getSortIcon('" + attribute + "')");
              th.append(icon);
            }
            width = attributeExtractor.extractWidth(td.attr("class"));
            th.attr("width", width);
            tr.append(th);
          }
          return thead.append(tr);
        }
      };
      return {
        restrict: "AC",
        scope: {
          list: "=",
          scope: "=",
          query: "=",
          pager: "="
        },
        compile: function(element, attributes, transclude) {
          var tbody, tr;

          constructHeader(element);
          tbody = element.find("tbody");
          tr = tbody.find("tr");
          tr.attr("ng-repeat", "item in list | limitTo:fromPage() | limitTo:toPage() | orderBy:predicate:descending");
          return {
            post: function($scope, $element, $attributes) {
              $scope.getSortIcon = function(predicate) {
                if (predicate !== $scope.predicate) {
                  return "icon-minus";
                }
                if ($scope.descending) {
                  return "icon-chevron-down";
                } else {
                  return "icon-chevron-up";
                }
              };
              $scope.fromPage = function() {
                if ($scope.pager) {
                  return $scope.pager.fromPage();
                } else {
                  return $scope.list.length;
                }
              };
              return $scope.toPage = function() {
                if ($scope.pager) {
                  return $scope.pager.itemsPerPage;
                } else {
                  return $scope.list.length;
                }
              };
            }
          };
        }
      };
    }
  ]);

  angular.module("angular-table").directive("atImplicit", [
    "attributeExtractor", function(attributeExtractor) {
      return {
        restrict: "AC",
        compile: function(element, attributes, transclude) {
          var attribute;

          attribute = attributeExtractor.extractAttribute(element);
          return element.append("{{item." + attribute + "}}");
        }
      };
    }
  ]);

  angular.module("angular-table").directive("atPager", [
    "attributeExtractor", function(attributeExtractor) {
      return {
        replace: true,
        restrict: "E",
        template: "      <div class='pagination' style='margin: 0px;'>        <ul>          <li ng-class='{disabled: currentPage <= 0}'>            <a href='' ng-click='goToPage(currentPage - 1)'>&laquo;</a>          </li>          <li ng-class='{active: currentPage == page}' ng-repeat='page in pages'>            <a href='' ng-click='goToPage(page)'>{{page + 1}}</a>          </li>          <li ng-class='{disabled: currentPage >= numberOfPages - 1}'>            <a href='' ng-click='goToPage(currentPage + 1); normalize()'>&raquo;</a>          </li>        </ul>      </div>",
        scope: {
          itemsPerPage: "@",
          instance: "=",
          list: "="
        },
        link: function($scope, $element, $attributes) {
          $scope.currentPage = 0;
          $scope.update = function() {
            var x;

            $scope.numberOfPages = Math.ceil($scope.list.length / $scope.itemsPerPage);
            return $scope.pages = (function() {
              var _i, _ref, _results;

              _results = [];
              for (x = _i = 0, _ref = $scope.numberOfPages - 1; 0 <= _ref ? _i <= _ref : _i >= _ref; x = 0 <= _ref ? ++_i : --_i) {
                _results.push(x);
              }
              return _results;
            })();
          };
          $scope.fromPage = function() {
            return $scope.itemsPerPage * $scope.currentPage - $scope.list.length;
          };
          $scope.goToPage = function(page) {
            if (page < 0) {
              page = 0;
            } else if (page > $scope.numberOfPages - 1) {
              page = $scope.numberOfPages - 1;
            }
            return $scope.currentPage = page;
          };
          $scope.update();
          $scope.instance = $scope;
          return $scope.$watch("list", function() {
            return $scope.update();
          });
        }
      };
    }
  ]);

}).call(this);