import 'dart:io';

import 'package:adventofcode2022/adventofcode2022.dart';

void main(List<String> arguments) {
  run(day3star1);
  run(day3star2);
}

void run(Function(String input) solver) {
  print(solver(_getInput()));
}

String _getInput() =>
    File('bin/input.txt').readAsStringSync().replaceAll('\r\n', '\n').trim();
