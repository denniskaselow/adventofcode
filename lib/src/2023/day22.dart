import 'dart:math';

import 'package:collection/collection.dart';

import '../utils.dart';

typedef Coords = ({int x, int y, int z});

class Brick {
  Brick(this.id, this.start, Coords end)
      : length = end.x - start.x + 1,
        width = end.y - start.y + 1,
        height = end.z - start.z + 1;
  int id;
  Coords start;
  int length;
  int width;
  int height;

  int get endZ => start.z + height;

  bool canBeSupportedBy(Brick other) {
    final intersection =
        Rectangle(start.x, start.y, length, width).intersection(
      Rectangle(
        other.start.x,
        other.start.y,
        other.length,
        other.width,
      ),
    );
    return intersection != null &&
        intersection.width > 0 &&
        intersection.height > 0;
  }

  void moveDown(int z) {
    start = (x: start.x, y: start.y, z: start.z - z);
  }
}

int day22star1(Input input) {
  final bricks = getBricks(input);

  final bricksByEndZ = <int, List<Brick>>{};
  final supportedBy = <int, Set<int>>{};
  final supporting = <int, Set<int>>{};

  initMaps(bricks, bricksByEndZ, supporting, supportedBy);

  var result = 0;
  for (final brick in bricks) {
    var canBeDisintegrated = true;
    for (final supportedBrick in supporting[brick.id] ?? {}) {
      if (supportedBy[supportedBrick] case final supporters?) {
        if (supporters.length == 1) {
          canBeDisintegrated = false;
          break;
        }
      } else {
        throw Exception('no supporters for $brick');
      }
    }
    if (canBeDisintegrated) {
      result++;
    }
  }
  return result;
}

int day22star2(Input input) {
  final bricks = getBricks(input);

  final bricksByEndZ = <int, List<Brick>>{};
  final supportedBy = <int, Set<int>>{};
  final supporting = <int, Set<int>>{};

  initMaps(bricks, bricksByEndZ, supporting, supportedBy);

  final totalSupporting = <int, Set<int>>{};
  for (final brick in bricks) {
    final open = {brick.id};
    final disintegrated = <int>{};
    while (open.isNotEmpty) {
      final currentBrick = open.first;
      open.remove(currentBrick);
      disintegrated.add(currentBrick);
      final allSupported = supporting[currentBrick] ?? {};
      for (final supported in allSupported) {
        if (supportedBy[supported] case final supporters?) {
          final remainingSupport = supporters.toSet()..removeAll(disintegrated);
          if (remainingSupport.isEmpty) {
            totalSupporting.update(
              brick.id,
              (value) => value..add(supported),
              ifAbsent: () => {supported},
            );
            open.add(supported);
          }
        }
      }
    }
  }
  return totalSupporting.values.map((e) => e.length).sum;
}

List<Brick> getBricks(Input input) {
  final bricks = input.getLines().indexed.map((line) {
    final [start, end] = line.$2.split('~').map((cell) {
      final [x, y, z] = cell.split(',').map(int.parse).toList();
      return (x: x, y: y, z: z);
    }).toList();
    return Brick(line.$1, start, end);
  }).sorted((a, b) => a.start.z.compareTo(b.start.z));
  return bricks;
}

void initMaps(
  List<Brick> bricks,
  Map<int, List<Brick>> bricksByEndZ,
  Map<int, Set<int>> supporting,
  Map<int, Set<int>> supportedBy,
) {
  for (var i = 0; i < bricks.length; i++) {
    final brick = bricks[i];
    var supportingZ = 1;
    for (var j = i - 1; j >= 0; j--) {
      final supportingBrick = bricks[j];
      if (supportingBrick.endZ <= brick.start.z) {
        if (brick.canBeSupportedBy(supportingBrick)) {
          supportingZ = max(supportingZ, supportingBrick.endZ);
        }
      }
    }
    final deltaZ = brick.start.z - supportingZ;
    brick.moveDown(deltaZ);
    bricksByEndZ.update(
      brick.endZ,
      (value) => value..add(brick),
      ifAbsent: () => [brick],
    );
    if (brick.start.z > 1) {
      for (final supporter in bricksByEndZ[brick.start.z]!) {
        if (brick.canBeSupportedBy(supporter)) {
          supporting.update(
            supporter.id,
            (value) => value..add(brick.id),
            ifAbsent: () => {brick.id},
          );
          supportedBy.update(
            brick.id,
            (value) => value..add(supporter.id),
            ifAbsent: () => {supporter.id},
          );
        }
      }
    }
  }
}
