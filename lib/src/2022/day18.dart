import 'dart:math';

int day18star1(String input) {
  final cubes = _processInput(input);
  var touching = 0;
  for (var i = 0; i < cubes.length; i++) {
    for (var j = 0; j < cubes.length; j++) {
      final distance = (cubes[i].x - cubes[j].x).abs() +
          (cubes[i].y - cubes[j].y).abs() +
          (cubes[i].z - cubes[j].z).abs();
      if (distance == 1) {
        touching++;
      }
    }
  }
  return cubes.length * 6 - touching;
}

int day18star2(String input) {
  final cubes = _processInput(input);
  final cubeSet = cubes.toSet();
  final maxValues = [0, 0, 0];
  for (final cube in cubes) {
    maxValues[0] = max(cube.x, maxValues[0]);
    maxValues[1] = max(cube.y, maxValues[1]);
    maxValues[2] = max(cube.z, maxValues[2]);
  }
  final visited = <Cube>{};
  final frontier = [Cube(0, 0, 0)];
  final directions = [
    [1, 0, 0],
    [-1, 0, 0],
    [0, 1, 0],
    [0, -1, 0],
    [0, 0, 1],
    [0, 0, -1],
  ];
  while (frontier.isNotEmpty) {
    final next = frontier.removeLast();
    visited.add(next);
    for (final direction in directions) {
      final nextCube = Cube(
        next.x + direction[0],
        next.y + direction[1],
        next.z + direction[2],
      );
      if (nextCube.x >= -1 &&
          nextCube.y >= -1 &&
          nextCube.z >= -1 &&
          nextCube.x <= maxValues[0] + 1 &&
          nextCube.y <= maxValues[1] + 1 &&
          nextCube.z <= maxValues[2] + 1) {
        if (!cubeSet.contains(nextCube) && !visited.contains(nextCube)) {
          frontier.add(nextCube);
        }
      }
    }
  }
  var touchingWater = 0;
  for (final cube in cubes) {
    for (final water in visited) {
      final distance = (water.x - cube.x).abs() +
          (water.y - cube.y).abs() +
          (water.z - cube.z).abs();
      if (distance == 1) {
        touchingWater++;
      }
    }
  }
  return touchingWater;
}

List<Cube> _processInput(String input) => input
    .split('\n')
    .map((e) => e.split(',').map(int.parse).toList())
    .map((e) => Cube(e[0], e[1], e[2]))
    .toList();

class Cube {
  Cube(this.x, this.y, this.z);
  final int x;
  final int y;
  final int z;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Cube &&
          runtimeType == other.runtimeType &&
          x == other.x &&
          y == other.y &&
          z == other.z;

  @override
  int get hashCode => x.hashCode ^ y.hashCode ^ z.hashCode;
}
