import 'package:collection/collection.dart';

Iterable<String> _processInput(String input) {
  return input.split('\n');
}

int day0star1(String input) {
  return _processInput(input).length;
}

int day0star2(String input) {
  return _processInput(input).length;
}
