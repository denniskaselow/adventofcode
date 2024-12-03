

import '../utils.dart';

List<Input> _processInput(Input input) => input.getInputGroups();

int day19star1(Input input) {
  final [conversions, molecule] = _processInput(input);

  final converters = conversions
      .getLines()
      .map((line) => RegExp(r'(\w+) => (\w+)').firstMatch(line)!)
      .fold(
        <String, List<String>>{},
        (previous, element) =>
            previous..update(
              element[1]!,
              (value) => value..add(element[2]!),
              ifAbsent: () => [element[2]!],
            ),
      );

  return RegExp('(${converters.keys.join('|')})')
      .allMatches(molecule)
      .map(
        (match) => converters[match.group(0)]!.map(
          (targetMolecule) =>
              molecule.replaceRange(match.start, match.end, targetMolecule),
        ),
      )
      .expand((element) => element)
      .toSet()
      .length;
}

int day19star2(Input input) {
  final [conversions, String medicineMolecule] = _processInput(input);

  final converters = conversions
      .getLines()
      .map((line) => RegExp(r'(\w+) => (\w+)').firstMatch(line)!)
      .fold(
        <String, List<String>>{},
        (previous, element) =>
            previous..update(
              element[2]!,
              (value) => value..add(element[1]!),
              ifAbsent: () => [element[1]!],
            ),
      );

  final toConvert = [medicineMolecule];
  final conversionSteps = {medicineMolecule: 0};
  final converted = <String>{};
  while (toConvert.isNotEmpty) {
    final current = toConvert.removeAt(0);
    if (!converted.contains(current)) {
      for (final converterKey in converters.keys) {
        final result =
            RegExp('($converterKey)')
                .allMatches(current)
                .map(
                  (match) => converters[match.group(0)]!.map(
                    (targetMolecule) => current.replaceRange(
                      match.start,
                      match.end,
                      targetMolecule,
                    ),
                  ),
                )
                .expand((element) => element)
                .toSet();

        final count = conversionSteps[current]! + 1;
        if (!result.contains('e')) {
          for (final createdMolecule in result) {
            if (!conversionSteps.containsKey(createdMolecule) &&
                !createdMolecule.contains('e')) {
              conversionSteps.putIfAbsent(createdMolecule, () => count);
              toConvert.add(createdMolecule);
            }
          }
        } else {
          return count;
        }
      }
      converted.add(current);
      toConvert.sort((a, b) => a.length.compareTo(b.length));
    }
  }
  return -1;
}
