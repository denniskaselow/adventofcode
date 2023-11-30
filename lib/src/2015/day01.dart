import '../utils.dart';

int day1star1(String input) => _processInput(input).reduce(sum);

int day1star2(String input) => 1 + _processInput(input).reduceUntil(sum, -1);

Iterable<int> _processInput(String input) =>
    input.split('\n').first.split('').map((e) => ') ('.indexOf(e) - 1);
