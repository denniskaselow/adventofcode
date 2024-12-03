import 'package:collection/collection.dart';

import '../utils.dart';

List<Input> _processInput(Input input) => input.getLines();

int day03star1(Input input) {
  final result =
      _processInput(input)
          .map(
            (line) =>
                RegExp(r'mul\((\d+),(\d+)\)').allMatches(line).map((match) {
                  final [a, b] =
                      match
                          .groups([1, 2])
                          .map((number) => int.parse(number!))
                          .toList();
                  return a * b;
                }).sum,
          )
          .sum;

  return result;
}

int day03star2(Input input) {
  var rememberDont = false;
  final result =
      _processInput(input).map((line) {
        final ranges = <(int, int)>[
          if (!rememberDont) (0, RegExp(r"don't\(\)").firstMatch(line)!.end),
        ];
        RegExp(r"do\(\).*?don't\(\)")
            .allMatches(line)
            .map((match) => (match.start, match.end))
            .forEach(ranges.add);
        final lastDo = RegExp(r'do\(\)')
            .allMatches(line)
            .map((match) => match.end)
            .firstWhereOrNull((pos) => pos > ranges.last.$2);

        if (lastDo != null) {
          ranges.add((lastDo, line.length));
          rememberDont = false;
        } else {
          rememberDont = true;
        }

        var minNext = 0;
        var sum = 0;
        for (final (start, end) in ranges) {
          if (start >= minNext) {
            sum +=
                RegExp(
                  r'mul\((\d+),(\d+)\)',
                ).allMatches(line.substring(start, end)).map((match) {
                  final [a, b] =
                      match
                          .groups([1, 2])
                          .map((number) => int.parse(number!))
                          .toList();
                  return a * b;
                }).sum;
            minNext = end;
          }
        }

        return sum;
      }).sum;

  return result;
}
