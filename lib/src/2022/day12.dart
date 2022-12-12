import '../utils.dart';

int day12star1(String input) => travel(input, 'S');
int day12star2(String input) => travel(input, 'a');

List<List<int>> _processInput(String input) =>
    input.split('\n').map((e) => e.codeUnits.toList()).toList();

int travel(String input, String startElevation) {
  final grid = _processInput(input);
  var open = <Pos>[];
  var end = Pos(0, 0, 0);
  for (var y = 0; y < grid.length; y++) {
    if (grid[y].contains(startElevation.codeUnitAt(0))) {
      open.add(Pos(grid[y].indexOf(startElevation.codeUnitAt(0)), y, 0));
      if (startElevation == 'S') {
        grid[y][open.last.x] = 'a'.codeUnitAt(0);
      }
    }
    if (grid[y].contains('E'.codeUnitAt(0))) {
      end = Pos(grid[y].indexOf('E'.codeUnitAt(0)), y, 0);
      grid[y][end.x] = 'z'.codeUnitAt(0);
    }
  }
  final visited = <Pos>[];
  open.sort((a, b) => end.distance(a) - end.distance(b));
  final steps = findPath(grid, open.removeLast(), end, visited, open, 0);
  return steps.first.steps;
}

List<Pos> findPath(List<List<int>> grid, Pos start, Pos end, List<Pos> visited,
    List<Pos> open, int steps) {
  if (visited.contains(start)) {
    return [];
  }
  visited.add(start);
  if (start == end) {
    return [start];
  }
  final targets = <Pos>[];
  for (final direction in Direction.values) {
    var target = Pos(start.x + direction.x, start.y + direction.y, steps + 1);
    if (target.x < 0 ||
        target.y < 0 ||
        target.x >= grid[0].length ||
        target.y >= grid.length) {
    } else if (grid[target.y][target.x] <= grid[start.y][start.x] + 1) {
      if (!visited.contains(target)) {
        targets.add(target);
      }
    }
  }
  targets.sort((a, b) => end.distance(a) - end.distance(b));
  open.insertAll(0, targets);
  do {
    final target = open.removeLast();

    final path = findPath(grid, target, end, visited, open, target.steps);
    if (path.isNotEmpty) {
      return path..add(start);
    }
  } while (open.isNotEmpty);
  return [];
}

class Pos {
  int x;
  int y;
  int steps;

  Pos(this.x, this.y, this.steps);

  int distance(Pos other) => steps + (other.x - x).abs() + (other.y - y).abs();

  @override
  String toString() {
    return '$x:$y ($steps)';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Pos &&
          runtimeType == other.runtimeType &&
          x == other.x &&
          y == other.y;

  @override
  int get hashCode => x.hashCode ^ y.hashCode;
}
