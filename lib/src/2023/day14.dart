import 'package:collection/collection.dart';

import '../utils.dart';

typedef Coords = ({int x, int y});

Iterable<String> _processInput(Input input) => input.getLines();

int day14star1(Input input) =>
    calcLoad(rotateField(_processInput(input), clockwise: false));

int calcLoad(List<String> field) {
  final firstCube = field.map(
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

List<String> rotateField(Iterable<String> field, {bool clockwise = true}) =>
    switch (clockwise) {
      true => field.toList().reversed,
      false => field,
    }
        .indexed
        .fold(List.generate(field.first.length, (index) => <String>[]),
            (previousValue, element) {
          final line = switch (clockwise) {
            true => element.$2.split(''),
            false => element.$2.split('').reversed,
          };
          for (final (index, char) in line.indexed) {
            previousValue[index].add(char);
          }
          return previousValue;
        })
        .map((e) => e.join())
        .toList();

Map<String, int> fieldStates = {};

int day14star2(Input input) {
  final originalField = _processInput(input);
  final rollWestField =
      originalField.map((e) => e.replaceAll('O', '.')).toList();
  final rollNorthField = rotateField(rollWestField, clockwise: false).toList();
  final rollEastField = rotateField(rollNorthField, clockwise: false).toList();
  final rollSouthField = rotateField(rollEastField, clockwise: false).toList();

  final fields = [rollNorthField, rollWestField, rollSouthField, rollEastField];
  var currentFieldState = rotateField(originalField, clockwise: false).toList();
  const maxCycle = 1000000000;
  for (var cycle = 0; cycle < maxCycle; cycle++) {
    for (final field in fields) {
      final rollingRockGroups = currentFieldState.indexed
          .map(
            (line) => RegExp('([O.]+)')
                .allMatches(line.$2)
                .where((element) => element.groupCount > 0)
                .map(
                  (e) => (x: e.start, value: e.group(1)!),
                )
                .map(
                  (e) => (
                    x: e.x,
                    length: 'O'.allMatches(e.value).length,
                    y: line.$1
                  ),
                )
                .where((element) => element.length > 0),
          )
          .flattened
          .fold(
        <int, Set<({int x, int length})>>{},
        (previousValue, element) => previousValue
          ..update(
            element.y,
            (value) => value..add((x: element.x, length: element.length)),
            ifAbsent: () => {(x: element.x, length: element.length)},
          ),
      );
      currentFieldState.clear();
      for (final (index, line) in field.indexed) {
        var currentLine = line;
        for (final rollingRocksGroup
            in rollingRockGroups[index] ?? <({int length, int x})>[]) {
          currentLine = currentLine.replaceRange(
            rollingRocksGroup.x,
            rollingRocksGroup.x + rollingRocksGroup.length,
            'O' * rollingRocksGroup.length,
          );
        }
        currentFieldState.add(currentLine);
      }
      currentFieldState = rotateField(currentFieldState);
    }
    final endState = currentFieldState.join('|');
    if (fieldStates[endState] case final lastSeen?) {
      final cycleLength = cycle - lastSeen;
      currentFieldState = fieldStates.entries
          .where(
            (element) =>
                lastSeen + (maxCycle - lastSeen - 1) % cycleLength ==
                element.value,
          )
          .first
          .key
          .split('|');
      break;
    }
    fieldStates[endState] = cycle;
  }
  var sum = 0;
  for (final (index, line)
      in rotateField(currentFieldState, clockwise: false).indexed) {
    sum += (index + 1) * 'O'.allMatches(line).length;
  }
  return sum;
}
