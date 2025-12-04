import 'dart:math';

import 'package:collection/collection.dart';

import '../utils.dart';

Iterable<List<int>> _processInput(Input input) =>
    input.getLines().map((e) => e.split('').map(int.parse).toList());

int day03star1(Input input) {
  final result = _processInput(input).map((line) {
    final firstDigit = _getHighestDigit(line, 1);
    final secondDigit = _getHighestDigit(line.sublist(firstDigit.index + 1), 0);

    return firstDigit.value * 10 + secondDigit.value;
  });
  return result.sum;
}

({int index, int value}) _getHighestDigit(
  List<int> line,
  int requiredRemainingLength,
) {
  var maxValue = (value: 0, index: 0);
  for (final (index, value)
      in line.sublist(0, line.length - requiredRemainingLength).indexed) {
    if (maxValue.value < value) {
      maxValue = (index: index, value: value);
    }
  }
  return maxValue;
}

int day03star2(Input input) {
  final result = _processInput(input).map((line) {
    var result = 0;
    var digit = (index: -1, value: 0);
    var batteries = line;
    for (var i = 11; i >= 0; i--) {
      batteries = batteries.sublist(digit.index + 1);
      digit = _getHighestDigit(batteries, i);
      result += digit.value * pow(10, i).toInt();
    }
    return result;
  });
  return result.sum;
}
