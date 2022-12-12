import 'dart:collection';

import 'package:meta/meta.dart';

import '../utils.dart';

int day12star1(String input) => travel(input, 'S');
int day12star2(String input) => travel(input, 'a');

List<List<int>> _processInput(String input) =>
    input.split('\n').map((e) => e.codeUnits.toList()).toList();

int travel(String input, String startElevation) {
  final grid = _processInput(input);
  final start = <Cell>[];
  var end = const Cell(0, 0);
  for (var y = 0; y < grid.length; y++) {
    if (grid[y].contains(startElevation.codeUnitAt(0))) {
      start.add(Cell(grid[y].indexOf(startElevation.codeUnitAt(0)), y));
      if (startElevation == 'S') {
        grid[y][start.last.x] = 'a'.codeUnitAt(0);
      }
    }
    if (grid[y].contains('E'.codeUnitAt(0))) {
      end = Cell(grid[y].indexOf('E'.codeUnitAt(0)), y);
      grid[y][end.x] = 'z'.codeUnitAt(0);
    }
  }
  final open = Queue<Cell>.from(start);
  return countSteps(grid, end, <Cell>{}, open);
}

int countSteps(
  List<List<int>> grid,
  Cell end,
  Set<Cell> visited,
  Queue<Cell> open,
) {
  var steps = 0;
  final frontier = <Cell>{};
  visited.addAll(open);
  do {
    final current = open.removeFirst();
    if (current == end) {
      return steps;
    }
    for (final direction in Direction.values) {
      final target = Cell(current.x + direction.x, current.y + direction.y);
      if (target.x < 0 ||
          target.y < 0 ||
          target.x >= grid[0].length ||
          target.y >= grid.length) {
      } else if (grid[target.y][target.x] <= grid[current.y][current.x] + 1 &&
          !visited.contains(target)) {
        frontier.add(target);
      }
    }

    if (open.isEmpty) {
      open.addAll(frontier);
      visited.addAll(frontier);
      steps++;
      frontier.clear();
    }
  } while (open.isNotEmpty);
  return 0;
}

@immutable
class Cell {
  final int x;
  final int y;

  const Cell(this.x, this.y);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Cell &&
          runtimeType == other.runtimeType &&
          x == other.x &&
          y == other.y;

  @override
  int get hashCode => Object.hash(x, y);
}
