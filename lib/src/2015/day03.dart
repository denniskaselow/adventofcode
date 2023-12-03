import 'package:collection/collection.dart';

import '../utils.dart';

({int x, int y, Set<(int, int)> visited}) _processInput(String input) =>
    input.split('').map((e) => DirectionCross.values['^v><'.indexOf(e)]).fold(
      (x: 0, y: 0, visited: <(int, int)>{(0, 0)}),
      (previousValue, element) => (
        x: previousValue.x + element.x,
        y: previousValue.y + element.y,
        visited: previousValue.visited
          ..add(
            (previousValue.x + element.x, previousValue.y + element.y),
          )
      ),
    );

int day03star1(String input) => _processInput(input).visited.length;

int day03star2(String input) {
  final santa =
      input.split('').whereIndexed((index, element) => index.isEven).join();
  final roboSanta =
      input.split('').whereIndexed((index, element) => index.isOdd).join();

  final allVisited = _processInput(santa).visited
    ..addAll(_processInput(roboSanta).visited);
  return allVisited.length;
}
