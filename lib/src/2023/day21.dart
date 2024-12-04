import '../utils.dart';

Iterable<String> _processInput(Input input) => input.getLines();

typedef Coords = ({int x, int y});
typedef Grid = Map<Coords, String>;

int day21star1(Input input, [int maxSteps = 64]) {
  final lines = _processInput(input);
  final maxX = lines.first.length;
  final maxY = lines.length;
  late Coords start;
  final grid = lines.indexed.fold(Grid(), (grid, line) {
    line.$2.split('').indexed.forEach((cell) {
      final pos = (x: cell.$1, y: line.$1);
      if (cell.$2 == 'S') {
        start = pos;
      }
      grid[pos] = cell.$2;
    });
    return grid;
  });

  final open = [start];
  final visited = <({int x, int y})>{};
  final steps = <Coords, int>{};
  steps[start] = -1;
  while (open.isNotEmpty) {
    final current = open.removeAt(0);
    final currentSteps = steps[current]!;
    final nextSteps = currentSteps + 1;
    if (currentSteps <= maxSteps) {
      if (visited.add((x: current.x, y: current.y))) {
        for (final direction in Direction.plus) {
          final next = (x: current.x + direction.x, y: current.y + direction.y);
          if (!visited.contains((x: next.x, y: next.y)) &&
              next.x >= 0 &&
              next.x < maxX &&
              next.y >= 0 &&
              next.y < maxY &&
              grid[next] != '#') {
            open.add(next);
            steps[next] = nextSteps;
          }
        }
      }
    } else {
      break;
    }
  }
  var count = 0;
  for (final MapEntry(key: pos, value: cell) in grid.entries) {
    final distance = (start.x - pos.x).abs() + (start.y - pos.y).abs();
    if (distance <= maxSteps &&
        distance % 2 == maxSteps % 2 &&
        cell != '#' &&
        visited.contains(pos)) {
      count++;
    }
  }

  return count;
}

int day21star2(Input input, [int maxSteps = 26501365]) {
  final lines = _processInput(input);
  final maxX = lines.first.length;
  final maxY = lines.length;
  late Coords start;
  final grid = lines.indexed.fold(Grid(), (grid, line) {
    line.$2.split('').indexed.forEach((cell) {
      final pos = (x: cell.$1, y: line.$1);
      var currentCell = cell.$2;
      if (currentCell == 'S') {
        start = pos;
        currentCell = '.';
      }
      grid[pos] = currentCell;
    });
    return grid;
  });

  final open = [start];
  final visited = <({int x, int y})>{};
  final steps = <Coords, int>{};
  steps[start] = -1;
  var stepCountCurrent = -1;
  var lastCount = 0;
  var lastDiff = 0;
  var diffDiff = 0;
  var cycleStart = 0;
  final cycleLength = maxX * 2;
  final gridOffsets = <Coords>{};
  while (open.isNotEmpty && cycleStart == 0) {
    final current = open.removeAt(0);
    final currentSteps = steps[current]!;
    if (currentSteps != stepCountCurrent) {
      if (maxSteps % cycleLength == currentSteps % cycleLength) {
        var count = 0;
        for (final (:x, :y) in visited) {
          final distance = (start.x - x).abs() + (start.y - y).abs();
          final cell = grid[(x: x % maxX, y: y % maxY)];
          if (distance <= maxSteps &&
              distance % 2 == maxSteps % 2 &&
              cell != '#') {
            count++;
          }
        }
        if ((count - lastCount) - lastDiff == diffDiff) {
          cycleStart = currentSteps;
        }
        diffDiff = (count - lastCount) - lastDiff;
        lastDiff = count - lastCount;
        lastCount = count;
      }
      stepCountCurrent++;
    }
    final nextSteps = currentSteps + 1;
    if (currentSteps <= maxSteps) {
      if (visited.add((x: current.x, y: current.y))) {
        for (final direction in Direction.plus) {
          final next = (x: current.x + direction.x, y: current.y + direction.y);
          final nextMod = (
            x: (current.x + direction.x) % maxX,
            y: (current.y + direction.y) % maxY
          );
          if (!visited.contains((x: next.x, y: next.y)) &&
              grid[nextMod] != '#') {
            open.add(next);
            steps[next] = nextSteps;
            gridOffsets.add(
              (
                x: next.x < 0 ? next.x ~/ maxX - 1 : next.x ~/ maxX,
                y: next.y < 0 ? next.y ~/ maxY - 1 : next.y ~/ maxY,
              ),
            );
          }
        }
      }
    } else {
      break;
    }
  }
  var count = 0;
  final cycles = (maxSteps - cycleStart) ~/ cycleLength;
  final checkUpTo = cycleStart;
  for (final (:x, :y) in visited) {
    final distance = (start.x - x).abs() + (start.y - y).abs();
    final cell = grid[(x: x % maxX, y: y % maxY)];
    if (distance <= checkUpTo && distance % 2 == maxSteps % 2 && cell != '#') {
      count++;
    }
  }
  var add = lastDiff + diffDiff;
  for (var i = 0; i < cycles; i++) {
    count += add;
    add += diffDiff;
  }

  return count;
}
