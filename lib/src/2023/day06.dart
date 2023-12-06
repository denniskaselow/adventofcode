import '../utils.dart';

int day06star1(String input) {
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

int day06star2(String input) {
  final [maxTime, distance] = input
      .getLines()
      .map((e) => int.parse(e.split(RegExp(' +')).skip(1).join()))
      .toList();

  return getWins(maxTime, distance);
}

int getWins(int maxTime, int distance) {
  var wins = maxTime + 1;
  var won = false;
  for (var time = 0; !won; time++) {
    final remaining = maxTime - time;
    if (remaining * time > distance) {
      wins -= time;
      won = true;
    }
  }
  won = false;
  for (var time = maxTime; !won; time--) {
    final remaining = maxTime - time;
    if (remaining * time > distance) {
      wins -= maxTime - time;
      won = true;
    }
  }
  return wins;
}
