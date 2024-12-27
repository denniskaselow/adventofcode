import '../utils.dart';

Iterable<List<String>> _processInput(Input input) =>
    input.getLines().map((e) => e.split(' '));

int day02star1(Input input) => _processInput(input)
    .fold(
      (x: 0, y: 0),
      (previousValue, element) => switch (element) {
        ['forward', final x] => (
          x: previousValue.x + int.parse(x),
          y: previousValue.y,
        ),
        ['up', final y] => (
          x: previousValue.x,
          y: previousValue.y - int.parse(y),
        ),
        ['down', final y] => (
          x: previousValue.x,
          y: previousValue.y + int.parse(y),
        ),
        _ => throw ArgumentError('unexpected value $element'),
      },
    )
    .convert((self) => self.x * self.y);

int day02star2(Input input) => _processInput(input)
    .fold(
      (x: 0, y: 0, aim: 0),
      (previousValue, element) => switch (element) {
        ['forward', final x] => (
          x: previousValue.x + int.parse(x),
          y: previousValue.y + int.parse(x) * previousValue.aim,
          aim: previousValue.aim,
        ),
        ['up', final y] => (
          x: previousValue.x,
          y: previousValue.y,
          aim: previousValue.aim - int.parse(y),
        ),
        ['down', final y] => (
          x: previousValue.x,
          y: previousValue.y,
          aim: previousValue.aim + int.parse(y),
        ),
        _ => throw ArgumentError('unexpected value $element'),
      },
    )
    .convert((self) => self.x * self.y);
