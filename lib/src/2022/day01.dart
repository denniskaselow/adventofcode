import 'package:collection/collection.dart';

import '../utils.dart';

int day1star1(Input input) => _processInput(input).fold(
      0,
      (previousValue, element) =>
          previousValue > element ? previousValue : element,
    );

int day1star2(Input input) {
  final caloriesPerElf = _processInput(input).toList()..sort((a, b) => b - a);
  return caloriesPerElf.take(3).sum;
}

Iterable<int> _processInput(Input input) => input
    .getInputGroups()
    .map((e) => e.getLines())
    .map((e) => e.map(int.parse).sum);
