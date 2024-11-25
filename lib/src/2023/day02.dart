import 'dart:math';

import '../utils.dart';

Iterable<Iterable<List<String>>> _processInput(Input input) => input
    .getLines()
    .map((e) => e.split(RegExp('[:;]')).skip(1).map((e) => e.split(',')));

int day02star1(Input input) {
  final games = _processInput(input);
  var result = 0;
  var gameId = 0;
  for (final game in games) {
    gameId++;
    var validGame = true;
    for (final draw in game) {
      var validDraw = true;
      for (final item in draw) {
        final [countString, color] = item.trim().split(' ');
        final count = int.parse(countString);
        validDraw = validDraw &&
            switch ((count, color)) {
              _ when color == 'red' => count <= 12,
              _ when color == 'green' => count <= 13,
              _ when color == 'blue' => count <= 14,
              _ => false,
            };
      }
      validGame = validGame && validDraw;
    }
    if (validGame) {
      result += gameId;
    }
  }
  return result;
}

int day02star2(Input input) {
  final games = _processInput(input);
  var result = 0;
  for (final game in games) {
    final minRequired = <String, int>{};
    for (final draw in game) {
      for (final item in draw) {
        final [countString, color] = item.trim().split(' ');
        final count = int.parse(countString);
        minRequired.update(
          color,
          (value) => max(value, count),
          ifAbsent: () => count,
        );
      }
    }
    result += minRequired.values.reduce((value, element) => value * element);
  }
  return result;
}
