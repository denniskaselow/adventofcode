import 'dart:math';

import 'package:collection/collection.dart';

import '../utils.dart';

typedef _Cell = ({int column, int row});

({Set<_Cell> ray, Set<_Cell> splitter}) _processInput(Input input) => input
    .getLines()
    .indexed
    .map(
      (row) => row.$2
          .split('')
          .indexed
          .where((element) => element.$2 != '.')
          .map((column) => (row: row.$1, column: column.$1, value: column.$2)),
    )
    .expand((element) => element)
    .fold(
      (splitter: <_Cell>{}, ray: <_Cell>{}),
      (previousValue, element) => (
        splitter: element.value == '^'
            ? (previousValue.splitter
                ..add((row: element.row, column: element.column)))
            : previousValue.splitter,
        ray: element.value == 'S'
            ? (previousValue.ray
                ..add((row: element.row, column: element.column)))
            : previousValue.ray,
      ),
    );

int day07star1(Input input) {
  final (:splitter, :ray) = _processInput(input);
  final maxRow = splitter.fold(
    0,
    (previousValue, element) => max(previousValue, element.row),
  );
  var rays = ray;
  var result = 0;
  while (rays.first.row < maxRow) {
    final nextRays = <_Cell>{};
    for (final ray in rays) {
      final nextCell = (row: ray.row + 1, column: ray.column);
      if (splitter.contains(nextCell)) {
        nextRays.addAll([
          (row: ray.row + 1, column: ray.column - 1),
          (row: ray.row + 1, column: ray.column + 1),
        ]);
        result++;
      } else {
        nextRays.add(nextCell);
      }
    }
    rays = nextRays;
  }

  return result;
}

int day07star2(Input input) {
  final (:splitter, :ray) = _processInput(input);
  final maxRow = splitter.fold(
    0,
    (previousValue, element) => max(previousValue, element.row),
  );
  var rays = {ray.first: 1};

  while (rays.keys.first.row < maxRow) {
    final nextRays = <_Cell, int>{};
    for (final MapEntry(key: cell, value: timelines) in rays.entries) {
      final nextCell = (row: cell.row + 1, column: cell.column);
      if (splitter.contains(nextCell)) {
        nextRays
          ..update(
            (row: cell.row + 1, column: cell.column - 1),
            (value) => value + timelines,
            ifAbsent: () => timelines,
          )
          ..update(
            (row: cell.row + 1, column: cell.column + 1),
            (value) => value + timelines,
            ifAbsent: () => timelines,
          );
      } else {
        nextRays.update(
          nextCell,
          (value) => value + timelines,
          ifAbsent: () => timelines,
        );
      }
    }
    rays = nextRays;
  }

  return rays.values.sum;
}
