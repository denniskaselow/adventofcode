import '../utils.dart';

typedef Coords = ({int x, int y});
typedef Grid = Map<Coords, Tile>;
typedef Connection = ({Coords node, int distance});
typedef Graph = Map<Coords, Set<Connection>>;

int maxX = 0;
int maxY = 0;

enum Tile {
  forest([]),
  path(DirectionCross.values),
  slopeWest([DirectionCross.west]),
  slopeEast([DirectionCross.east]),
  slopeNorth([DirectionCross.north]),
  slopeSouth([DirectionCross.south]);

  const Tile(this.directions);

  final List<DirectionCross> directions;
}

int day23star1(String input) => getSteps(input);
int day23star2(String input) => getSteps(input, withSlopes: false);

int getSteps(String input, {bool withSlopes = true}) {
  final lines = input.getLines();
  maxX = lines.first.length;
  maxY = lines.length;
  late final Coords start;
  late final Coords end;
  final grid = lines.indexed.fold(Grid(), (grid, line) {
    line.$2.split('').indexed.forEach((cell) {
      final tile = convertToTile(cell, withSlopes: withSlopes);
      final pos = (x: cell.$1, y: line.$1);

      if (tile == Tile.path) {
        if (pos.y == 0) {
          start = pos;
        } else if (pos.y == maxY - 1) {
          end = pos;
        }
      }

      grid[pos] = tile;
    });
    return grid;
  });

  final nodes = <Coords>{start, end};
  for (final pos in grid.entries
      .where((element) => element.value == Tile.path)
      .map((e) => e.key)) {
    var connections = 0;
    for (final direction in DirectionCross.values) {
      if (grid[(x: pos.x + direction.x, y: pos.y + direction.y)] !=
          Tile.forest) {
        connections++;
      }
    }
    if (connections > 2) {
      nodes.add(pos);
    }
  }

  final graph = connectNodes(grid, nodes);

  final (:steps, targetReached: _) = traverse(graph, {}, start, end, 0);

  return steps;
}

Graph connectNodes(Grid grid, Set<Coords> nodes) {
  final result = Graph();

  for (final node in nodes) {
    final open = {(node: node, visited: <Coords>{})};
    while (open.isNotEmpty) {
      final current = open.first;
      open.remove(current);
      if (current.visited.add(current.node)) {
        if (current.node != node && nodes.contains(current.node)) {
          result.putIfAbsent(node, () => {}).add(
            (node: current.node, distance: current.visited.length - 1),
          );
          continue;
        }
        for (final direction in grid[current.node]!.directions) {
          final next = (
            x: current.node.x + direction.x,
            y: current.node.y + direction.y
          );
          if (next.x >= 0 &&
              next.y >= 0 &&
              next.x < maxX &&
              next.y < maxY &&
              !current.visited.contains(next) &&
              grid[next] != Tile.forest) {
            open.add((node: next, visited: current.visited.toSet()));
          }
        }
      }
    }
  }

  return result;
}

Tile convertToTile((int, String) cell, {bool withSlopes = true}) =>
    switch (cell.$2) {
      '#' => Tile.forest,
      '>' when withSlopes => Tile.slopeEast,
      '<' when withSlopes => Tile.slopeWest,
      '^' when withSlopes => Tile.slopeNorth,
      'v' when withSlopes => Tile.slopeSouth,
      _ => Tile.path,
    };

({int steps, bool targetReached}) traverse(
  Graph graph,
  Set<Coords> visited,
  Coords current,
  Coords target,
  int step,
) {
  var result = (steps: step, targetReached: false);
  if (!visited.add(current)) {
    return result;
  }
  if (current == target) {
    return (steps: step, targetReached: true);
  }

  final connections = graph[current]!;
  for (final connection in connections) {
    final tmp = traverse(
      graph,
      visited.toSet(),
      connection.node,
      target,
      step + connection.distance,
    );
    if (tmp.targetReached && tmp.steps > result.steps) {
      result = tmp;
    }
  }
  return result;
}
