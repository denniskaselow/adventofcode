import '../utils.dart';

typedef Pos = ({int x, int y});

List<Pos> _processInput(Input input) =>
    input
        .getLines()
        .map((e) => e.split(',').map(int.parse).toList())
        .map((e) => (x: e[0], y: e[1]))
        .toList();

int day18star1(Input input, {int size = 70, int amount = 1024}) {
  final corruptedBytes = _processInput(input);
  final obstacles = {for (final byte in corruptedBytes.take(amount)) byte};

  final result = _findPath(size, obstacles);

  return result.cost;
}

({Pos pos, int cost}) _findPath(int size, Set<Pos> obstacles) {
  const start = (x: 0, y: 0);
  final end = (x: size, y: size);

  final visited = <Pos, int>{};
  final open = [(pos: start, cost: 0)];
  var result = (pos: start, cost: 0);
  while (open.isNotEmpty) {
    final current = open.removeLast();
    final lastVisit = visited[current.pos];
    if (lastVisit == null || lastVisit > current.cost) {
      visited[current.pos] = current.cost;
      if (current.pos == end) {
        result = current;
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
  return result;
}

String day18star2(Input input, {int size = 70}) {
  final corruptedBytes = _processInput(input);

  for (var amount = corruptedBytes.length; amount >= 0; amount--) {
    final obstacles = {for (final byte in corruptedBytes.take(amount)) byte};
    final path = _findPath(size, obstacles);
    if (path.cost > 0) {
      final result = corruptedBytes[amount];
      return '${result.x},${result.y}';
    }
  }

  return '';
}
