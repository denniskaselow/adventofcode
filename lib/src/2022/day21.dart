import 'package:more/more.dart';

int day21star1(String input) {
  final monkeys = _processInput(input);
  return _evaluateMoneky(monkeys, 'root');
}

int day21star2(String input) => _processInput(input).length;

int _evaluateMoneky(Map<String, String> monkeys, String monkey) {
  final input = monkeys[monkey]!.split(' ');
  if (input.length == 1) {
    return int.parse(input[0]);
  }
  switch (input[1]) {
    case '+':
      return _evaluateMoneky(monkeys, input[0]) +
          _evaluateMoneky(monkeys, input[2]);
    case '-':
      return _evaluateMoneky(monkeys, input[0]) -
          _evaluateMoneky(monkeys, input[2]);
    case '*':
      return _evaluateMoneky(monkeys, input[0]) *
          _evaluateMoneky(monkeys, input[2]);
    case '/':
      return _evaluateMoneky(monkeys, input[0]) ~/
          _evaluateMoneky(monkeys, input[2]);
  }
  throw Exception('unknonw operation ${input[1]}');
}

Map<String, String> _processInput(String input) => input
    .split('\n')
    .map((e) => e.split(': '))
    .toMap(key: (element) => element[0], value: (element) => element[1]);
