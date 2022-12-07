import 'dart:io' as io;

import 'package:adventofcode2022/adventofcode2022.dart';

void main(List<String> arguments) {
  run(day7star1);
  run(day7star2);
}

void run(Function(String input) solver) {
  print(solver(_getInput()));
}

String _getInput() => io.File('bin/input.txt')
    .readAsStringSync()
    .replaceAll('\r\n', '\n')
    .trimRight();
