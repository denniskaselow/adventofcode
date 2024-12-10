import 'package:collection/collection.dart';

import '../utils.dart';

Map<({int x, int y}), int> _processInput(Input input) =>
    input.getLines().foldIndexed(<({int x, int y}), int>{}, (y, grid, line) {
      line.split('').map(int.parse).forEachIndexed((x, cell) {
        grid[(x: x, y: y)] = cell;
      });
      return grid;
    });

int day10star1(Input input) => _countTrails(input);

int day10star2(Input input) => _countTrails(input, uniqueTrails: true);

int _countTrails(Input input, {bool uniqueTrails = false}) {
  final grid = _processInput(input);

  final startingPositions =
      grid.entries
          .where((element) => element.value == 0)
          .map((e) => e.key)
          .toList();

  var result = 0;
  while (startingPositions.isNotEmpty) {
    final open = [startingPositions.removeLast()];
    final peaks = <({int x, int y})>[];
    while (open.isNotEmpty) {
      final current = open.removeLast();
      for (final direction in Direction.plus) {
        final next = (x: current.x + direction.x, y: current.y + direction.y);
        if (grid.containsKey(next) && grid[next] == grid[current]! + 1) {
          if (grid[next] == 9) {
            peaks.add(next);
          } else {
            open.add(next);
          }
        }
      }
    }
    result += uniqueTrails ? peaks.length : peaks.toSet().length;
  }

  return result;
}
