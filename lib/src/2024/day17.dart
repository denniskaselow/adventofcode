import 'dart:math';

import '../utils.dart';

List<Input> _processInput(Input input) => input.getInputGroups();

String day17star1(Input input) {
  final [registersGroup, programLine] = _processInput(input);
  final [regA, regB, regC] =
      registersGroup
          .getLines()
          .map((e) => int.parse(RegExp(r'\d+').firstMatch(input)![0]!))
          .toList();
  final program = programLine.split(' ')[1].split(',').map(int.parse).toList();

  return _executeProgram(program, regA, regB, regC).join(',');
}

List<int> _executeProgram(List<int> program, int inA, int inB, int inC) {
  var regA = inA;
  var regB = inB;
  var regC = inC;
  int getLiteralOperand(int instructionPointer) =>
      program[instructionPointer + 1];
  int getComboOperand(int instructionPointer) => switch (getLiteralOperand(
    instructionPointer,
  )) {
    final op when op >= 0 && op <= 3 => op,
    == 4 => regA,
    == 5 => regB,
    == 6 => regC,
    final op => throw ArgumentError('invalid op $op'),
  };

  final result = <int>[];

  for (
    var instructionPointer = 0;
    instructionPointer < program.length;
    instructionPointer += 2
  ) {
    final opcode = program[instructionPointer];
    var increase = true;
    switch (opcode) {
      case 0:
        // adv
        regA = regA ~/ pow(2, getComboOperand(instructionPointer));
      case 1:
        // bxl
        regB = regB ^ getLiteralOperand(instructionPointer);
      case 2:
        // bst
        regB = getComboOperand(instructionPointer) % 8;
      case 3:
        //jnz
        if (regA != 0) {
          instructionPointer = getLiteralOperand(instructionPointer);
          increase = false;
        }
      case 4:
        // bcx
        regB = regB ^ regC;
      case 5:
        // out
        result.add(getComboOperand(instructionPointer) % 8);
      case 6:
        // bdv
        regB = regA ~/ pow(2, getComboOperand(instructionPointer));
      case 7:
        // cdv
        regC = regA ~/ pow(2, getComboOperand(instructionPointer));
    }
    if (!increase) {
      instructionPointer -= 2;
    }
  }

  return result;
}

int day17star2(Input input) {
  final program =
      _processInput(input)[1].split(' ')[1].split(',').map(int.parse).toList();
  final expectedOutput = program.toList();

  // 2,4, regB = regA % 8
  // 1,7, regB = regB ^ 7
  // 7,5, regC = regA ~/ pow(8, regB)
  // 1,7, regB = regB ^ 7
  // 4,6, regB = regB ^ regC
  // 0,3, regA = regA ~/ 8
  // 5,5, print(regB % 8)
  // 3,0

  final result = <int>[];
  for (var i = 0; i < 8; i++) {
    result.addAll(_reverse(program, expectedOutput.toList(), i));
  }
  result.sort();

  return result.first;
}

List<int> _reverse(List<int> program, List<int> expectedOutput, int regA) {
  final result = _executeProgram(program, regA, 0, 0);
  final expected = expectedOutput.removeLast();

  if (result[0] == expected) {
    if (expectedOutput.isEmpty) {
      return [regA];
    }
    final accepted = <int>[];
    for (var i = 0; i < 8; i++) {
      final next = _reverse(program, expectedOutput.toList(), regA * 8 + i);
      accepted.addAll(next);
    }
    return accepted;
  }
  return [];
}
