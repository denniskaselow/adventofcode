import 'package:more/more.dart' hide IndexedIterableExtension;

import '../utils.dart';

Map<String, List<({int x, int y})>> _processInput(Input input) => input
    .getLines()
    .indexed
    .fold(<String, List<({int x, int y})>>{}, (antennas, line) {
      line.$2.split('').indexed.where((cell) => cell.$2 != '.').forEach((cell) {
        antennas.update(
          cell.$2,
          (value) => value..add((x: cell.$1, y: line.$1)),
          ifAbsent: () => [(x: cell.$1, y: line.$1)],
        );
      });
      return antennas;
    });

int day08star1(Input input) {
  final antennas = _processInput(input);
  final antinodes = <({int x, int y})>{};
  for (final value in antennas.values) {
    for (final [first, second] in value.permutations(2)) {
      final diffX = second.x - first.x;
      final diffY = second.y - first.y;
      antinodes.add((x: second.x + diffX, y: second.y + diffY));
    }
  }
  final size = input.getLines().length;
  return antinodes.count((element) => _isInGrid(element, size));
}

int day08star2(Input input) {
  final antennas = _processInput(input);
  final antinodes = <({int x, int y})>{};

  final size = input.getLines().length;
  for (final value in antennas.values) {
    for (final [first, second] in value.permutations(2)) {
      final diffX = second.x - first.x;
      final diffY = second.y - first.y;
      for (var i = 0; i < size; i++) {
        final antinode = (x: second.x + i * diffX, y: second.y + i * diffY);
        if (!_isInGrid(antinode, size)) {
          break;
        }
        antinodes.add(antinode);
      }
    }
  }
  return antinodes.length;
}

bool _isInGrid(({int x, int y}) element, int size) =>
    element.x >= 0 && element.x < size && element.y >= 0 && element.y < size;
