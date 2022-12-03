import 'package:adventofcode2022/src/utils.dart';

Iterable<String> _processInput(String input) {
  return input.split('\n');
}

int day3star1(String input) {
  return _processInput(input)
      .map((e) => [e.substring(0, e.length ~/ 2), e.substring(e.length ~/ 2)]
          .map((e) => e.split('').toSet()))
      .map((e) => e.first.intersection(e.last).first)
      .map((e) => e.codeUnits.first <= 'Z'.codeUnits.first
          ? e.codeUnits.first - 'A'.codeUnits.first + 27
          : e.codeUnits.first - 'a'.codeUnits.first + 1)
      .sum();
}

int day3star2(String input) {
  final elves = _processInput(input).toList();
  final group = List.generate(
      elves.length ~/ 3,
      (index) =>
          [elves[index * 3], elves[index * 3 + 1], elves[index * 3 + 2]]);
  return group
      .map((e) {
        return e[0]
            .split('')
            .toSet()
            .intersection(e[1].split('').toSet())
            .intersection(e[2].split('').toSet())
            .first;
      })
      .map((e) => e.codeUnits.first <= 'Z'.codeUnits.first
          ? e.codeUnits.first - 'A'.codeUnits.first + 27
          : e.codeUnits.first - 'a'.codeUnits.first + 1)
      .sum();
}
