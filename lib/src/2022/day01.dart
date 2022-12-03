import 'package:collection/collection.dart';

int day1star1(String input) {
  return _processInput(input).fold(
      0,
      (previousValue, element) =>
          previousValue > element ? previousValue : element);
}

int day1star2(String input) {
  final caloriesPerElf = _processInput(input).toList();
  caloriesPerElf.sort((a, b) => b - a);
  return caloriesPerElf.take(3).sum;
}

Iterable<int> _processInput(String input) {
  return input
      .split('\n\n')
      .map((e) => e.split('\n'))
      .map((e) => e.map(int.parse).sum);
}
