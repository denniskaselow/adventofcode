import 'package:more/more.dart';

import '../utils.dart';

final xmas = ['X', 'M', 'A', 'S'];

List<List<String>> _processInput(Input input) =>
    input.getLines().map((line) => line.split('')).toList();

int day04star1(Input input) {
  final grid = _processInput(input);
  final rows = grid.length;
  final columns = grid.first.length;
  final result = <(int, int, Direction), bool>{};
  for (var row = 0; row < rows; row++) {
    for (var col = 0; col < columns; col++) {
      for (var i = 0; i < xmas.length; i++) {
        for (final direction in Direction.values) {
          if (i == 0) {
            if (grid[row][col] == xmas[i]) {
              result[(row, col, direction)] = true;
            } else {
              result[(row, col, direction)] = false;
            }
          } else {
            final nextRow = row + direction.y * i;
            final nextCol = col + direction.x * i;
            result[(row, col, direction)] =
                result[(row, col, direction)]! &&
                nextRow >= 0 &&
                nextRow < rows &&
                nextCol >= 0 &&
                nextCol < columns &&
                grid[nextRow][nextCol] == xmas[i];
          }
        }
      }
    }
  }

  return result.values.count((cell) => cell);
}

int day04star2(Input input) {
  final grid = _processInput(input);
  final rows = grid.length;
  final columns = grid.first.length;
  final result = <(int, int), bool>{};
  for (var row = 1; row < rows - 1; row++) {
    for (var col = 1; col < columns - 1; col++) {
      if (grid[row][col] == 'A') {
        result[(row, col)] = true;
      } else {
        result[(row, col)] = false;
        continue;
      }
      for (final direction in [Direction.nw, Direction.ne]) {
        final nextRow = row + direction.y;
        final nextCol = col + direction.x;
        final oppositeRow = row + direction.opposite.y;
        final oppositeCol = col + direction.opposite.x;
        result[(row, col)] =
            result[(row, col)]! &&
            (grid[nextRow][nextCol] == 'M' &&
                    grid[oppositeRow][oppositeCol] == 'S' ||
                grid[nextRow][nextCol] == 'S' &&
                    grid[oppositeRow][oppositeCol] == 'M');
      }
    }
  }
  return result.values.count((cell) => cell);
}
