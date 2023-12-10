import 'package:collection/collection.dart';

import '../utils.dart';

typedef Coords = ({int x, int y});

final startDirections = DirectionCross.values.toSet();

Iterable<String> _processInput(String input) => input.getLines();

int day10star1(String input) {
  final map = getMap(input);
  final (distance, _) = visitAllConnected(map);
  return distance;
}

int day10star2(String input) => throw Exception('not implemented!');

(int, Set<Coords>) visitAllConnected(Map<Coords, Set<DirectionCross>> map) {
  final visited = <Coords, int>{};
  var distance = 0;
  for (final MapEntry(key: coords, value: directions) in map.entries) {
    if (directions == startDirections) {
      final open = [(coords, -1)];
      while (open.isNotEmpty) {
        final (current, distance) = open.removeAt(0);
        open.addAll(
          visitLoopNeighbor(directions, visited, map, current, distance + 1),
        );
      }
      distance = visited.values.max;
      break;
    }
  }
  return (distance, visited.keys.toSet());
}

Map<Coords, Set<DirectionCross>> getMap(String input) {
  final map = _processInput(input).indexed.fold(<Coords, Set<DirectionCross>>{},
      (previousValue, element) {
    final converted = element.$2.split('').indexed.map(
          (e) => (
            e.$1,
            switch (e.$2) {
              '-' => {DirectionCross.west, DirectionCross.east},
              '|' => {DirectionCross.north, DirectionCross.south},
              '7' => {DirectionCross.west, DirectionCross.south},
              'J' => {DirectionCross.north, DirectionCross.west},
              'L' => {DirectionCross.north, DirectionCross.east},
              'F' => {DirectionCross.south, DirectionCross.east},
              'S' => startDirections,
              final _ => <DirectionCross>{},
            },
          ),
        );

    for (final value in converted) {
      previousValue[(x: value.$1, y: element.$1)] = value.$2;
    }

    return previousValue;
  });
  return map;
}

List<(Coords, int)> visitLoopNeighbor(
  Set<DirectionCross> directions,
  Map<Coords, int> visited,
  Map<Coords, Set<DirectionCross>> map,
  Coords current,
  int distance,
) {
  if (visited.containsKey(current) && visited[current]! <= distance) {
    return [];
  }
  visited[current] = distance;
  final open = <(Coords, int)>[];
  for (final direction in directions) {
    final nextCoords = (x: current.x + direction.x, y: current.y + direction.y);
    if (map[nextCoords] case final nextDirections?) {
      if (nextDirections.contains(direction.opposite)) {
        open.add((nextCoords, distance));
      }
    }
  }
  return open;
}
