import 'dart:math';

import '../utils.dart';

int day8star1(Input input) => evaluateGrid(input)[0];
int day8star2(Input input) => evaluateGrid(input)[1];

List<int> evaluateGrid(Input input) {
  final lines = input.getLines().toList();
  final grid = List<List<int>>.generate(
    lines.first.length,
    (x) => List<int>.generate(lines.length, (y) => int.parse(lines[y][x])),
  );
  var visibleCount = 0;
  var bestScenicScore = 0;
  for (var y = 0; y < grid.length; y++) {
    for (var x = 0; x < grid[y].length; x++) {
      var isVisible = false;
      var scenicScore = 1;
      for (final direction in Direction.plus) {
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

State checkDirection(
  List<List<int>> grid,
  int x,
  int y,
  Direction direction,
  int height,
) {
  if (x == 0 || x == grid.length - 1 || y == 0 || y == grid[x].length - 1) {
    return State(0);
  }
  final checkX = x + direction.x;
  final checkY = y + direction.y;
  var state = State(0, visible: false);
  if (height > grid[checkX][checkY]) {
    state = checkDirection(grid, checkX, checkY, direction, height);
  }
  state.viewingDistance++;
  return state;
}

class State {
  State(this.viewingDistance, {this.visible = true});
  int viewingDistance;
  bool visible;
}
