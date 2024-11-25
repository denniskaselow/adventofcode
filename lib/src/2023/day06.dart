import 'dart:math';

import '../utils.dart';

int day06star1(Input input) {
  final [maxTimes, distances] = input
      .getLines()
      .map((e) => e.split(RegExp(' +')).skip(1).map(int.parse).toList())
      .toList();
  final requiredTime = <int>[];
  for (var i = 0; i < maxTimes.length; i++) {
    requiredTime.add(getWins(maxTimes[i], distances[i]));
  }
  return requiredTime.reduce((value, element) => value * element);
}

int day06star2(Input input) {
  final [maxTime, distance] = input
      .getLines()
      .map((e) => int.parse(e.split(RegExp(' +')).skip(1).join()))
      .toList();

  return getWins(maxTime, distance);
}

int getWins(int maxTime, int distance) {
  final loses =
      2 * (1 - (-maxTime + sqrt(maxTime * maxTime - 4 * distance)) / 2).floor();
  return maxTime - loses + 1;
}
