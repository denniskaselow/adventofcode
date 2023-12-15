import 'package:collection/collection.dart';

import '../utils.dart';

typedef Lens = ({int hash, String label, int length});

Iterable<String> _processInput(String input) =>
    input.getLines().first.split(',');

int day15star1(String input) => _processInput(input)
    .map(
      (e) => e.codeUnits.fold(
        0,
        (previousValue, element) => ((previousValue + element) * 17) % 256,
      ),
    )
    .sum;

int day15star2(String input) {
  final lenses = _processInput(input).map(
    (e) => switch (e.split(RegExp('[=-]'))) {
      [final label, final length] => (
          label: label,
          hash: label.codeUnits.fold(
            0,
            (previousValue, element) => ((previousValue + element) * 17) % 256,
          ),
          length: int.tryParse(length) ?? -1
        ),
      final _ => throw Exception('invalid input $e'),
    },
  );

  final boxes = <int, List<Lens>>{};
  for (final lens in lenses) {
    boxes.update(
      lens.hash,
      (value) {
        var found = false;
        var index = -1;
        for (final (i, existingLenses) in value.indexed) {
          if (existingLenses.label == lens.label) {
            index = i;
            found = true;
            break;
          }
        }
        if (lens.length == -1) {
          if (found) {
            value.removeAt(index);
          }
        } else {
          if (found) {
            value[index] = lens;
          } else if (!found) {
            value.add(lens);
          }
        }
        return value;
      },
      ifAbsent: () => [lens],
    );
  }

  return boxes.entries.fold(
    0,
    (sum, box) =>
        sum +
        box.value.indexed.fold(
          0,
          (boxSum, indexedLens) =>
              boxSum +
              (1 + box.key) * (indexedLens.$1 + 1) * indexedLens.$2.length,
        ),
  );
}
