import 'package:collection/collection.dart';

import '../utils.dart';

int day10star1(String input) => _processInput(input)
    .mapIndexed((index, element) => element * (index + 1))
    .whereIndexed((index, element) => (index + 1) % 40 == 20)
    .sum;

String day10star2(String input) => _processInput(input)
    .mapIndexed(
      (index, element) => (element - index % 40).abs() <= 1 ? '#' : '.',
    )
    .mapIndexed((index, element) => index % 40 == 39 ? '$element\n' : element)
    .join();

Iterable<int> _processInput(String input) => input
        .getLines()
        .map((e) => e.split(' '))
        .flattened
        .map((e) => int.tryParse(e) ?? 0)
        .fold(
      [1],
      (previousValue, element) =>
          previousValue..add(previousValue.last + element),
    ).toList();
