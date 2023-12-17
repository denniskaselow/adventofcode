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
  int straight,
  DirectionCross direction,
});
typedef Move = ({
  int x,
  int y,
  int straight,
  DirectionCross direction,
  int heatloss,
});

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

  final visited = <CellKey, int>{};
  final open = SplayTreeSet<Move>((key1, key2) {
    final maxHeatloss1 =
        key1.heatloss + ((maxX - key1.x) + (maxY - key1.y)) * 9 * 1.5;
    final maxHeatloss2 =
        key2.heatloss + ((maxX - key2.x) + (maxY - key2.y)) * 9 * 1.5;
    var result = maxHeatloss1.compareTo(maxHeatloss2);
    if (result == 0) {
      result = key1.heatloss.compareTo(key2.heatloss);
    }
    if (result == 0) {
      result = key1.straight.compareTo(key2.straight);
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
      (x: 0, y: 0, direction: DirectionCross.east, straight: -1, heatloss: 0),
    ]);
  final moves = <Move, Move>{};

  var count = 0;
  var maxHeatloss = ((maxX + maxY) * 9 * 1.5).toInt();

  while (open.isNotEmpty) {
    count++;
    if (count % 1000000 == 0) {
      print('--');
      // print(open.join('\n'));
      print(open.length);
    }
    final current = open.first;
    open.remove(current);
    // print('visiting $current');
    final currentHeatloss = current.heatloss;
    final currentPos = (
      x: current.x,
      y: current.y,
      direction: current.direction,
      straight: current.straight
    );
    if (visited.containsKey(currentPos) &&
        visited[currentPos]! < currentHeatloss) {
      continue;
    }
    if (current.x == maxX - 1 && current.y == maxY - 1) {
      print('target reached: ${current.heatloss}');
      maxHeatloss = min(maxHeatloss, current.heatloss);
    }

    // print('heatloss: $currentHeatloss');
    visited[currentPos] = currentHeatloss;
    for (final direction in DirectionCross.values) {
      final nextX = current.x + direction.x;
      final nextY = current.y + direction.y;
      if (nextX >= 0 && nextY >= 0 && nextX < maxX && nextY < maxY) {
        final nextMove = (
          direction: direction,
          x: nextX,
          y: nextY,
          straight: direction == current.direction ? current.straight + 1 : 0,
          heatloss: currentHeatloss + grid[(x: nextX, y: nextY)]!,
        );
        if (nextMove.straight < 3 && direction != current.direction.opposite) {
          if (nextMove.heatloss +
                  (maxX - nextMove.x - 1) +
                  (maxY - nextMove.y - 1) <
              maxHeatloss) {
            moves[nextMove] = current;
            open.add(nextMove);
          }
        }
      }
    }
  }

  final result = visited.entries
      .where(
        (element) => element.key.x == maxX - 1 && element.key.y == maxY - 1,
      )
      .fold(
        maxX * 9 + maxY * 9,
        (previousValue, element) => min(previousValue, element.value),
      );
  final pathMap = lines.toList();
  for (final MapEntry(key: current, value: previous) in moves.entries.where(
    (element) =>
        element.key.x == maxX - 1 &&
        element.key.y == maxY - 1 &&
        element.key.heatloss == result,
  )) {
    pathMap[current.y] = pathMap[current.y]
        .replaceRange(current.x, current.x + 1, current.direction.ui);
    Move source = previous;
    while (moves.containsKey(source)) {
      pathMap[source.y] = pathMap[source.y]
          .replaceRange(source.x, source.x + 1, source.direction.ui);
      source = moves[source]!;
    }
    pathMap[source.y] = pathMap[source.y]
        .replaceRange(source.x, source.x + 1, source.direction.ui);
    print(current);
    print(pathMap.join('\n'));
  }
  return result;
}

int day17star2(String input) => _processInput(input).length;
