import 'dart:io' as io;

import 'package:adventofcode/adventofcode2025.dart';
import 'package:adventofcode/src/utils.dart';

void main(List<String> arguments) {
  run(1, day08star1);
  run(2, day08star2);
}

void run(int star, dynamic Function(Input input) solver) {
  final input = _getInput();
  final stopwatch = Stopwatch()..start();
  final result = solver(input);
  final duration = stopwatch.elapsed;
  io.stdout.writeln('-------- RESULT $star: --------');
  io.stdout.writeln('$result');
  io.stdout.writeln('$duration');
  io.stdout.writeln('---------------------------');
}

Input _getInput() =>
    Input(io.File('bin/input.txt').readAsStringSync().trimRight());
