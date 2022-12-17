import 'dart:math';

import 'package:collection/collection.dart';

int day17star1(String input) => simulateRockfall(input, 2022);
int day17star2(String input) => simulateRockfall(input, 1000000000000);

int simulateRockfall(String input, int maxRocks) {
  final movements = _processInput(input);
  final maxGusts = movements.length;
  var highest = 1;
  var gustCount = 0;
  final area = List<List<bool>>.generate(1, (y) => List<bool>.filled(9, true));
  final fieldState = [FieldData(0, highest)];
  final fieldDiff = <FieldData>[];
  var skippedAhead = false;
  var skipHeight = 0;
  const drop = Point(0, -1);
  for (var rockCount = 0; rockCount < maxRocks; rockCount++) {
    while (area.length < highest + 4) {
      area.add(
          List<bool>.generate(9, (x) => x == 0 || x == 8, growable: false));
    }
    final rock = Rocks.values[rockCount % 5];
    var leftBottom = Point<int>(3, highest + 3);
    var contact = false;
    while (!contact) {
      final wind = movements[gustCount++ % maxGusts];
      leftBottom = blowWind(leftBottom, wind, rock) + drop;
      if (leftBottom.y == highest) {
        contact = true;
      }
    }
    var stopped = false;
    while (!stopped) {
      final wind = movements[gustCount++ % maxGusts];
      var isBlowable = true;
      for (final pos in rock.shape) {
        if (area[leftBottom.y + pos.y][leftBottom.x + pos.x + wind.x]) {
          isBlowable = false;
          break;
        }
      }
      if (isBlowable) {
        leftBottom = leftBottom + wind;
      }
      for (final pos in rock.shape) {
        if (area[leftBottom.y + pos.y - 1][leftBottom.x + pos.x]) {
          stopped = true;
          break;
        }
      }
      if (!stopped) {
        leftBottom += drop;
      } else {
        for (final pos in rock.shape) {
          area[leftBottom.y + pos.y][leftBottom.x + pos.x] = true;
        }
      }
    }
    highest = max(highest, rock.shape.last.y + leftBottom.y + 1);

    if (!skippedAhead) {
      if (rockCount % Rocks.values.length == 0) {
        fieldDiff.add(FieldData(rockCount - fieldState.last.rocks,
            highest - fieldState.last.height));
        fieldState.add(FieldData(rockCount, highest));
        if (gustCount > maxGusts * 3) {
          final maxWindowLength = fieldDiff.length ~/ 3;
          var foundWindow = false;
          for (var windowStart = 0;
              windowStart < maxWindowLength && !foundWindow;
              windowStart++) {
            var nextIndex =
                fieldDiff.indexOf(fieldDiff[windowStart], windowStart + 1);
            while (!foundWindow &&
                nextIndex != -1 &&
                nextIndex - windowStart > 5 &&
                nextIndex - windowStart < maxWindowLength) {
              final windowLength = nextIndex - windowStart;
              final window1 =
                  fieldDiff.skip(windowStart).take(windowLength).toList();
              final window2 =
                  fieldDiff.skip(nextIndex).take(windowLength).toList();
              if (window1.equals(window2)) {
                skippedAhead = true;
                foundWindow = true;
                final totalRockDiff = window1.map((e) => e.rocks).sum;
                final totalHeightDiff = window1.map((e) => e.height).sum;
                final remainingRocks = maxRocks - rockCount;
                final factor = remainingRocks ~/ totalRockDiff;
                skipHeight = factor * totalHeightDiff;
                rockCount += totalRockDiff * factor;
              }
              nextIndex =
                  fieldDiff.indexOf(fieldDiff[windowStart], nextIndex + 1);
            }
          }
        }
      }
    }
  }
  return highest - 1 + skipHeight;
}

class FieldData {
  final int rocks;
  final int height;
  const FieldData(this.rocks, this.height);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FieldData &&
          runtimeType == other.runtimeType &&
          rocks == other.rocks &&
          height == other.height;

  @override
  int get hashCode => rocks.hashCode ^ height.hashCode;
}

Point<int> blowWind(Point<int> leftBottom, Point<int> wind, Rocks rock) {
  var nextPos = leftBottom + wind;
  if (nextPos.x + rock.width == 9 || nextPos.x == 0) {
    nextPos -= wind;
  }
  return nextPos;
}

List<Point<int>> _processInput(String input) => input
    .split('')
    .map((e) => const [Point<int>(-1, 0), Point<int>(1, 0)]['<>'.indexOf(e)])
    .toList();

enum Rocks {
  first(
      [Point<int>(0, 0), Point<int>(1, 0), Point<int>(2, 0), Point<int>(3, 0)],
      4),
  second(
      [Point<int>(1, 0), Point<int>(0, 1), Point<int>(2, 1), Point<int>(1, 2)],
      3),
  third([
    Point<int>(0, 0),
    Point<int>(1, 0),
    Point<int>(2, 0),
    Point<int>(2, 1),
    Point<int>(2, 2)
  ], 3),
  fourth(
      [Point<int>(0, 0), Point<int>(0, 1), Point<int>(0, 2), Point<int>(0, 3)],
      1),
  fifth(
      [Point<int>(0, 0), Point<int>(1, 0), Point<int>(0, 1), Point<int>(1, 1)],
      2);

  final List<Point<int>> shape;
  final int width;
  const Rocks(this.shape, this.width);
}
