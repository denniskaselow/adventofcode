import 'package:collection/collection.dart';

Iterable<String> _processInput(String input) {
  return input.split('\n');
}

String day5star1(String input) {
  return _run(input, move1);
}

String day5star2(String input) {
  return _run(input, move2);
}

String _run(
    String input,
    void Function(
            List<List<String>> rows, int amount, int fromColumn, int toColumn)
        move) {
  final lines = _processInput(input);
  final stackCount = (lines.first.length + 1) ~/ 4;
  final stacks = List<List<String>>.generate(stackCount, (index) => <String>[]);
  var isStack = true;
  for (final line in lines) {
    if (line.isEmpty) {
      isStack = false;
      continue;
    }
    if (isStack) {
      final items = List.generate(stackCount,
          (index) => line.substring(index * 4 + 1, index * 4 + 2).trim());
      items.forEachIndexed((index, element) {
        if (element.isNotEmpty) {
          stacks[index].insert(0, element);
        }
      });
    } else {
      final command = RegExp(r'(\d+)')
          .allMatches(line)
          .map((e) => int.parse(e[0]!))
          .toList();
      final amount = command[0];
      final from = command[1] - 1;
      final to = command[2] - 1;
      move(stacks, amount, from, to);
    }
  }
  return List.generate(stackCount, (index) => stacks[index].last).join();
}

void move1(
    List<List<String>> stacks, int amount, int fromColumn, int toColumn) {
  for (var i = 0; i < amount; i++) {
    stacks[toColumn].add(stacks[fromColumn].removeLast());
  }
}

void move2(
    List<List<String>> stacks, int amount, int fromColumn, int toColumn) {
  stacks[toColumn].addAll(stacks[fromColumn]
      .getRange(stacks[fromColumn].length - amount, stacks[fromColumn].length));
  stacks[fromColumn].removeRange(
      stacks[fromColumn].length - amount, stacks[fromColumn].length);
}
