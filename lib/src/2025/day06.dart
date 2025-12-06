import '../utils.dart';

List<List<String>> _processInput(Input input) => input
    .getLines()
    .map(
      (e) => e
          .split(RegExp(r'\s+'))
          .map((e) => e.trim())
          .where((element) => element.isNotEmpty)
          .toList(),
    )
    .toList();

int day06star1(Input input) {
  final [...rest, operations] = _processInput(input);
  final numbers = rest.map((e) => e.map(int.parse).toList()).toList();

  var result = 0;
  for (var column = 0; column < operations.length; column++) {
    result += switch (operations[column]) {
      '+' => numbers.fold(
        0,
        (previousValue, element) => previousValue + element[column],
      ),
      '*' => numbers.fold(
        1,
        (previousValue, element) => previousValue * element[column],
      ),
      final operation => throw Exception('Invalid operation $operation'),
    };
  }

  return result;
}

int day06star2(Input input) {
  final originalLines = input.getLines();
  final buffer = StringBuffer();
  for (var column = originalLines.first.length - 1; column >= 0; column--) {
    final lineBuffer = StringBuffer();
    for (var row = 0; row < originalLines.length; row++) {
      lineBuffer.write(originalLines[row][column]);
    }
    buffer.writeln(lineBuffer.toString().trim());
  }
  final convertedInput = Input(buffer.toString());
  final inputGroups = convertedInput.getInputGroups();
  var result = 0;
  for (final group in inputGroups) {
    final lines = group.getLines();
    final operation = lines.last[lines.last.length - 1];
    var tmp = operation == '+' ? 0 : 1;
    for (final (index, line) in lines.reversed.indexed) {
      int number;
      if (index == 0) {
        number = int.parse(line.substring(0, line.length - 1));
      } else {
        number = int.parse(line);
      }
      tmp = operation == '+' ? tmp + number : tmp * number;
    }
    result += tmp;
  }

  return result;
}
