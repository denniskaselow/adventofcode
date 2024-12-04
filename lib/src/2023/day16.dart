import 'dart:math';

import '../utils.dart';

typedef Coords = ({int x, int y});
typedef Grid = Map<Coords, String>;

var maxX = 0;
var maxY = 0;

Iterable<String> _processInput(Input input) => input.getLines();

int day16star1(Input input) {
  final grid = getGrid(input);
  final result = <Coords, Set<Direction>>{};
  traverseGrid(grid, (x: -1, y: 0), Direction.e, result);
  return result.length;
}

int day16star2(Input input) {
  final grid = getGrid(input);

  var maxEnergized = 0;
  for (var x = 0; x < maxX; x++) {
    var result = <Coords, Set<Direction>>{};
    traverseGrid(grid, (x: x, y: -1), Direction.s, result);
    maxEnergized = max(maxEnergized, result.length);

    result = <Coords, Set<Direction>>{};
    traverseGrid(grid, (x: x, y: maxY), Direction.n, result);
    maxEnergized = max(maxEnergized, result.length);
  }
  for (var y = 0; y < maxY; y++) {
    var result = <Coords, Set<Direction>>{};
    traverseGrid(grid, (x: -1, y: y), Direction.e, result);
    maxEnergized = max(maxEnergized, result.length);

    result = <Coords, Set<Direction>>{};
    traverseGrid(grid, (x: maxX, y: y), Direction.w, result);
    maxEnergized = max(maxEnergized, result.length);
  }

  return maxEnergized;
}

Map<Coords, String> getGrid(Input input) {
  final lines = _processInput(input);
  maxY = lines.length;
  maxX = lines.first.length;
  final grid = <Coords, String>{};
  lines.indexed
      .map(
        (line) => line.$2
            .split('')
            .indexed
            .where((cell) => cell.$2 != '.')
            .fold(grid, (grid, cell) {
          grid[(x: cell.$1, y: line.$1)] = cell.$2;
          return grid;
        }),
      )
      .toList();
  return grid;
}

void traverseGrid(
  Grid grid,
  Coords lastPos,
  Direction direction,
  Map<Coords, Set<Direction>> energized,
) {
  final pos = (x: lastPos.x + direction.x, y: lastPos.y + direction.y);
  if (pos.x < 0 || pos.x == maxX || pos.y < 0 || pos.y == maxY) {
    return;
  }
  if (energized[pos]?.contains(direction) ?? false) {
    return;
  }
  energized.update(
    pos,
    (value) => value..add(direction),
    ifAbsent: () => {direction},
  );

  if (grid[pos] case final cell?) {
    if (cell == '|') {
      if (direction == Direction.e ||
          direction == Direction.w) {
        traverseGrid(grid, pos, Direction.n, energized);
        traverseGrid(grid, pos, Direction.s, energized);
      } else {
        traverseGrid(grid, pos, direction, energized);
      }
    } else if (cell == '-') {
      if (direction == Direction.n ||
          direction == Direction.s) {
        traverseGrid(grid, pos, Direction.w, energized);
        traverseGrid(grid, pos, Direction.e, energized);
      } else {
        traverseGrid(grid, pos, direction, energized);
      }
    } else if (cell == '/') {
      if (direction == Direction.e) {
        traverseGrid(grid, pos, Direction.n, energized);
      } else if (direction == Direction.s) {
        traverseGrid(grid, pos, Direction.w, energized);
      } else if (direction == Direction.w) {
        traverseGrid(grid, pos, Direction.s, energized);
      } else if (direction == Direction.n) {
        traverseGrid(grid, pos, Direction.e, energized);
      }
    } else if (cell == r'\') {
      if (direction == Direction.e) {
        traverseGrid(grid, pos, Direction.s, energized);
      } else if (direction == Direction.s) {
        traverseGrid(grid, pos, Direction.e, energized);
      } else if (direction == Direction.w) {
        traverseGrid(grid, pos, Direction.n, energized);
      } else if (direction == Direction.n) {
        traverseGrid(grid, pos, Direction.w, energized);
      }
    }
  } else {
    traverseGrid(grid, pos, direction, energized);
  }
}
