import '../utils.dart';

typedef Mirror = ({int length, int index, bool horizontal});

Iterable<String> _processInput(Input input) => input.getLines();

int day13star1(Input input) => _getSolution(input, 0);

int day13star2(Input input) => _getSolution(input, 1);

int _getSolution(Input input, int smudges) {
  final allLines = _processInput(input);
  final allFields = allLines.fold(
    <List<String>>[[]],
    (previousValue, element) => element == ''
        ? (previousValue..add([]))
        : (previousValue..last.add(element)),
  );
  final mirrors = <Mirror>[];
  for (final field in allFields) {
    final rotatedField = rotateField(field);
    final tmpMirrors = getPossibleMirrors(field);
    final tmpMirrorsVert = getPossibleMirrors(rotatedField, horizontal: false);

    mirrors.add(
      tmpMirrors.entries
          .where((element) => element.value == field.length - smudges)
          .followedBy(
            tmpMirrorsVert.entries.where(
              (element) => element.value == rotatedField.length - smudges,
            ),
          )
          .fold(
        // the earliest index is important, not the longest reflection...
        (index: 999, length: 0, horizontal: true),
        (previousValue, element) => previousValue.index > element.key.index
            ? element.key
            : previousValue,
      ),
    );
  }
  return mirrors.fold(
    0,
    (previousValue, element) =>
        previousValue +
        (element.horizontal ? element.index : (element.index * 100)),
  );
}

List<String> rotateField(List<String> field) => field.indexed
    .fold(List.generate(field.first.length, (index) => <String>[]),
        (previousValue, element) {
      for (final (index, char) in element.$2.split('').indexed) {
        previousValue[index].add(char);
      }
      return previousValue;
    })
    .map((e) => e.join())
    .toList();

Map<Mirror, int> getPossibleMirrors(
  List<String> field, {
  bool horizontal = true,
}) {
  final maxReflectionLength = field.first.length ~/ 2;
  final tmpMirrors = <Mirror, int>{};
  for (var reflectionLength = maxReflectionLength;
      reflectionLength > 0;
      reflectionLength--) {
    for (final line in field) {
      final reversedLine = line.split('').reversed.join();
      final index = line.length - reflectionLength;
      final toCheck = line.substring(index);
      final toCheckMirrored = reversedLine.substring(
        reflectionLength,
        reflectionLength + reflectionLength,
      );
      if (toCheck == toCheckMirrored) {
        tmpMirrors.update(
          (index: index, length: reflectionLength, horizontal: horizontal),
          (value) => value + 1,
          ifAbsent: () => 1,
        );
      }
      final toCheckFront = line.substring(0, reflectionLength);
      final toCheckMirroredFront = reversedLine.substring(
        line.length - reflectionLength - reflectionLength,
        line.length - reflectionLength,
      );
      if (toCheckFront == toCheckMirroredFront) {
        tmpMirrors.update(
          (
            index: reflectionLength,
            length: reflectionLength,
            horizontal: horizontal
          ),
          (value) => value + 1,
          ifAbsent: () => 1,
        );
      }
    }
  }
  return tmpMirrors;
}
