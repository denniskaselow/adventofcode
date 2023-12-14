import 'package:collection/collection.dart';

import '../utils.dart';

typedef Coords = ({int x, int y});

Iterable<String> _processInput(String input) => input.getLines();

int day14star1(String input) {
  final rotatedField = rotateField(_processInput(input));
  final firstCube = rotatedField.map(
    (line) => RegExp('([O.]+)')
        .allMatches(line)
        .where((element) => element.groupCount > 0)
        .map(
          (e) => (distance: line.length - e.start, value: e.group(1)!),
        )
        .map(
          (e) => (
            from: e.distance,
            to: e.distance - 'O'.allMatches(e.value).length
          ),
        ),
  );
  final load = firstCube.map(
    (e) => e.map((e) {
      final (:from, :to) = e;
      final start = (from * from + from) ~/ 2;
      final end = (to * to + to) ~/ 2;
      return start - end;
    }),
  );
  return load.map((e) => e.sum).sum;
}

List<String> rotateField(Iterable<String> field) => field.indexed
    .fold(List.generate(field.first.length, (index) => <String>[]),
        (previousValue, element) {
      for (final (index, char) in element.$2.split('').indexed) {
        previousValue[index].add(char);
      }
      return previousValue;
    })
    .map((e) => e.join())
    .toList();

int day14star2(String input) => _processInput(input).length;
