import 'dart:math';

import 'package:collection/collection.dart';

import '../utils.dart';

typedef Pos = ({int x, int y});
typedef Grid = Map<Pos, String>;

Grid _processInput(Input input) =>
    input.getLines().foldIndexed(<({int x, int y}), String>{}, (y, grid, line) {
      line.split('').forEachIndexed((x, cell) {
        grid[(x: x, y: y)] = cell;
      });
      return grid;
    });

int day16star1(Input input) {
  final grid = _processInput(input);
  final start = grid.entries.firstWhere((element) => element.value == 'S').key;
  final end = grid.entries.firstWhere((element) => element.value == 'E').key;

  final visited = <Pos>{};
  final open = [(pos: start, dir: Direction.e, cost: 0)];
  var result = (pos: start, dir: Direction.e, cost: 0);
  while (open.isNotEmpty) {
    final current = open.removeLast();
    if (visited.add(current.pos)) {
      if (current.pos == end) {
        result = current;
        break;
      }
      for (final direction in Direction.plus) {
        if (direction != current.dir.opposite) {
          final nextPos = (
            x: current.pos.x + direction.x,
            y: current.pos.y + direction.y,
          );
          if (grid[nextPos] != '#') {
            final cost = current.dir == direction ? 1 : 1001;
            open.add((pos: nextPos, dir: direction, cost: current.cost + cost));
          }
        }
      }
      open.sort((a, b) => b.cost - a.cost);
    }
  }

  return result.cost;
}

int day16star2(Input input) {
  final grid = _processInput(input);
  final start = grid.entries.firstWhere((element) => element.value == 'S').key;
  final end = grid.entries.firstWhere((element) => element.value == 'E').key;

  final visited = <Pos>{};
  final visitedCosts = <(Pos, Direction), int>{};
  final startState = (pos: start, dir: Direction.e, cost: 0);
  final open = [startState];
  var result = startState;
  while (open.isNotEmpty) {
    final current = open.removeLast();
    final posDir = (current.pos, current.dir);
    final previousCost = visitedCosts[posDir];
    if (previousCost == null) {
      visitedCosts[posDir] = current.cost;
    } else {
      visitedCosts[posDir] = min(visitedCosts[posDir]!, current.cost);
    }
    if (visited.add(current.pos)) {
      if (current.pos == end) {
        result = current;
        break;
      }
      for (final direction in Direction.plus) {
        if (direction != current.dir.opposite) {
          final nextPos = (
            x: current.pos.x + direction.x,
            y: current.pos.y + direction.y,
          );
          if (grid[nextPos] != '#') {
            final cost = current.dir == direction ? 1 : 1001;
            open.add((pos: nextPos, dir: direction, cost: current.cost + cost));
          }
        }
      }
      open.sort((a, b) => b.cost - a.cost);
    }
  }
  visited.clear();
  return _visit(
    grid,
    visited,
    startState,
    end,
    result.cost,
    visitedCosts,
  ).length;
}

Set<Pos> _visit(
  Grid grid,
  Set<Pos> visited,
  ({int cost, Direction dir, Pos pos}) current,
  Pos end,
  int maxCost,
  Map<(Pos, Direction), int> visitedCosts,
) {
  final posDir = (current.pos, current.dir);
  if (visitedCosts[posDir] case final previousCost?
      when current.cost > previousCost) {
    return {};
  }
  if (visited.add(current.pos) && current.cost <= maxCost) {
    if (current.pos == end) {
      return visited;
    }

    final endReached = <Pos>{};
    for (final direction in [
      current.dir,
      current.dir.nextClockwise,
      current.dir.nextAntiClockwise,
    ]) {
      final nextPos = (
        x: current.pos.x + direction.x,
        y: current.pos.y + direction.y,
      );
      if (grid[nextPos] != '#') {
        final cost = current.dir == direction ? 1 : 1001;
        final nextVisited = _visit(
          grid,
          visited.toSet(),
          (pos: nextPos, dir: direction, cost: current.cost + cost),
          end,
          maxCost,
          visitedCosts,
        );
        if (nextVisited.contains(end)) {
          endReached.addAll(nextVisited);
          final previousCost = visitedCosts[posDir];
          if (previousCost == null) {
            visitedCosts[posDir] = current.cost;
          } else {
            visitedCosts[posDir] = min(visitedCosts[posDir]!, current.cost);
          }
        }
      }
    }

    return endReached;
  }
  return {};
}
