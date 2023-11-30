import 'dart:math';

import 'package:more/more.dart';

import '../utils.dart';

Iterable<Iterable<int>> _processInput(String input) =>
    input.lines.map((line) => line.split('x').map(int.parse));

int day02star1(String input) {
  final processedInput = _processInput(input)
      .map((e) => e.permutations(2).map((e) => e[0] * e[1]));
  final totalArea = processedInput.map((e) => e.reduce(sum)).reduce(sum);
  final minArea = processedInput.map((e) => e.reduce(min)).reduce(sum);
  return totalArea + minArea;
}

int day02star2(String input) {
  final length = _processInput(input)
      .map((e) => e.toList()..remove(e.reduce(max)))
      .map((e) => 2 * e.first + 2 * e.last)
      .reduce(sum);
  final volume = _processInput(input)
      .map((e) => e.reduce((value, element) => value * element))
      .reduce(sum);

  return length + volume;
}
