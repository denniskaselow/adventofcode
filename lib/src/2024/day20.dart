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

int day20star1(Input input, {int timeSaved = 100}) =>
    _findCheats(input, 2, timeSaved);

int day20star2(Input input, {int timeSaved = 100}) =>
    _findCheats(input, 20, timeSaved);

int _findCheats(Input input, int maxDist, int timeSaved) {
  final grid = _processInput(input);
  final size = input.getLines().length;
  final start = grid.entries.firstWhere((element) => element.value == 'S').key;
  final end = grid.entries.firstWhere((element) => element.value == 'E').key;
  final obstacles = {
    for (final wall in grid.entries.where((element) => element.value == '#'))
      wall.key,
  };

  final path = _findPath(start, end, size, obstacles);
  var result = 0;
  for (final from in path.keys) {
    for (final to in path.keys) {
      final dist = (to.x - from.x).abs() + (to.y - from.y).abs();
      if (dist <= maxDist && path[to]! - path[from]! >= timeSaved + dist) {
        result++;
      }
    }
  }
  return result;
}

Map<Pos, int> _findPath(Pos start, Pos end, int size, Set<Pos> obstacles) {
  final visited = <Pos, int>{};
  final open = [(pos: start, cost: 0)];
  while (open.isNotEmpty) {
    final current = open.removeLast();
    final lastVisit = visited[current.pos];
    if (lastVisit == null || lastVisit > current.cost) {
      visited[current.pos] = current.cost;
      if (current.pos == end) {
        break;
      }
      for (final direction in Direction.plus) {
        final nextPos = (
          x: current.pos.x + direction.x,
          y: current.pos.y + direction.y,
        );
        if (!obstacles.contains(nextPos) &&
            nextPos.x >= 0 &&
            nextPos.y >= 0 &&
            nextPos.x <= size &&
            nextPos.y <= size) {
          const cost = 1;
          open.add((pos: nextPos, cost: current.cost + cost));
        }
      }
      open.sort((a, b) => b.cost - a.cost);
    }
  }
  return visited;
}
