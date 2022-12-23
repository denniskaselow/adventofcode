import 'dart:io' as io;

import 'package:adventofcode2022/adventofcode2022.dart';

void main(List<String> arguments) {
  run(1, day21star1);
  run(2, day21star2);
}

void run(int star, Function(String input) solver) {
  final input = _getInput();
  final stopwatch = Stopwatch()..start();
  final result = solver(input);
  final duration = stopwatch.elapsed;
  io.stdout.writeln('-------- RESULT $star: --------');
  io.stdout.writeln('$result');
  io.stdout.writeln('$duration');
  io.stdout.writeln('---------------------------');
}

String _getInput() => io.File('bin/input.txt')
    .readAsStringSync()
    .replaceAll('\r\n', '\n')
    .trimRight();
