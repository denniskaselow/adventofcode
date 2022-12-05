import 'dart:io';

import 'package:adventofcode2022/adventofcode2022.dart';

void main(List<String> arguments) {
  run(day6star1);
  run(day6star2);
}

void run(Function(String input) solver) {
  print(solver(_getInput()));
}

String _getInput() => File('bin/input.txt')
    .readAsStringSync()
    .replaceAll('\r\n', '\n')
    .trimRight();
