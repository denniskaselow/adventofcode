import 'dart:math';

import 'package:collection/collection.dart';

import '../utils.dart';

int day15star1(String input) {
  const yToCheck = 2000000;
  return getLineCoverage(_processInput(input), yToCheck)
      .line
      .map((e) => e.width)
      .sum;
}

LineCoverage getLineCoverage(
  Iterable<List<Point<int>>> processInput,
  int yToCheck,
) =>
    processInput.fold(LineCoverage(), (previousValue, element) {
      final sensor = element[0];
      final beacon = element[1];
      final dist = sensor.manhattanDistance(beacon);
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
  const size = 4000000;
  final linesNwSe = <Line>[];
  final linesSwNe = <Line>[];
  for (final pair in sbPairs) {
    final sensor = pair[0];
    final beacon = pair[1];
    final dist = sensor.manhattanDistance(beacon) + 1;
    final lineNwSe = Line(
      Point(sensor.x + 1, sensor.y + dist - 1),
      Point(sensor.x + dist, sensor.y),
    );
    final lineNwSe2 = Line(
      Point(sensor.x - dist, sensor.y),
      Point(sensor.x - 1, sensor.y - dist + 1),
    );
    linesNwSe.addAll([lineNwSe, lineNwSe2]);
    final lineSwNe = Line(
      Point(sensor.x, sensor.y - dist),
      Point(sensor.x + dist - 1, sensor.y - 1),
    );
    final lineSwNe2 = Line(
      Point(sensor.x - dist + 1, sensor.y + 1),
      Point(sensor.x, sensor.y + dist),
    );
    linesSwNe.addAll([lineSwNe, lineSwNe2]);
  }
  final candidates = <Point<int>>{};
  for (final lineNwSe in linesNwSe) {
    for (final lineSwNe in linesSwNe) {
      final intersection = lineNwSe.intersection(lineSwNe);
      if (intersection != null) {
        final candidateX = intersection.x;
        final candidateY = intersection.y;
        if (candidateX >= 0 &&
            candidateY >= 0 &&
            candidateX <= size &&
            candidateY <= size) {
          candidates.add(intersection);
        }
      }
    }
  }
  for (final pair in sbPairs) {
    final notCandidates = <Point<int>>{};
    for (final candidate in candidates) {
      final sensor = pair[0];
      final beacon = pair[1];
      final dist = sensor.manhattanDistance(beacon);
      final candidateDist = sensor.manhattanDistance(candidate);
      if (candidateDist <= dist) {
        notCandidates.add(candidate);
      }
    }
    candidates.removeAll(notCandidates);
  }
  return candidates.first.x * 4000000 + candidates.first.y;
}

Iterable<List<Point<int>>> _processInput(String input) => input.lines
    .map(
      (e) => e.split(':').map(
            (e) => e
                .split('at')[1]
                .split(',')
                .map((e) => int.parse(e.split('=')[1])),
          ),
    )
    .map(
      (e) => [
        Point(e.first.first, e.first.last),
        Point(e.last.first, e.last.last),
      ],
    );

extension ManhattanDistance on Point<int> {
  int manhattanDistance(Point<int> other) =>
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

class Line {
  Line(this.from, this.to);
  final Point<int> from;
  final Point<int> to;

  Point<int>? intersection(Line other) {
    final x1 = from.x;
    final x2 = to.x;
    final x3 = other.from.x;
    final x4 = other.to.x;

    final y1 = from.y;
    final y2 = to.y;
    final y3 = other.from.y;
    final y4 = other.to.y;

    final t = ((x1 - x3) * (y3 - y4) - (y1 - y3) * (x3 - x4)) /
        ((x1 - x2) * (y3 - y4) - (y1 - y2) * (x3 - x4));

    if (t >= 0 && t <= 1) {
      return Point((x1 + t * (x2 - x1)).toInt(), (y1 + t * (y2 - y1)).toInt());
    } else {
      return null;
    }
  }

  @override
  String toString() => 'Line{from: $from, to: $to}';
}
