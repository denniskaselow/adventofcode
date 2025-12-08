import 'dart:math';

import 'package:collection/collection.dart';

import '../utils.dart';

typedef _Cell = ({int x, int y, int z});

List<_Cell> _processInput(Input input) => input
    .getLines()
    .map((e) => e.split(',').map(int.parse).toList())
    .map((e) => (x: e[0], y: e[1], z: e[2]))
    .toList();

int day08star1(Input input, {int connectionCount = 1000}) {
  final cells = _processInput(input);
  final circuits = <Set<_Cell>>[];
  final pairingsSortedByDistance = _getPairingsSortedByDistance(cells);

  var count = 0;
  for (final pairing in pairingsSortedByDistance) {
    Set<_Cell>? circuit1;
    Set<_Cell>? circuit2;
    for (final circuit in circuits) {
      if (circuit.contains(pairing.$1)) {
        circuit1 = circuit;
      }
      if (circuit.contains(pairing.$2)) {
        circuit2 = circuit;
      }
    }
    switch ((circuit1, circuit2)) {
      case (null, null):
        circuits.add({pairing.$1, pairing.$2});
      case (final circuit?, null):
        circuit.add(pairing.$2);
      case (null, final circuit?):
        circuit.add(pairing.$1);
      case (final circuit1?, final circuit2?) when circuit1 == circuit2:
        // both alread in the same circuit, no new connection added
        break;
      case (final circuit1?, final circuit2?):
        circuits.remove(circuit2);
        circuit1.addAll(circuit2);
    }
    count++;
    if (count == connectionCount) {
      break;
    }
  }

  final circuitsBySize = circuits.sorted((a, b) => b.length - a.length);
  return circuitsBySize
      .take(3)
      .fold(1, (previousValue, element) => previousValue * element.length);
}

int day08star2(Input input) {
  final cells = _processInput(input);
  final circuits = <Set<_Cell>>[];
  final pairingsSortedByDistance = _getPairingsSortedByDistance(cells);

  var result = 0;
  for (final pairing in pairingsSortedByDistance) {
    Set<_Cell>? circuit1;
    Set<_Cell>? circuit2;
    for (final circuit in circuits) {
      if (circuit.contains(pairing.$1)) {
        circuit1 = circuit;
      }
      if (circuit.contains(pairing.$2)) {
        circuit2 = circuit;
      }
    }
    switch ((circuit1, circuit2)) {
      case (null, null):
        circuits.add({pairing.$1, pairing.$2});
      case (final circuit?, null):
        circuit.add(pairing.$2);
      case (null, final circuit?):
        circuit.add(pairing.$1);
      case (final circuit1?, final circuit2?) when circuit1 == circuit2:
        // both alread in the same circuit, no new connection added
        break;
      case (final circuit1?, final circuit2?):
        circuits.remove(circuit2);
        circuit1.addAll(circuit2);
    }
    if (circuits.length == 1 && circuits.first.length == cells.length) {
      result = pairing.$1.x * pairing.$2.x;
      break;
    }
  }

  return result;
}

List<(_Cell, _Cell, double)> _getPairingsSortedByDistance(List<_Cell> cells) {
  final pairingsWithDistance = <(_Cell, _Cell, double)>[];
  for (final (index, cell) in cells.indexed) {
    for (final otherCell in cells.skip(index + 1)) {
      final xDiff = (cell.x - otherCell.x).abs();
      final yDiff = (cell.y - otherCell.y).abs();
      final zDiff = (cell.z - otherCell.z).abs();
      final distance = sqrt(xDiff * xDiff + yDiff * yDiff + zDiff * zDiff);
      pairingsWithDistance.add((cell, otherCell, distance));
    }
  }
  pairingsWithDistance.sort(
    (a, b) => (a.$3 - b.$3).toInt(),
  );
  return pairingsWithDistance;
}
