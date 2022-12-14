import 'dart:math';

import 'package:more/more.dart';

int day14star1(String input) {
  final grid = _processInput(input);
  final maxY = grid.keys.fold(0, max);
  return simulateSand(grid, maxY, hasFloor: false);
}

int day14star2(String input) {
  final grid = _processInput(input);
  final maxY = grid.keys.fold(0, max) + 1;
  return simulateSand(grid, maxY, hasFloor: true);
}

int simulateSand(Map<int, Set<int>> grid, int maxY, {required bool hasFloor}) {
  var currentX = 500;
  var currentY = 0;
  final directions = [
    [0, 1],
    [-1, 1],
    [1, 1]
  ];
  var settledCount = 0;
  while (hasFloor ? !(grid[0]?.contains(500) ?? false) : currentY <= maxY) {
    var settled = true;
    for (final direction in directions) {
      if (!(grid[currentY + direction[1]]?.contains(currentX + direction[0]) ??
          false)) {
        currentY = currentY + direction[1];
        currentX = currentX + direction[0];
        settled = false;
        break;
      }
    }
    if (settled || hasFloor && currentY == maxY) {
      grid.putIfAbsent(currentY, () => <int>{}).add(currentX);
      currentX = 500;
      currentY = 0;
      settledCount++;
    }
  }
  return settledCount;
}

Map<int, Set<int>> _processInput(String input) => input
        .split('\n')
        .map((e) =>
            e.split(' -> ').map((e) => e.split(',').map(int.parse)).window(2))
        .fold(<int, Set<int>>{}, (previousValue, element) {
      for (final cell in element) {
        final distX = cell[1].first - cell[0].first;
        final distY = cell[1].last - cell[0].last;
        for (var x = 0; x <= distX.abs(); x++) {
          for (var y = 0; y <= distY.abs(); y++) {
            previousValue
                .putIfAbsent(cell[0].last + y * distY.sign, () => {})
                .add(cell[0].first + x * distX.sign);
          }
        }
      }
      return previousValue;
    });
