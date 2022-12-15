import 'dart:math';

int day15star1(String input) {
  const yToCheck = 2000000;
  return _processInput(input).fold(<Point>{}, (previousValue, element) {
    final sensor = element[0];
    final beacon = element[1];
    final dist = sensor.manhattenDistance(beacon);
    final deltaYCheck = (yToCheck - sensor.y).abs();
    if ((yToCheck - sensor.y).abs() < dist) {
      for (var x = -dist + deltaYCheck; x <= dist - deltaYCheck; x++) {
        previousValue.add(Point(sensor.x + x, yToCheck));
      }
    }
    previousValue.remove(beacon);
    return previousValue;
  }).length;
}

int day15star2(String input) {
  final sbPairs = _processInput(input);
  final candidates = <Point<int>>{};
  const other = 4000000;
  for (final pair in sbPairs) {
    final sensor = pair[0];
    final beacon = pair[1];
    final dist = sensor.manhattenDistance(beacon) + 1;
    for (var y = -dist; y <= dist; y++) {
      for (final x in [dist - y, -dist + y]) {
        final candidateX = sensor.x + x;
        final candidateY = sensor.y + y;
        if (candidateX >= 0 &&
            candidateY >= 0 &&
            candidateX <= other &&
            candidateY <= other) {
          candidates.add(Point<int>(candidateX, candidateY));
        }
      }
    }
  }
  for (final pair in sbPairs) {
    final notCandidates = <Point>{};
    for (final candidate in candidates) {
      final sensor = pair[0];
      final beacon = pair[1];
      final dist = sensor.manhattenDistance(beacon);
      final candidateDist = sensor.manhattenDistance(candidate);
      if (candidateDist <= dist) {
        notCandidates.add(candidate);
      }
      notCandidates.add(beacon);
    }
    candidates.removeAll(notCandidates);
  }
  final result = candidates.first;
  return result.x * 4000000 + result.y;
}

Iterable<List<Point<int>>> _processInput(String input) => input
    .split('\n')
    .map((e) => e.split(':').map((e) =>
        e.split('at')[1].split(',').map((e) => int.parse(e.split('=')[1]))))
    .map((e) =>
        [Point(e.first.first, e.first.last), Point(e.last.first, e.last.last)]);

extension ManhattenDistance on Point<int> {
  int manhattenDistance(Point<int> other) =>
      (x - other.x).abs() + (y - other.y).abs();
}
