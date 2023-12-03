import 'package:collection/collection.dart';

import '../utils.dart';

Iterable<String> _processInput(String input) => input.getLines();

int day3star1(String input) => _processInput(input)
    .map(
      (e) => [e.substring(0, e.length ~/ 2), e.substring(e.length ~/ 2)]
          .map((e) => e.split('').toSet()),
    )
    .map((e) => e.first.intersection(e.last).first)
    .map(
      (e) => e.codeUnits.first <= 'Z'.codeUnits.first
          ? e.toInt(offset: 27)
          : e.toInt(offset: 1),
    )
    .sum;

int day3star2(String input) {
  final elves = _processInput(input).toList();
  final group = List.generate(
    elves.length ~/ 3,
    (index) => [elves[index * 3], elves[index * 3 + 1], elves[index * 3 + 2]],
  );
  return group
      .map(
        (e) => e[0]
            .split('')
            .toSet()
            .intersection(e[1].split('').toSet())
            .intersection(e[2].split('').toSet())
            .first,
      )
      .map(
        (e) => e.codeUnits.first <= 'Z'.codeUnits.first
            ? e.toInt(offset: 27)
            : e.toInt(offset: 1),
      )
      .sum;
}
