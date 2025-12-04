import 'package:collection/collection.dart';

import '../utils.dart';

Set<({int column, int row})> _processInput(Input input) => input
    .getLines()
    .mapIndexed(
      (row, element) => element
          .split('')
          .indexed
          .where((element) => element.$2 == '@')
          .map((element) => (row: row, column: element.$1)),
    )
    .expand((element) => element)
    .toSet();

int day04star1(Input input) {
  final grid = _processInput(input);
  final result = grid.where((cell) {
    var adjacentScrolls = 0;
    for (final direction in Direction.values) {
      if (grid.contains((
        row: cell.row + direction.x,
        column: cell.column + direction.y,
      ))) {
        adjacentScrolls++;
      }
    }
    return adjacentScrolls < 4;
  });

  return result.length;
}

int day04star2(Input input) {
  var grid = _processInput(input);
  final initialCount = grid.length;
  var scrollsBefore = grid.length;
  do {
    scrollsBefore = grid.length;
    grid = _updateGrid(grid);
  } while (scrollsBefore > grid.length);
  return initialCount - grid.length;
}

Set<({int column, int row})> _updateGrid(Set<({int column, int row})> grid) {
  final result = grid.where((cell) {
    var adjacentScrolls = 0;
    for (final direction in Direction.values) {
      if (grid.contains((
        row: cell.row + direction.x,
        column: cell.column + direction.y,
      ))) {
        adjacentScrolls++;
      }
    }
    return adjacentScrolls >= 4;
  });
  return result.toSet();
}
