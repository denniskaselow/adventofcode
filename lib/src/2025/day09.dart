import 'dart:math';

import '../utils.dart';

Iterable<_Cell> _processInput(Input input) => input.getLines().map(
  (e) => e
      .split(',')
      .map(int.parse)
      .convert((self) => _Cell(x: self.first, y: self.last)),
);

int day09star1(Input input) {
  final tiles = _processInput(input);
  var result = 0;
  for (final (index, tile) in tiles.indexed) {
    for (final otherTile in tiles.skip(index + 1)) {
      final xDiff = (tile.x - otherTile.x).abs() + 1;
      final yDiff = (tile.y - otherTile.y).abs() + 1;
      final area = xDiff * yDiff;
      result = max(result, area);
    }
  }
  return result;
}

int day09star2(Input input) {
  final tiles = _processInput(input).toList();
  final rectsBySize = <_Rectangle>[];

  for (final (index, tile) in tiles.indexed) {
    for (final otherTile in tiles.skip(index + 1)) {
      final xDiff = (tile.x - otherTile.x).abs() + 1;
      final yDiff = (tile.y - otherTile.y).abs() + 1;
      final area = xDiff * yDiff;
      rectsBySize.add(_Rectangle(a: tile, b: otherTile, area: area));
    }
  }
  rectsBySize.sort((a, b) => b.area - a.area);
  for (final rect in rectsBySize) {
    var hasIntersections = false;
    for (var i = 0; i < tiles.length; i++) {
      hasIntersections |= switch ((tiles[i], tiles[(i + 1) % tiles.length])) {
        (final topTile, final bottomTile)
            when topTile.x == bottomTile.x &&
                topTile.y < bottomTile.y &&
                topTile.x > rect.minX &&
                topTile.x < rect.maxX &&
                topTile.y < rect.maxY &&
                bottomTile.y > rect.minY =>
          true,
        (final bottomTile, final topTile)
            when topTile.x == bottomTile.x &&
                topTile.y < bottomTile.y &&
                topTile.x > rect.minX &&
                topTile.x < rect.maxX &&
                topTile.y < rect.maxY &&
                bottomTile.y > rect.minY =>
          true,
        (final leftTile, final rightTile)
            when leftTile.y == rightTile.y &&
                leftTile.x < rightTile.x &&
                leftTile.y > rect.minY &&
                leftTile.y < rect.maxY &&
                leftTile.x < rect.maxX &&
                rightTile.x > rect.minX =>
          true,
        (final rightTile, final leftTile)
            when leftTile.y == rightTile.y &&
                leftTile.x < rightTile.x &&
                leftTile.y > rect.minY &&
                leftTile.y < rect.maxY &&
                leftTile.x < rect.maxX &&
                rightTile.x > rect.minX =>
          true,
        (_, _) => false,
      };
      if (hasIntersections) {
        break;
      }
    }
    if (!hasIntersections) {
      return rect.area;
    }
  }
  return 0;
}

class _Rectangle {
  _Rectangle({required this.a, required this.b, required this.area})
    : minY = min(a.y, b.y),
      maxY = max(a.y, b.y),
      minX = min(a.x, b.x),
      maxX = max(a.x, b.x);
  final _Cell a;
  final _Cell b;
  final int area;
  final int minY;
  final int maxY;
  final int minX;
  final int maxX;
}

class _Cell {
  _Cell({required this.x, required this.y});
  final int x;
  final int y;
}
