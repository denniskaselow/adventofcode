import 'package:collection/collection.dart';

import '../utils.dart';

Iterable<String> _processInput(String input) => input.getLines();

int day12star1(String input) =>
    _processInput(input).map(createPermutations).map((e) => e.count).sum;

int day12star2(String input) {
  final converted = _processInput(input).map((line) {
    final [springs, config] = line.split(' ');
    final springConfig = config.split(',').map(int.parse);
    final modSprings = <String>[];
    final modConfig = <int>[];
    for (var i = 0; i < 5; i++) {
      modSprings.add(springs);
      modConfig.addAll(springConfig);
    }
    return '${modSprings.join('?')} ${modConfig.join(',')}';
  }).map(createPermutations);

  return converted.map((e) => e.count).sum;
}

({
  String config,
  int count,
  List<({int index, int last, int count})> permutations
}) createPermutations(String line) {
  final [springs, config] = line.split(' ');
  final conditions = config.split(',').map(int.parse).toList();
  final split = springs.split('').map(
        (e) => switch (e) {
          '.' => (false, false),
          '#' => (true, true),
          '?' => (true, false),
          final _ => throw Exception('invalid $e')
        },
      );
  var springPermutations =
      List.generate(1, (index) => (index: 0, last: 0, count: 1));
  final springPermutationCounts = {(index: 0, last: 0): 1};

  for (final spring in split) {
    if (spring.$1 == spring.$2) {
      springPermutations = springPermutationCounts.entries
          .map((e) => (index: e.key.index, last: e.key.last, count: e.value))
          .map(
            (e) => [
              if (spring.$1 &&
                  e.index < conditions.length &&
                  e.last < conditions[e.index])
                (index: e.index, last: e.last + 1, count: e.count)
              else if (!spring.$1 && e.last == 0)
                e
              else if (!spring.$1 && e.last == conditions[e.index])
                (index: e.index + 1, last: 0, count: e.count),
            ],
          )
          .flattened
          .toList();
    } else {
      springPermutations = springPermutationCounts.entries
          .map((e) => (index: e.key.index, last: e.key.last, count: e.value))
          .map(
            (e) => [
              if (e.index < conditions.length && e.last < conditions[e.index])
                (index: e.index, last: e.last + 1, count: e.count),
              if (e.last == 0)
                e
              else if (e.last == conditions[e.index])
                (index: e.index + 1, last: 0, count: e.count),
            ],
          )
          .flattened
          .toList();
    }
    springPermutationCounts.clear();
    for (final springPermutation in springPermutations) {
      springPermutationCounts.update(
        (index: springPermutation.index, last: springPermutation.last),
        (value) => value + springPermutation.count,
        ifAbsent: () => springPermutation.count,
      );
    }
  }

  springPermutations = springPermutations
      .where(
        (element) =>
            (element.index == conditions.length - 1 &&
                element.last == conditions.last) ||
            (element.index == conditions.length && element.last == 0),
      )
      .toList();

  final count = springPermutations.map((e) => e.count).sum;

  return (permutations: springPermutations, config: config, count: count);
}
