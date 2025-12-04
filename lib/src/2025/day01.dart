import '../utils.dart';

Iterable<(String, int)> _processInput(Input input) =>
    input.getLines().map((e) => (e.substring(0, 1), int.parse(e.substring(1))));

int day01star1(Input input) {
  var position = 50;
  var result = 0;
  _processInput(input).forEach((line) {
    position = switch (line) {
      ('L', final count) => (position - count) % 100,
      ('R', final count) => (position + count) % 100,
      _ => throw Exception('invalid input $line'),
    };
    if (position == 0) {
      result++;
    }
  });

  return result;
}

int day01star2(Input input) {
  var position = 50;
  var result = 0;
  _processInput(input).forEach((line) {
    final (newPosition, zeroes) = switch (line) {
      ('L', final count) => (
        (position - count) % 100,
        (100 - (position == 0 ? 100 : position) + count) ~/ 100,
      ),
      ('R', final count) => (
        (position + count) % 100,
        (position + count) ~/ 100,
      ),
      _ => throw Exception('invalid input $line'),
    };
    result += zeroes;
    position = newPosition;
  });

  return result;
}
