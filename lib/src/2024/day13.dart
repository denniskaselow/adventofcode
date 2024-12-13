import 'dart:math';

import '../utils.dart';

Iterable<
  ({int aMoveX, int aMoveY, int bMoveX, int bMoveY, int priceX, int priceY})
>
_processInput(Input input) => input.getInputGroups().map((e) {
  final [lineA, lineB, linePrice] = e.getLines();
  final buttonExp = RegExp(r'\+(\d+), Y\+(\d+)');
  final [aMoveX, aMoveY] =
      buttonExp
          .firstMatch(lineA)!
          .groups([1, 2])
          .map((e) => int.parse(e!))
          .toList();
  final [bMoveX, bMoveY] =
      buttonExp
          .firstMatch(lineB)!
          .groups([1, 2])
          .map((e) => int.parse(e!))
          .toList();
  final [priceX, priceY] =
      RegExp(r'X=(\d+), Y=(\d+)')
          .firstMatch(linePrice)!
          .groups([1, 2])
          .map((e) => int.parse(e!))
          .toList();
  return (
    aMoveX: aMoveX,
    aMoveY: aMoveY,
    bMoveX: bMoveX,
    bMoveY: bMoveY,
    priceX: priceX,
    priceY: priceY,
  );
});

int day13star1(Input input) {
  final machines = _processInput(input);
  var totalCost = 0;
  for (final machine in machines) {
    // priceX = ax * m + bx * n
    // priceY = ay * m + bx * n
    // cost = 3m + 1n
    final maxPressA = min(
      min(machine.priceX ~/ machine.aMoveX, machine.priceY ~/ machine.aMoveY),
      100,
    );
    final maxPressB = min(
      min(machine.priceX ~/ machine.bMoveX, machine.priceY ~/ machine.bMoveY),
      100,
    );
    int? minCost;
    // brrrrrrrrrrrrrr
    for (var m = 0; m <= maxPressA; m++) {
      for (var n = maxPressB; n >= 0; n--) {
        if (machine.priceX == machine.aMoveX * m + machine.bMoveX * n &&
            machine.priceY == machine.aMoveY * m + machine.bMoveY * n) {
          final cost = m * 3 + n * 1;
          minCost = min(cost, minCost ?? cost);
        }
      }
    }
    totalCost += minCost ?? 0;
  }
  return totalCost;
}

int day13star2(Input input) {
  final machines = _processInput(input).map(
    (e) => (
      aMoveX: e.aMoveX,
      aMoveY: e.aMoveY,
      bMoveX: e.bMoveX,
      bMoveY: e.bMoveY,
      priceX: 10000000000000 + e.priceX,
      priceY: 10000000000000 + e.priceY,
    ),
  );
  var totalCost = 0;
  for (final machine in machines) {
    // messed this up until I finally did it on paper :/
    // priceX = ax * m + bx * n
    // priceX - ax * m = bx * n
    // n = (priceX - ax * m) / bx
    //
    // priceY = ay * m + by * n
    // priceY - ay * m = by * n
    // n = (priceY - ay * m) / by
    //
    // (priceX - ax * m) / bx = (priceY - ay * m) / by
    // priceX * by - ax * m * by = priceY * bx - ay * m * bx
    // priceX * by - priceY * bx = ax * m * by - ay * m * bx
    // priceX * by - priceY * bx = m * (ax * by - ay * bx)
    // m = (priceX * by - priceY * bx) / (ax * by - ay * bx)
    // n = (priceX - ax * m) / bx
    final (ax, ay, bx, by, priceX, priceY) = (
      machine.aMoveX,
      machine.aMoveY,
      machine.bMoveX,
      machine.bMoveY,
      machine.priceX,
      machine.priceY,
    );
    final m = (priceX * by - priceY * bx) / (ax * by - ay * bx);
    final n = (priceX - ax * m) / bx;

    int? minCost;
    if (m % 1 == 0 && n % 1 == 0) {
      final cost = (m * 3 + n * 1).toInt();
      minCost = min(cost, minCost ?? cost);
    }
    totalCost += minCost ?? 0;
  }
  return totalCost;
}
