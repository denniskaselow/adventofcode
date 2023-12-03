import 'package:collection/collection.dart';

import '../utils.dart';

typedef PartId = ({int line, int start, int end, int number});

Iterable<String> _processInput(String input) => input.lines;

int day03star1(String input) {
  const invalidSymbol = '0123456789.';
  final data = <(int, int, int), int>{};
  final lines = _processInput(input).indexed;
  for (final (y, line) in lines) {
    final pattern = RegExp(r'(?<number>\d+)+');
    for (final match in pattern.allMatches(line)) {
      if (int.tryParse(match.namedGroup('number') ?? '') case final number?) {
        var isValid = false;
        for (var x = match.start; x < match.end && !isValid; x++) {
          for (final direction in DirectionSquare.values) {
            if (y + direction.y >= 0 &&
                y + direction.y < lines.length &&
                x + direction.x >= 0 &&
                x + direction.x < line.length &&
                !invalidSymbol
                    .contains(input.lines[y + direction.y][x + direction.x])) {
              isValid = true;
            }
          }
        }
        if (isValid) {
          data[(y, match.start, match.end)] = number;
        }
      }
    }
  }
  return data.values.sum;
}

int day03star2(String input) {
  const invalidSymbol = '0123456789.';
  final data = <(int, int), PartId>{};
  final lines = _processInput(input).toList();
  final products = <int>[];
  for (final (y, line) in lines.indexed) {
    final pattern = RegExp(r'(?<number>\d+)+');
    for (final match in pattern.allMatches(line)) {
      if (int.tryParse(match.namedGroup('number') ?? '') case final number?) {
        var isValid = false;
        for (var x = match.start; x < match.end && !isValid; x++) {
          for (final direction in DirectionSquare.values) {
            if (y + direction.y >= 0 &&
                y + direction.y < lines.length &&
                x + direction.x >= 0 &&
                x + direction.x < line.length &&
                !invalidSymbol
                    .contains(lines[y + direction.y][x + direction.x])) {
              isValid = true;
            }
          }
        }
        if (isValid) {
          for (var x = match.start; x < match.end; x++) {
            data[(y, x)] =
                (line: y, start: match.start, end: match.end, number: number);
          }
        }
      }
    }
  }

  const validSymbol = '0123456789';
  for (final (y, line) in lines.indexed) {
    const gearPattern = '*';
    for (final match in gearPattern.allMatches(line)) {
      final parts = <PartId>{};
      for (var x = match.start; x < match.end; x++) {
        for (final direction in DirectionSquare.values) {
          if (y + direction.y >= 0 &&
              y + direction.y < lines.length &&
              x + direction.x >= 0 &&
              x + direction.x < line.length &&
              validSymbol.contains(lines[y + direction.y][x + direction.x])) {
            parts.add(data[(y + direction.y, x + direction.x)]!);
          }
        }
      }
      if (parts.length == 2) {
        products.add(parts.first.number * parts.last.number);
      }
    }
  }
  return products.sum;
}
