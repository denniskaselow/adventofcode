import 'dart:io' as io;

import 'package:adventofcode2022/adventofcode2022.dart';

void main(List<String> arguments) {
  run(day10star1);
  run(day10star2);
}

void run(Function(String input) solver) {
  var result = solver(_getInput());
  print('-----');
  print('RESULT:\n$result');
  print('-----');
}

String _getInput() => io.File('bin/input.txt')
    .readAsStringSync()
    .replaceAll('\r\n', '\n')
    .trimRight();
