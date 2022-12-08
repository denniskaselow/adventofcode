import 'dart:math';

int day8star1(String input) => evaluateGrid(input)[0];
int day8star2(String input) => evaluateGrid(input)[1];

List<int> evaluateGrid(String input) {
  final lines = input.split('\n').toList();
  final grid = List<List<int>>.generate(
      lines.first.length,
      (x) => List<int>.generate(
          lines.length, (y) => int.parse(lines[y][x])));
  var visibleCount = 0;
  var bestScenicScore = 0;
  for (var y = 0; y < grid.length; y++) {
    for (var x = 0; x < grid[y].length; x++) {
      var isVisible = false;
      var scenicScore = 1;
      for (final direction in Direction.values) {
        final state = checkDirection(grid, x, y, direction, grid[x][y]);
        isVisible |= state.visible;
        scenicScore *= state.viewingDistance;
      }
      if (isVisible) {
        visibleCount++;
      }
      bestScenicScore = max(scenicScore, bestScenicScore);
    }
  }
  return [visibleCount, bestScenicScore];
}

State checkDirection(List<List<int>> grid, int x, int y, Direction direction,
    int height) {
  if (x == 0 || x == grid.length - 1 || y == 0 || y == grid[x].length - 1) {
    return State(0, true);
  }
  final checkX = x + direction.x;
  final checkY = y + direction.y;
  var state = State(0, false);
  if (height > grid[checkX][checkY]) {
    state = checkDirection(grid, checkX, checkY, direction, height);
  }
  state.viewingDistance++;
  return state;
}

enum Direction {
  north(0, -1),
  south(0, 1),
  east(1, 0),
  west(-1, 0);

  final int x;
  final int y;
  const Direction(this.x, this.y);
}

class State {
  int viewingDistance;
  bool visible;
  State(this.viewingDistance, this.visible);
}
