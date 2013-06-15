angular.module('angularWidgetsApp').controller 'MainCtrl',
($scope, $q, $timeout) ->
  data = [
    "ActionScript",
    "AppleScript",
    "Asp",
    "BASIC",
    "C",
    "C++",
    "Clojure",
    "COBOL",
    "ColdFusion",
    "Erlang",
    "Fortran",
    "Groovy",
    "Haskell",
    "Java",
    "JavaScript",
    "Lisp",
    "Perl",
    "PHP",
    "Python",
    "Ruby",
    "Scala",
    "Scheme"
  ];

  $scope.data = data

  $scope.search = (value) ->
    defer = $q.defer()

    if (!value)
      defer.resolve([]);
    else
      $timeout ->
        defer.resolve data.filter (item) ->
          item.toLowerCase().match(value.toLowerCase())
      , 200

    return defer.promise