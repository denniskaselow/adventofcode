import 'package:collection/collection.dart';

int day12star1(String input) {
  return _processInput(input).length;
}

int day12star2(String input) {
  return _processInput(input).length;
}

Iterable<String> _processInput(String input) {
  return input.split('\n');
}
