import 'dart:collection';
import 'dart:math';

import 'package:collection/collection.dart';

import '../utils.dart';

typedef Coords = ({int x, int y});
typedef Cell = ({int x, int y, int heatloss});
typedef Grid = Map<Coords, int>;
typedef CellKey = ({
  int x,
  int y,
  DirectionCross direction,
});
typedef Move = ({
  int x,
  int y,
  DirectionCross direction,
  int heatloss,
});

int maxX = 0;
int maxY = 0;

int day17star1(String input) => getSolution(input, 1, 3);
int day17star2(String input) => getSolution(input, 4, 10);

int getSolution(String input, int moveMin, int moveMax) {
  final lines = input.getLines();
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

  final visited = <CellKey, int>{};
  final open = SplayTreeSet<Move>((key1, key2) {
    final minHeatLoss1 = key1.heatloss + ((maxX - key1.x) + (maxY - key1.y));
    final minHeatloss2 = key2.heatloss + ((maxX - key2.x) + (maxY - key2.y));
    var result = minHeatLoss1.compareTo(minHeatloss2);
    if (result == 0) {
      result = key1.heatloss.compareTo(key2.heatloss);
    }
    if (result == 0) {
      result = key1.x.compareTo(key2.x);
    }
    if (result == 0) {
      result = key1.y.compareTo(key2.y);
    }
    if (result == 0) {
      result = key1.direction.index.compareTo(key2.direction.index);
    }
    return result;
  })
    ..addAll([
      (x: 0, y: 0, direction: DirectionCross.east, heatloss: 0),
      (x: 0, y: 0, direction: DirectionCross.south, heatloss: 0),
    ]);

  var maxHeatloss = ((maxX + maxY) * 9 * 1.5).toInt();

  while (open.isNotEmpty) {
    final current = open.first;
    open.remove(current);
    final currentHeatloss = current.heatloss;
    final currentPos = (
      x: current.x,
      y: current.y,
      direction: current.direction,
    );
    if (visited.containsKey(currentPos) &&
        visited[currentPos]! < currentHeatloss) {
      continue;
    }
    if (current.heatloss + (maxX - current.x) + (maxY - current.y) >
        maxHeatloss) {
      continue;
    }
    if (current.x == maxX - 1 && current.y == maxY - 1) {
      maxHeatloss = min(maxHeatloss, current.heatloss);
    }

    visited[currentPos] = currentHeatloss;
    for (final direction in DirectionCross.values) {
      if (direction != current.direction &&
          direction != current.direction.opposite) {
        for (var i = moveMin; i <= moveMax; i++) {
          final nextX = current.x + direction.x * i;
          final nextY = current.y + direction.y * i;
          if (nextX >= 0 && nextY >= 0 && nextX < maxX && nextY < maxY) {
            var heatloss = 0;
            for (var j = 1; j <= i; j++) {
              heatloss += grid[(
                x: current.x + direction.x * j,
                y: current.y + direction.y * j
              )]!;
            }
            final nextMove = (
              direction: direction,
              x: nextX,
              y: nextY,
              heatloss: currentHeatloss + heatloss,
            );
            open.add(nextMove);
          }
        }
      }
    }
  }

  return visited.entries
      .where(
        (element) => element.key.x == maxX - 1 && element.key.y == maxY - 1,
      )
      .fold(
        maxX * 9 + maxY * 9,
        (previousValue, element) => min(previousValue, element.value),
      );
}
