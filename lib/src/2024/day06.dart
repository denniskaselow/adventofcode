import '../utils.dart';

Map<({int x, int y}), String> _processInput(Input input) => input
    .getLines()
    .indexed
    .map((line) => line.$2.split('').indexed.toList())
    .indexed
    .fold(<({int x, int y}), String>{}, (previousValue, element) {
      for (final cell in element.$2) {
        previousValue[(x: cell.$1, y: element.$1)] = cell.$2;
      }
      return previousValue;
    });

int day06star1(Input input) {
  final grid = _processInput(input);
  var guardCell = grid.entries.firstWhere((entry) => entry.value == '^').key;
  var guardDirection = Direction.n;
  final visited = <({int x, int y})>{};
  while (grid.containsKey(guardCell)) {
    final nextCell = (
      x: guardCell.x + guardDirection.x,
      y: guardCell.y + guardDirection.y,
    );
    if (grid[nextCell] == '#') {
      guardDirection = guardDirection.nextClockwise;
    } else {
      visited.add(guardCell);
      guardCell = nextCell;
    }
  }

  return visited.length;
}

int day06star2(Input input) {
  final grid = _processInput(input);
  final start = grid.entries.firstWhere((entry) => entry.value == '^').key;
  var guardCell = start;
  var guardDirection = Direction.n;
  final visited = <({int x, int y})>{};
  while (grid.containsKey(guardCell)) {
    final nextCell = (
      x: guardCell.x + guardDirection.x,
      y: guardCell.y + guardDirection.y,
    );
    if (grid[nextCell] == '#') {
      guardDirection = guardDirection.nextClockwise;
    } else {
      visited.add(guardCell);
      guardCell = nextCell;
    }
  }
  var result = 0;
  for (final visitedCell in visited.skip(1)) {
    final tempGrid = Map<({int x, int y}), String>.from(grid);
    guardCell = start;
    guardDirection = Direction.n;
    final tempVisited = <({int x, int y, Direction dir})>{};
    tempGrid[visitedCell] = '#';
    while (tempGrid.containsKey(guardCell)) {
      final nextCell = (
        x: guardCell.x + guardDirection.x,
        y: guardCell.y + guardDirection.y,
      );
      if (tempGrid[nextCell] == '#') {
        guardDirection = guardDirection.nextClockwise;
      } else {
        final currentVisited = (
          x: guardCell.x,
          y: guardCell.y,
          dir: guardDirection,
        );
        if (tempVisited.contains(currentVisited)) {
          result++;
          break;
        }
        tempVisited.add(currentVisited);
        guardCell = nextCell;
      }
    }
  }

  return result;
}
