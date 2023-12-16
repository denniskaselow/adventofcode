import 'dart:math';

import '../utils.dart';

typedef Coords = ({int x, int y});
typedef Grid = Map<Coords, String>;

int maxX = 0;
int maxY = 0;

Iterable<String> _processInput(String input) => input.getLines();

int day16star1(String input) {
  final grid = getGrid(input);
  final result = <Coords, Set<DirectionCross>>{};
  traverseGrid(grid, (x: -1, y: 0), DirectionCross.east, result);
  return result.length;
}

int day16star2(String input) {
  final grid = getGrid(input);

  var maxEnergized = 0;
  for (var x = 0; x < maxX; x++) {
    var result = <Coords, Set<DirectionCross>>{};
    traverseGrid(grid, (x: x, y: -1), DirectionCross.south, result);
    maxEnergized = max(maxEnergized, result.length);

    result = <Coords, Set<DirectionCross>>{};
    traverseGrid(grid, (x: x, y: maxY), DirectionCross.north, result);
    maxEnergized = max(maxEnergized, result.length);
  }
  for (var y = 0; y < maxY; y++) {
    var result = <Coords, Set<DirectionCross>>{};
    traverseGrid(grid, (x: -1, y: y), DirectionCross.east, result);
    maxEnergized = max(maxEnergized, result.length);

    result = <Coords, Set<DirectionCross>>{};
    traverseGrid(grid, (x: maxX, y: y), DirectionCross.west, result);
    maxEnergized = max(maxEnergized, result.length);
  }

  return maxEnergized;
}

Map<Coords, String> getGrid(String input) {
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
  DirectionCross direction,
  Map<Coords, Set<DirectionCross>> energized,
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
      if (direction == DirectionCross.east ||
          direction == DirectionCross.west) {
        traverseGrid(grid, pos, DirectionCross.north, energized);
        traverseGrid(grid, pos, DirectionCross.south, energized);
      } else {
        traverseGrid(grid, pos, direction, energized);
      }
    } else if (cell == '-') {
      if (direction == DirectionCross.north ||
          direction == DirectionCross.south) {
        traverseGrid(grid, pos, DirectionCross.west, energized);
        traverseGrid(grid, pos, DirectionCross.east, energized);
      } else {
        traverseGrid(grid, pos, direction, energized);
      }
    } else if (cell == '/') {
      if (direction == DirectionCross.east) {
        traverseGrid(grid, pos, DirectionCross.north, energized);
      } else if (direction == DirectionCross.south) {
        traverseGrid(grid, pos, DirectionCross.west, energized);
      } else if (direction == DirectionCross.west) {
        traverseGrid(grid, pos, DirectionCross.south, energized);
      } else if (direction == DirectionCross.north) {
        traverseGrid(grid, pos, DirectionCross.east, energized);
      }
    } else if (cell == r'\') {
      if (direction == DirectionCross.east) {
        traverseGrid(grid, pos, DirectionCross.south, energized);
      } else if (direction == DirectionCross.south) {
        traverseGrid(grid, pos, DirectionCross.east, energized);
      } else if (direction == DirectionCross.west) {
        traverseGrid(grid, pos, DirectionCross.north, energized);
      } else if (direction == DirectionCross.north) {
        traverseGrid(grid, pos, DirectionCross.west, energized);
      }
    }
  } else {
    traverseGrid(grid, pos, direction, energized);
  }
}
