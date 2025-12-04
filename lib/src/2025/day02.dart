import 'package:collection/collection.dart';

import '../utils.dart';

Iterable<({String first, String last})> _processInput(Input input) => input
    .split(',')
    .map((e) => e.split('-').toList())
    .map((e) => (first: e.first, last: e.last));

int day02star1(Input input) {
  final result = _processInput(input).map(
    (line) => switch (line) {
      (:final first, :final last)
          when first.length.isOdd && first.length == last.length =>
        0,
      (:final first, :final last) => _invalidIds(first, last).sum,
    },
  );
  return result.sum;
}

List<int> _invalidIds(
  String first,
  String last, {
  bool multipleRepetitions = false,
}) {
  final result = <int>[];
  final start = int.parse(first);
  final end = int.parse(last);
  for (var current = start; current <= end; current++) {
    final asString = '$current';
    if (multipleRepetitions) {
      for (
        var substringLength = 1;
        substringLength <= asString.length ~/ 2;
        substringLength++
      ) {
        if (asString.length % substringLength != 0) {
          continue;
        }
        final parts = <String>[];
        for (
          var part = 0;
          part * substringLength < asString.length;
          part += 1
        ) {
          parts.add(
            asString.substring(
              part * substringLength,
              (part + 1) * substringLength,
            ),
          );
        }

        if (parts.every((element) => element == parts.first)) {
          result.add(current);
          break;
        }
      }
    } else {
      final part1 = asString.substring(0, asString.length ~/ 2);
      final part2 = asString.substring(asString.length ~/ 2);
      if (part1 == part2) {
        result.add(current);
      }
    }
  }
  return result;
}

int day02star2(Input input) {
  final result = _processInput(input).map(
    (line) => _invalidIds(line.first, line.last, multipleRepetitions: true).sum,
  );
  return result.sum;
}
