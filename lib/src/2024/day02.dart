import 'package:more/collection.dart';

import '../utils.dart';

Iterable<String> _processInput(Input input) => input.getLines();

int day02star1(Input input) {
  final lines = _processInput(
    input,
  ).map((line) => line.split(' ').map(int.parse).window(2));

  var result = 0;
  for (final line in lines) {
    final [current, next] = line.first;
    final asc = next - current > 0;
    var valid = true;
    for (final pair in line) {
      final dist = (pair[1] - pair[0]).abs();
      if (pair[1] - pair[0] > 0 != asc || dist < 1 || dist > 3) {
        valid = false;
        break;
      }
    }
    if (valid) {
      result++;
    }
  }

  return result;
}

int day02star2(Input input) {
  final lines = _processInput(
    input,
  ).map((line) => line.split(' ').map(int.parse).toList());

  var result = 0;
  bool validDiff(int diff) => diff.abs() >= 1 && diff.abs() <= 3;
  for (final line in lines) {
    for (var i = 0; i < line.length; i++) {
      final altLine = [...line.take(i), ...line.skip(i + 1)];
      final diffs =
          altLine.window(2).map((pair) => pair.first - pair.last).toList();
      final allDiffsValid = diffs.every(validDiff);
      final allDiffsPos = diffs.every((diff) => diff > 0);
      final allDiffsNeg = diffs.every((diff) => diff < 0);
      if (allDiffsValid && (allDiffsPos || allDiffsNeg)) {
        result++;
        break;
      }
    }
  }
  return result;
}
