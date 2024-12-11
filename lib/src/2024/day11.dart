import 'package:collection/collection.dart';

import '../utils.dart';

List<String> _processInput(Input input) =>
    input.getLines().first.split(' ').toList();

int day11star1(Input input) => _blink(input, 25);

int day11star2(Input input) => _blink(input, 75);

int _blink(Input input, int times) {
  var currentCount = <String, int>{
    for (final value in _processInput(input)) value: 1,
  };
  var nextCount = <String, int>{};

  for (var i = 0; i < times; i++) {
    for (final element in currentCount.keys) {
      final converted = switch (element) {
        '0' => ['1'],
        _ when element.length.isEven => [
          '${int.parse(element.substring(0, element.length ~/ 2))}',
          '${int.parse(element.substring(element.length ~/ 2))}',
        ],
        _ => ['${int.parse(element) * 2024}'],
      };
      for (final key in converted) {
        nextCount.update(
          key,
          (value) => currentCount[element]! + value,
          ifAbsent: () => currentCount[element]!,
        );
      }
    }

    (currentCount, nextCount) = (nextCount, currentCount);
    nextCount.clear();
  }

  return currentCount.values.sum;
}
