import 'package:collection/collection.dart';

import '../utils.dart';

Map<int, int> _processInput(Input input) => input
    .getLines()
    .first
    .split(',')
    .map(int.parse)
    .fold(
      <int, int>{},
      (previousValue, element) =>
          previousValue
            ..update(element, (value) => value + 1, ifAbsent: () => 1),
    );

int day06star1(Input input, {int days = 80}) => _breed(input, days);

int day06star2(Input input) => _breed(input, 256);

int _breed(Input input, int days) {
  var daysToBreed = _processInput(input);
  var nextDaysToBreed = <int, int>{};

  for (var i = 0; i < days; i++) {
    for (final key in daysToBreed.keys) {
      for (final nextKey in switch (key) {
        0 => [6, 8],
        _ => [key - 1],
      }) {
        nextDaysToBreed.update(
          nextKey,
          (value) => value + daysToBreed[key]!,
          ifAbsent: () => daysToBreed[key]!,
        );
      }
    }
    (daysToBreed, nextDaysToBreed) = (nextDaysToBreed, daysToBreed);
    nextDaysToBreed.clear();
  }
  return daysToBreed.values.sum;
}
