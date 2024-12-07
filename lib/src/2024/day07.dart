import 'package:collection/collection.dart';

import '../utils.dart';

List<({int result, List<int> values})> _processInput(Input input) =>
    input.getLines().map((line) {
      final [result, values] = line.split(':');
      final value =
          RegExp(
            r'(\d+)',
          ).allMatches(values).map((match) => int.parse(match[1]!)).toList();

      return (result: int.parse(result), values: value.reversed.toList());
    }).toList();

int day07star1(Input input) =>
    _processInput(input)
        .where(
          (element) => _validOperation(
            element.result,
            element.values.removeLast(),
            element.values.toList(),
          ),
        )
        .map((element) => element.result)
        .sum;

bool _validOperation(
  int targetResult,
  int currentResult,
  List<int> remaining, {
  bool withConcat = false,
}) {
  final current = remaining.removeLast();
  final results = [
    currentResult + current,
    currentResult * current,
    if (withConcat) int.parse('$currentResult$current'),
  ];
  if (remaining.isEmpty) {
    for (final result in results) {
      if (result == targetResult) {
        return true;
      }
    }
    return false;
  }
  for (final result in results) {
    if (result > targetResult) {
      return false;
    }
    final isValid = _validOperation(
      targetResult,
      result,
      remaining.toList(),
      withConcat: withConcat,
    );
    if (isValid) {
      return isValid;
    }
  }
  return false;
}

int day07star2(Input input) =>
    _processInput(input)
        .where(
          (element) => _validOperation(
            element.result,
            element.values.removeLast(),
            element.values.toList(),
            withConcat: true,
          ),
        )
        .map((element) => element.result)
        .sum;
