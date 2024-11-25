import '../utils.dart';

int day1star1(Input input) => _processInput(input).reduce(sum);

int day1star2(Input input) =>
    1 + _processInput(input).reduceUntil(sum, (value) => value == -1);

Iterable<int> _processInput(Input input) =>
    input.getLines().first.split('').map((e) => ') ('.indexOf(e) - 1);
