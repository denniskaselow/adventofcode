import 'package:collection/collection.dart';

import '../utils.dart';

List<String> _processInput(Input input) =>
    input.getLines().first.split(' ').toList();

int day11star1(Input input) => _blink(input, 25);

int day11star2(Input input) => _blink(input, 75);

int _blink(Input input, int times) {
  var current = _processInput(input).toSet();
  var currentCount = <String, int>{for (final value in current) value: 1};
  var nextCount = <String, int>{};
  var next = <String>{};
  final cache = <String, List<String>>{};

  for (var i = 0; i < times; i++) {
    for (final element in current) {
      final converted =
          cache[element] ??= switch (element) {
            '0' => ['1'],
            _ when element.length.isEven => [
              '${int.parse(element.substring(0, element.length ~/ 2))}',
              '${int.parse(element.substring(element.length ~/ 2))}',
            ],
            _ => ['${int.parse(element) * 2024}'],
          };
      next.addAll(converted);
      for (final key in converted) {
        nextCount.update(
          key,
          (value) => currentCount[element]! + value,
          ifAbsent: () => currentCount[element]!,
        );
      }
    }

    (current, next) = (next, current);
    (currentCount, nextCount) = (nextCount, currentCount);
    next.clear();
    nextCount.clear();
  }

  return currentCount.values.sum;
}
