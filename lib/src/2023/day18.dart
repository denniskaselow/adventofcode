import 'dart:math';

import 'package:collection/collection.dart';
import 'package:more/more.dart';

import '../utils.dart';

typedef Grid = Map<({int x, int y}), String>;

Iterable<String> _processInput(Input input) => input.getLines();

int day18star1(Input input) {
  final instructions = _processInput(input).map((line) {
    final converted =
        RegExp(r'^(?<direction>[RLUD]) (?<count>\d+)').allMatches(line);
    final match = converted.first;
    return (
      direction: switch (match.namedGroup('direction')) {
        'U' => Direction.n,
        'D' => Direction.s,
        'L' => Direction.w,
        'R' => Direction.e,
        final _ => throw Exception('invalid input $line'),
      },
      count: int.parse(match.namedGroup('count')!)
    );
  });

  final grid = Grid();
  var x = 0;
  var y = 0;
  var minX = 0;
  var minY = 0;
  var maxX = 0;
  var maxY = 0;
  grid[(x: x, y: y)] = '#';
  var lastVertical = instructions.last.direction;
  for (final instruction in instructions) {
    for (var count = 0; count < instruction.count; count++) {
      x = x + instruction.direction.x;
      y = y + instruction.direction.y;
      if (instruction.direction == Direction.n ||
          instruction.direction == Direction.s) {
        if (lastVertical != instruction.direction) {
          grid[(x: x, y: y - instruction.direction.y)] = '|';
        }
        grid[(x: x, y: y)] = '|';
        lastVertical = instruction.direction;
      } else {
        grid[(x: x, y: y)] = '#';
      }

      minX = min(x, minX);
      minY = min(y, minY);
      maxX = max(x, maxX);
      maxY = max(y, maxY);
    }
  }
  final filledGrid = Grid();
  for (y = minY; y <= maxY; y++) {
    var fill = false;
    for (x = minX; x <= maxX; x++) {
      if (grid[(x: x, y: y)] == '|') {
        filledGrid[(x: x, y: y)] = '#';
        fill = !fill;
      } else if (grid[(x: x, y: y)] == '#') {
        filledGrid[(x: x, y: y)] = '#';
      } else if (fill) {
        filledGrid[(x: x, y: y)] = '#';
      }
    }
  }
  return filledGrid.length;
}

typedef Coords = ({int x, int y});

int day18star2(Input input) {
  var x = 0;
  var y = 0;
  var border = 0;
  final coordinates = _processInput(input).map((line) {
    final converted =
        RegExp(r'\(#(?<count>[a-f0-9]{5})(?<direction>[a-f0-9]{1})\)')
            .allMatches(line);
    final match = converted.first;
    return (
      direction: switch (match.namedGroup('direction')) {
        '3' => Direction.n,
        '1' => Direction.s,
        '2' => Direction.w,
        '0' => Direction.e,
        final _ => throw Exception('invalid input $line'),
      },
      count: int.parse(match.namedGroup('count')!, radix: 16)
    );
  }).map((instruction) {
    x += instruction.direction.x * instruction.count;
    y += instruction.direction.y * instruction.count;
    border += instruction.count;
    return (x: x, y: y);
  }).toList();

  // https://en.wikipedia.org/wiki/Shoelace_formula
  final internal = coordinates.window(2).map((e) {
        final first = e.first;
        final second = e.last;
        return first.x * second.y - first.y * second.x;
      }).sum ~/
      2;

  // https://en.wikipedia.org/wiki/Pick%27s_theorem
  // no idea why I need to add 1 instead of subtract 1
  return internal + border ~/ 2 + 1;
}
