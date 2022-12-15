import 'dart:math';

import 'package:collection/collection.dart';

int day15star1(String input) {
  const yToCheck = 2000000;
  return getLineCoverage(_processInput(input), yToCheck)
      .line
      .map((e) => e.width)
      .sum;
}

LineCoverage getLineCoverage(
        Iterable<List<Point<int>>> processInput, int yToCheck) =>
    processInput.fold(LineCoverage(), (previousValue, element) {
      final sensor = element[0];
      final beacon = element[1];
      final dist = sensor.manhattenDistance(beacon);
      final deltaYCheck = (yToCheck - sensor.y).abs();
      if ((yToCheck - sensor.y).abs() < dist) {
        final left = sensor.x - dist + deltaYCheck;
        final width = (dist - deltaYCheck) * 2;
        previousValue.add(Rectangle(left, yToCheck, width, 1));
      }
      return previousValue;
    });

int day15star2(String input) {
  final sbPairs = _processInput(input);
  var y = 0;
  while (y <= 4000000) {
    final line = getLineCoverage(sbPairs, y).line;
    if (line.length > 1) {
      line.sort((a, b) => a.left - b.left);
      final x = line.first.right + 1;
      final y = line.first.top;
      return x * 4000000 + y;
    }
    y++;
  }
  throw Exception('no result found');
}

Iterable<List<Point<int>>> _processInput(String input) => input
    .split('\n')
    .map((e) => e.split(':').map((e) =>
        e.split('at')[1].split(',').map((e) => int.parse(e.split('=')[1]))))
    .map((e) =>
        [Point(e.first.first, e.first.last), Point(e.last.first, e.last.last)]);

extension ManhattenDistance on Point<int> {
  int manhattenDistance(Point<int> other) =>
      (x - other.x).abs() + (y - other.y).abs();
}

class LineCoverage {
  List<Rectangle<int>> line = [];

  void add(Rectangle<int> section) {
    _add(section, 0);
  }

  void _add(Rectangle<int> section, int index) {
    Rectangle<int>? boundingBox;
    for (var i = 0; i < line.length; i++) {
      final current = line[i];
      if (current.intersects(section)) {
        boundingBox = current.boundingBox(section);
        line.removeAt(i);
        _add(boundingBox, i);
        break;
      }
    }
    if (boundingBox == null) {
      line.add(section);
    }
  }
}
