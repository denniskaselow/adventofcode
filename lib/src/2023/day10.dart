import 'package:collection/collection.dart';

import '../utils.dart';

typedef Coords = ({int x, int y});
typedef Tile = ({Set<DirectionCross> directions, String original});

final startDirections = DirectionCross.values.toSet();

int day10star1(String input) {
  final area = getArea(input);
  final (distance, _) = visitAllConnected(area);
  return distance;
}

int day10star2(String input) {
  final area = getArea(input);
  final (_, visited) = visitAllConnected(area);
  var inside = false;
  var lastCornerPipe = '';
  return area
      .map((key, value) {
        final pipe = value.original != 'S'
            ? visited.contains(key)
                ? value.original
                : '.'
            : replaceStart(
                area[(x: key.x - 1, y: key.y)]?.original ?? '',
                area[(x: key.x + 1, y: key.y)]?.original ?? '',
                area[(x: key.x, y: key.y - 1)]?.original ?? '',
              );
        if (pipe == '|') {
          inside = !inside;
        } else if (pipe == 'F' || pipe == 'L') {
          lastCornerPipe = pipe;
        } else if (lastCornerPipe == 'F' && pipe == 'J') {
          inside = !inside;
          lastCornerPipe = '';
        } else if (lastCornerPipe == 'L' && pipe == '7') {
          inside = !inside;
          lastCornerPipe = '';
        }
        return MapEntry(key, inside);
      })
      .entries
      .whereNot((element) => visited.contains(element.key))
      .where((element) => element.value)
      .length;
}

(int, Set<Coords>) visitAllConnected(Map<Coords, Tile> map) {
  final visited = <Coords, int>{};
  var distance = 0;
  for (final MapEntry(key: coords, value: tile) in map.entries) {
    if (tile.directions == startDirections) {
      final open = [(coords, -1)];
      while (open.isNotEmpty) {
        final (current, distance) = open.removeAt(0);
        open.addAll(
          visitLoopNeighbor(visited, map, current, distance + 1),
        );
      }
      distance = visited.values.max;
      break;
    }
  }
  return (distance, visited.keys.toSet());
}

Map<Coords, Tile> getArea(
  String input,
) =>
    input.getLines().indexed.fold(<Coords, Tile>{}, (previousValue, row) {
      final line = row.$2;
      final converted = line.split('').indexed.map(
        (column) {
          final pipe = column.$2;
          return (
            column.$1,
            switch (column.$2) {
              '-' => {DirectionCross.west, DirectionCross.east},
              '|' => {DirectionCross.north, DirectionCross.south},
              '7' => {DirectionCross.west, DirectionCross.south},
              'J' => {DirectionCross.north, DirectionCross.west},
              'L' => {DirectionCross.north, DirectionCross.east},
              'F' => {DirectionCross.south, DirectionCross.east},
              'S' => startDirections,
              final _ => <DirectionCross>{},
            },
            pipe,
          );
        },
      );

      for (final value in converted) {
        previousValue[(x: value.$1, y: row.$1)] =
            (directions: value.$2, original: value.$3);
      }

      return previousValue;
    });

String replaceStart(String left, String right, String above) {
  final connectsLeft = left == '-' || left == 'F' || left == 'L';
  final connectsRight = right == '-' || right == 'J' || right == '7';
  final connectsAbove = above == '|' || above == 'F' || above == '7';
  return switch (connectsLeft) {
    true when connectsRight => '_',
    true when connectsAbove => 'J',
    false when connectsRight && connectsAbove => 'L',
    false when connectsRight => 'F',
    true => '7',
    false => '|',
  };
}

List<(Coords, int)> visitLoopNeighbor(
  Map<Coords, int> visited,
  Map<Coords, Tile> map,
  Coords current,
  int distance,
) {
  if (visited.containsKey(current) && visited[current]! <= distance) {
    return [];
  }
  visited[current] = distance;
  final open = <(Coords, int)>[];
  for (final direction in map[current]!.directions) {
    final nextCoords = (x: current.x + direction.x, y: current.y + direction.y);
    if (map[nextCoords] case final nextTile?) {
      if (nextTile.directions.contains(direction.opposite)) {
        open.add((nextCoords, distance));
      }
    }
  }
  return open;
}
