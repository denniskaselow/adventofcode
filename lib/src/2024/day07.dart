import 'package:collection/collection.dart';

import '../utils.dart';

List<({int result, List<int> values})> _processInput(Input input) =>
    input.getLines().map((line) {
      final [result, values] = line.split(':');
      final value =
          RegExp(
            r'(\d+)',
          ).allMatches(values).map((match) => int.parse(match[1]!)).toList();

      return (result: int.parse(result), values: value);
    }).toList();

int day07star1(Input input) =>
    _processInput(input)
        .where(
          (element) =>
              _validAddition(
                element.result,
                0,
                element.values.reversed.toList(),
              ) ||
              _validMultiplication(
                element.result,
                1,
                element.values.reversed.toList(),
              ),
        )
        .map((element) => element.result)
        .sum;

bool _validAddition(
  int targetResult,
  int currentResult,
  List<int> remaining, {
  bool withConcat = false,
}) {
  final current = remaining.removeLast();
  final addResult = currentResult + current;
  if (addResult > targetResult) {
    return false;
  }
  if (remaining.isEmpty) {
    if (addResult == targetResult) {
      return true;
    }
    return false;
  }
  return _validAddition(
        targetResult,
        addResult,
        remaining.toList(),
        withConcat: withConcat,
      ) ||
      _validMultiplication(
        targetResult,
        addResult,
        remaining.toList(),
        withConcat: withConcat,
      ) ||
      (withConcat && _validConcat(targetResult, addResult, remaining));
}

bool _validMultiplication(
  int targetResult,
  int currentResult,
  List<int> remaining, {
  bool withConcat = false,
}) {
  final current = remaining.removeLast();
  final multResult = currentResult * current;
  if (multResult > targetResult) {
    return false;
  }
  if (remaining.isEmpty) {
    if (multResult == targetResult) {
      return true;
    }
    return false;
  }
  return _validAddition(
        targetResult,
        multResult,
        remaining.toList(),
        withConcat: withConcat,
      ) ||
      _validMultiplication(
        targetResult,
        multResult,
        remaining.toList(),
        withConcat: withConcat,
      ) ||
      (withConcat && _validConcat(targetResult, multResult, remaining));
}

bool _validConcat(int targetResult, int currentResult, List<int> remaining) {
  final current = remaining.removeLast();
  final concatResult = int.parse('$currentResult$current');
  if (concatResult > targetResult) {
    return false;
  }
  // print('$concatResult = $currentResult * $current');
  if (remaining.isEmpty) {
    if (concatResult == targetResult) {
      return true;
    }
    return false;
  }
  return _validAddition(
        targetResult,
        concatResult,
        remaining.toList(),
        withConcat: true,
      ) ||
      _validMultiplication(
        targetResult,
        concatResult,
        remaining.toList(),
        withConcat: true,
      ) ||
      _validConcat(targetResult, concatResult, remaining.toList());
}

int day07star2(Input input) =>
    _processInput(input)
        .where(
          (element) =>
              _validAddition(
                element.result,
                0,
                element.values.reversed.toList(),
              ) ||
              _validMultiplication(
                element.result,
                1,
                element.values.reversed.toList(),
              ) ||
              _validConcat(element.result, 0, element.values.reversed.toList()),
        )
        .map((element) => element.result)
        .sum;
