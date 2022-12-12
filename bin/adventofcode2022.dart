import 'dart:io' as io;

import 'package:adventofcode2022/adventofcode2022.dart';

void main(List<String> arguments) {
  run(1, day12star1);
  run(2, day12star2);
}

void run(int star, Function(String input) solver) {
  final result = solver(_getInput());
  io.stdout.writeln('-------- RESULT $star: --------');
  io.stdout.writeln('$result');
  io.stdout.writeln('--------------------------');
}

String _getInput() => io.File('bin/input.txt')
    .readAsStringSync()
    .replaceAll('\r\n', '\n')
    .trimRight();
