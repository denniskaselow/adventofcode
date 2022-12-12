import 'package:collection/collection.dart';

typedef ManageWorryLevel = int Function(int, int);

int day11star1(String input) => executeRounds(input, 20, (x, _) => x ~/ 3);
int day11star2(String input) =>
    executeRounds(input, 10000, (x, maxWorry) => x % maxWorry);

int executeRounds(String input, int rounds, ManageWorryLevel manageWorryLevel) {
  final monkeys = _processInput(input);
  final inspections = List.filled(monkeys.length, 0);
  final maxWorry =
      monkeys.fold(1, (value, element) => value * element[2].first);
  for (var round = 0; round < rounds; round++) {
    for (var i = 0; i < monkeys.length; i++) {
      final monkey = monkeys[i];
      for (final item in monkey[0]) {
        final op = monkey[1];
        final divisibleBy = monkey[2][0];
        final ifTrue = monkey[3][0];
        final ifFalse = monkey[4][0];
        final v1 = op[1] == 0 ? item : op[1];
        final worryLevel =
            manageWorryLevel(op[0] == 0 ? item * v1 : item + v1, maxWorry);
        final target = worryLevel % divisibleBy == 0 ? ifTrue : ifFalse;
        monkeys[target.toInt()][0].add(worryLevel);
        inspections[i]++;
      }
      monkey[0].clear();
    }
  }
  inspections.sort((a, b) => b - a);
  return inspections[0] * inspections[1];
}

List<List<List<int>>> _processInput(String input) => input
    .replaceAll(',', '')
    .split('\n\n')
    .map((e) => e
        .split('\n')
        .skip(1)
        .map((e) => e.split(':')[1].trim().split(' '))
        .mapIndexed((index, element) => index == 1
            ? element
                .skip(3)
                .map((e) => e == '*'
                    ? '0'
                    : e == '+'
                        ? '1'
                        : e == 'old'
                            ? '0'
                            : e)
                .toList()
            : index > 1
                ? [element.last]
                : element)
        .map((e) => e.map(int.parse).toList())
        .toList())
    .toList();
