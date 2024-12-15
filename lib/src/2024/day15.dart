import 'package:collection/collection.dart';

import '../utils.dart';

typedef Grid = Map<({int x, int y}), String>;
typedef Pos = ({int x, int y});

List<Input> _processInput(Input input) => input.getInputGroups();

int day15star1(Input input) {
  var bot = (x: 0, y: 0);
  final [gridLines, movementsLines] = _processInput(input);
  final grid = gridLines.getLines().foldIndexed(<({int x, int y}), String>{}, (
    y,
    grid,
    line,
  ) {
    line.split('').forEachIndexed((x, cell) {
      final pos = (x: x, y: y);
      grid[pos] = cell;
      if (cell == '@') {
        bot = pos;
      }
    });
    return grid;
  });
  final directions = _getDirections(movementsLines);

  for (final direction in directions) {
    if (_move(grid, bot, direction)) {
      bot = (x: bot.x + direction.x, y: bot.y + direction.y);
    }
  }

  return grid.entries
      .where((element) => element.value == 'O')
      .map((e) => e.key.x + e.key.y * 100)
      .sum;
}

bool _move(Grid grid, Pos toMove, Direction direction) {
  final nextPos = (x: toMove.x + direction.x, y: toMove.y + direction.y);
  if (grid[nextPos] == '#') {
    return false;
  }
  if (grid[nextPos] == 'O') {
    final canMove = _move(grid, nextPos, direction);
    if (canMove) {
      grid[nextPos] = grid.remove(toMove)!;
    }
    return canMove;
  }
  grid[nextPos] = grid.remove(toMove)!;
  return true;
}

int day15star2(Input input) {
  var bot = (x: 0, y: 0);
  final [gridLines, movementsLines] = _processInput(input);
  final grid = gridLines.getLines().foldIndexed(<({int x, int y}), String>{}, (
    y,
    grid,
    line,
  ) {
    line
        .split('')
        .expand(
          (e) => switch (e) {
            '@' => ['@', '.'],
            'O' => ['[', ']'],
            _ => (e * 2).split(''),
          },
        )
        .forEachIndexed((x, cell) {
          final pos = (x: x, y: y);
          grid[pos] = cell;
          if (cell == '@') {
            bot = pos;
          }
        });
    return grid;
  });
  final directions = _getDirections(movementsLines);

  for (final direction in directions) {
    final (canMove, boxes) = _moveBigBoxes(grid, bot, direction, isBox: false);
    if (canMove) {
      final List<Pos> sortedBoxes;
      if (direction == Direction.n) {
        sortedBoxes = boxes.sorted((a, b) => a.y - b.y);
      } else if (direction == Direction.s) {
        sortedBoxes = boxes.sorted((a, b) => b.y - a.y);
      } else if (direction == Direction.e) {
        sortedBoxes = boxes.sorted((a, b) => b.x - a.x);
      } else {
        sortedBoxes = boxes.sorted((a, b) => a.x - b.x);
      }
      for (final box in sortedBoxes) {
        grid[(x: box.x + direction.x, y: box.y + direction.y)] =
            grid.remove((x: box.x, y: box.y))!;
        grid[(x: box.x, y: box.y)] = '.';
      }
      grid[(x: bot.x + direction.x, y: bot.y + direction.y)] =
          grid.remove((x: bot.x, y: bot.y))!;
      grid[(x: bot.x, y: bot.y)] = '.';
      bot = (x: bot.x + direction.x, y: bot.y + direction.y);
    }
  }

  return grid.entries
      .where((element) => element.value == '[')
      .map((e) => e.key.x + e.key.y * 100)
      .sum;
}

(bool, Set<Pos>) _moveBigBoxes(
  Grid grid,
  Pos toMove,
  Direction direction, {
  bool isBox = true,
}) {
  final nextField = (x: toMove.x + direction.x, y: toMove.y + direction.y);
  final nextPositions = [
    if (grid[nextField] != '.') nextField,
    if (grid[nextField] == '[' &&
        (direction == Direction.n || direction == Direction.s))
      (x: toMove.x + direction.x + 1, y: toMove.y + direction.y),
    if (grid[nextField] == ']' &&
        (direction == Direction.n || direction == Direction.s))
      (x: toMove.x + direction.x - 1, y: toMove.y + direction.y),
  ];
  for (final nextPos in nextPositions) {
    if (grid[nextPos] == '#') {
      return (false, {});
    }
  }
  var canMove = true;
  final boxes = nextPositions.toSet();
  for (final nextPos in nextPositions) {
    final (canMoveOtherBoxes, otherBoxes) = _moveBigBoxes(
      grid,
      nextPos,
      direction,
    );
    canMove = canMove && canMoveOtherBoxes;
    boxes.addAll(otherBoxes);
  }
  return (canMove, boxes);
}

Iterable<Direction> _getDirections(Input movementsLines) => movementsLines
    .getLines()
    .join()
    .split('')
    .map(
      (e) => switch (e) {
        '^' => Direction.n,
        '>' => Direction.e,
        'v' => Direction.s,
        '<' => Direction.w,
        _ => throw ArgumentError('$e is not a valid direction'),
      },
    );
