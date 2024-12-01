import '../utils.dart';

Iterable<String> _processInput(Input input) => input.getLines();

int day01star1(Input input) {
  final start = <int>[];
  final end = <int>[];
  _processInput(input).forEach((line) {
    final converted = line.split('   ').map(int.parse);
    start.add(converted.first);
    end.add(converted.last);
  });
  start.sort();
  end.sort();
  var distance = 0;
  for (var i = 0; i < start.length; i++) {
    distance += (end[i] - start[i]).abs();
  }

  return distance;
}

int day01star2(Input input) {
  final locations = <int>[];
  final locationCount = <int, int>{};
  _processInput(input).forEach((line) {
    final converted = line.split('   ').map(int.parse);
    locations.add(converted.first);
    locationCount.update(
      converted.last,
      (value) => value + 1,
      ifAbsent: () => 1,
    );
  });
  var similarity = 0;
  for (var i = 0; i < locations.length; i++) {
    similarity += locations[i] * (locationCount[locations[i]] ?? 0);
  }

  return similarity;
}
