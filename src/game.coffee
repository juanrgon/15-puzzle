shuffle = (arr) ->
    for i in [(arr.length - 1)..1]
        j = Math.floor(Math.random() * (i + 1))
        [arr[i], arr[j]] = [arr[j], arr[i]]
    return arr


gameController = ($scope) ->
    $scope.reset = (event) ->
      $scope.tiles = [0..15]
      $scope.tiles = shuffle($scope.tiles)
      $scope.empty_cell =
        row: Math.floor $scope.tiles.indexOf(0) / 4
        column: $scope.tiles.indexOf(0) % 4

    $scope.slide = (row, column) ->
        if row == $scope.empty_cell.row
          if column < $scope.empty_cell.column
            $scope.slideRight(row, column , $scope.empty_cell.column)
          else
            $scope.slideLeft(row, column , $scope.empty_cell.column)
        else if column == $scope.empty_cell.column
          if row < $scope.empty_cell.row
            $scope.slideDown(row, column , $scope.empty_cell.row)
          else
            $scope.slideUp(row, column , $scope.empty_cell.row)
        else
           return

        $scope.empty_cell =
          row: row
          column: column

    $scope.slideUp = (row, column, target_row) ->
      if row == target_row
        return

      current = row * 4 + column
      next = (row - 1) * 4 + column

      $scope.slideUp(row - 1, column, target_row)
      [$scope.tiles[current], $scope.tiles[next]] = [$scope.tiles[next], $scope.tiles[current]]

    $scope.slideDown = (row, column, target_row) ->
      if row == target_row
        return

      current = row * 4 + column
      next = (row + 1) * 4 + column

      $scope.slideDown(row + 1, column, target_row)
      [$scope.tiles[current], $scope.tiles[next]] = [$scope.tiles[next], $scope.tiles[current]]


    $scope.slideRight = (row, column, target_column) ->
      column == target_column
      if column == target_column
        return
      else
        current = row * 4 + column
        next = row * 4 + column + 1

        $scope.slideRight(row, column + 1, target_column)
        [$scope.tiles[current], $scope.tiles[next]] = [$scope.tiles[next], $scope.tiles[current]]


    $scope.slideLeft = (row, column, target_column) ->
      if column == target_column
        return

      current = row * 4 + column
      next = row * 4 + column - 1

      $scope.slideLeft(row, column - 1, target_column)
      [$scope.tiles[current], $scope.tiles[next]] = [$scope.tiles[next], $scope.tiles[current]]

    $scope.reset()


app = angular.module('game', [])
app.controller('gameController' , gameController)
