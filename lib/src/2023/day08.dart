import '../utils.dart';

Iterable<String> _processInput(String input) => input.getLines();

int day08star1(String input) => _getSteps(input, 'AAA');

int day08star2(String input) => _getSteps(input, 'A');

int _getSteps(String input, String startPoint) {
  final [instructionsStr, _, ...mapping] = _processInput(input).toList();
  final travelMap = mapping.map((e) {
    final [source, left, right, _] = e.split(RegExp('[ =,()]+'));
    return (source: source, left: left, right: right);
  }).fold(<String, ({String left, String right})>{}, (previousValue, element) {
    previousValue[element.source] = (left: element.left, right: element.right);
    return previousValue;
  });
  var step = 0;
  final currents =
      travelMap.keys.where((element) => element.endsWith(startPoint)).toList();
  final ghostCount = currents.length;
  final stepsNeeded = List.generate(ghostCount, (index) => 0);
  final instructions = instructionsStr.split('');
  final insCount = instructions.length;
  while (stepsNeeded.where((element) => element != 0).length != ghostCount) {
    for (final (index, current) in currents.indexed) {
      if (stepsNeeded[index] == 0) {
        final directions = travelMap[current]!;
        currents[index] = switch (instructions[step % insCount]) {
          'L' => directions.left,
          'R' => directions.right,
          final invalid => throw Exception('invalid direction $invalid'),
        };
        if (current.endsWith('Z')) {
          stepsNeeded[index] = step;
        }
      }
    }
    step++;
  }

  return stepsNeeded.map((e) => e.getPrimeFactors()).fold(
    <int>{},
    (previousValue, element) => previousValue..addAll(element),
  ).reduce((value, element) => value * element);
}
