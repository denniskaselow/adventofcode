import 'dart:io' as io;

import 'package:adventofcode/adventofcode2023.dart';

void main(List<String> arguments) {
  run(1, day23star1);
  run(2, day23star2);
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

String _getInput() => io.File('bin/input.txt').readAsStringSync().trimRight();
