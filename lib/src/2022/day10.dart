import 'package:collection/collection.dart';

int day10star1(String input) {
  return _processInput(input).length;
}

int day10star2(String input) {
  return _processInput(input).length;
}

Iterable<String> _processInput(String input) {
  return input.split('\n');
}
