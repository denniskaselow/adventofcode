import 'dart:math';

import 'package:collection/collection.dart';

import '../utils.dart';

Iterable<String> _processInput(String input) => input.getLines();

typedef HailPath = ({num x1, num y1, num x2, num y2});
typedef HailVector = ({int x, int y, int z, int vx, int vy, int vz});

int day24star1(
  String input, [
  int start = 200000000000000,
  int end = 400000000000000,
]) {
  final result = _processInput(input).map(
    (line) => line
        .split(RegExp('[,@]'))
        .map((cell) => int.parse(cell.trim()))
        .toList(),
  );

  final path = <HailPath>[];
  for (final [px, py, _, vx, vy, _] in result) {
    const startMult = 0;

    final xEnd = ((vx < 0 ? start : end) - px) / vx;
    final yEnd = ((vy < 0 ? start : end) - py) / vy;
    final endMult = min(xEnd, yEnd);

    final x1 = px + startMult * vx;
    final y1 = py + startMult * vy;
    final x2 = px + endMult * vx;
    final y2 = py + endMult * vy;

    path.add((x1: x1, y1: y1, x2: x2, y2: y2));
  }

  var intersections = 0;
  for (var i = 0; i < path.length; i++) {
    for (var j = i + 1; j < path.length; j++) {
      final path1 = path[i];
      final path2 = path[j];

      final px =
          ((path1.x1 * path1.y2 - path1.y1 * path1.x2) * (path2.x1 - path2.x2) -
                  (path1.x1 - path1.x2) *
                      (path2.x1 * path2.y2 - path2.y1 * path2.x2)) /
              ((path1.x1 - path1.x2) * (path2.y1 - path2.y2) -
                  (path1.y1 - path1.y2) * (path2.x1 - path2.x2));

      final py =
          ((path1.x1 * path1.y2 - path1.y1 * path1.x2) * (path2.y1 - path2.y2) -
                  (path1.y1 - path1.y2) *
                      (path2.x1 * path2.y2 - path2.y1 * path2.x2)) /
              ((path1.x1 - path1.x2) * (path2.y1 - path2.y2) -
                  (path1.y1 - path1.y2) * (path2.x1 - path2.x2));

      if (px >= start &&
          py >= start &&
          px <= end &&
          py <= end &&
          (px >= path1.x1 && px <= path1.x2 ||
              px >= path1.x2 && px <= path1.x1) &&
          (px >= path2.x1 && px <= path2.x2 ||
              px >= path2.x2 && px <= path2.x1)) {
        intersections++;
      }
    }
  }
  return intersections;
}

// solution based on https://www.reddit.com/r/adventofcode/comments/18pnycy/2023_day_24_solutions/keqf8uq/
int day24star2(String input) {
  final hailstones = _processInput(input)
      .map(
        (line) => line
            .split(RegExp('[,@]'))
            .map((cell) => int.parse(cell.trim()))
            .toList(),
      )
      .map((e) => (x: e[0], y: e[1], z: e[2], vx: e[3], vy: e[4], vz: e[5]))
      .toList();

  final groupX = <int, List<HailVector>>{};
  final groupY = <int, List<HailVector>>{};
  final groupZ = <int, List<HailVector>>{};
  for (final hailstone in hailstones) {
    groupX.putIfAbsent(hailstone.vx, () => []).add(hailstone);
    groupY.putIfAbsent(hailstone.vy, () => []).add(hailstone);
    groupZ.putIfAbsent(hailstone.vz, () => []).add(hailstone);
  }

  final rockVx =
      getBestMatchForVelocity(groupX, (a, b) => a.x - b.x, (a) => a.vx);
  final rockVy =
      getBestMatchForVelocity(groupY, (a, b) => a.y - b.y, (a) => a.vy);
  final rockVz =
      getBestMatchForVelocity(groupZ, (a, b) => a.z - b.z, (a) => a.vz);

  final a = hailstones.first;
  final b = hailstones.last;
  final ma = (a.vy - rockVy) / (a.vx - rockVx);
  final mb = (b.vy - rockVy) / (b.vx - rockVx);
  final ca = a.y - (ma * a.x);
  final cb = b.y - (mb * b.x);
  final rockX = (cb - ca) ~/ (ma - mb);
  final rockY = (ma * rockX + ca).toInt();
  final time = (rockX - a.x) ~/ (a.vx - rockVx);
  final rockZ = a.z + (a.vz - rockVz) * time;

  return rockX + rockY + rockZ;
}

int getBestMatchForVelocity(
  Map<int, List<HailVector>> group,
  int Function(HailVector a, HailVector b) getDiff,
  int Function(HailVector a) getHailV,
) {
  final counts = <int, int>{};
  for (final hailstones in group.values) {
    if (hailstones.length > 1) {
      final base = hailstones.first;
      for (final hailstone in hailstones.skip(1)) {
        final diff = getDiff(base, hailstone).abs();
        for (var v = -1000; v < 1000; v++) {
          if (v - getHailV(hailstone) != 0 &&
              diff % (v - getHailV(hailstone)) == 0) {
            counts.update(v, (value) => value + 1, ifAbsent: () => 1);
          }
        }
      }
    }
  }
  final sortedCounts =
      counts.entries.sorted((a, b) => b.value.compareTo(a.value));

  return sortedCounts.first.key;
}
