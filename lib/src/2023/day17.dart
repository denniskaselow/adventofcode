import 'dart:math';

import 'package:collection/collection.dart';

import '../utils.dart';

typedef Coords = ({int x, int y});
typedef Cell = ({int x, int y, int heatloss});
typedef Grid = Map<Coords, int>;
typedef Move = ({int x, int y, int straight, DirectionCross direction});

var maxX = 0;
var maxY = 0;

Iterable<String> _processInput(String input) => input.getLines();

int day17star1(String input) {
  final lines = _processInput(input);
  maxY = lines.length;
  maxX = lines.first.length;
  final grid = lines.indexed
      .map((line) {
        final converted = line.$2.split('').indexed.map(
              (cell) => (x: cell.$1, y: line.$1, heatloss: int.parse(cell.$2)),
            );
        return converted;
      })
      .flattened
      .fold(Grid(), (previousValue, element) {
        previousValue[(x: element.x, y: element.y)] = element.heatloss;
        return previousValue;
      });

  final visited = {
    for (var x = 0; x < maxX; x++)
      for (var y = 0; y < maxY; y++)
        if (x == y)
          (x: x, y: y, direction: DirectionCross.south, straight: 0):
              x * 9 + y * 9,
  };

  traverseGrid(
    grid,
    visited,
    (x: 0, y: 0, direction: DirectionCross.east, straight: 0),
    -grid[(x: 0, y: 0)]!,
  );
  traverseGrid(
    grid,
    visited,
    (x: 0, y: 0, direction: DirectionCross.east, straight: 0),
    -grid[(x: 0, y: 0)]!,
  );

  return visited.entries
      .where(
        (element) => element.key.x == maxX - 1 && element.key.y == maxY - 1,
      )
      .fold(
        maxX * 9 + maxY * 9,
        (previousValue, element) => min(previousValue, element.value),
      );
}

void traverseGrid(
  Grid grid,
  Map<Move, int> moves,
  Move current,
  int heatloss,
) {
  if (current.x < 0 ||
      current.y < 0 ||
      current.x == maxX ||
      current.y == maxY) {
    return;
  }
  final currentHeatloss = heatloss + grid[(x: current.x, y: current.y)]!;
  final currentPos = (x: current.x, y: current.y);
  if (moves.containsKey(current) && moves[current]! < currentHeatloss ||
      moves[(
            x: max(currentPos.x, currentPos.y),
            y: max(currentPos.x, currentPos.y),
            direction: DirectionCross.south,
            straight: 0
          )]! <
          currentHeatloss) {
    // print(
    //   'aborting lowerExists $currentPos $currentHeatloss ${moves[currentPos]!}',
    // );
    return;
  }

  // if (current.x == maxX - 1 && current.y == maxY - 1) {
  //   print(current);
  //   print(currentHeatloss);
  // }

  moves[current] = currentHeatloss;
  for (final direction in DirectionCross.values) {
    final nextMove = (
      direction: direction,
      x: current.x + direction.x,
      y: current.y + direction.y,
      straight: direction == current.direction ? current.straight + 1 : 0
    );
    if (nextMove.straight < 3 && direction != current.direction.opposite) {
      traverseGrid(grid, moves, nextMove, currentHeatloss);
    }
  }
}

int day17star2(String input) => _processInput(input).length;
