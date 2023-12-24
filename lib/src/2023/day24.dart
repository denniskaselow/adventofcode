import 'dart:math';

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

int day24star2(String input) => 0;
