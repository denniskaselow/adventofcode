import 'package:collection/collection.dart';

import '../utils.dart';

Iterable<String> _processInput(String input) => input.getLines();

int day12star1(String input) =>
    _processInput(input).map(createPermutations).sum;

int day12star2(String input) =>
    _processInput(input).map(unfold).map(createPermutations).sum;

String unfold(String line) {
  final [springs, config] = line.split(' ');
  final springConfig = config.split(',').map(int.parse);
  final modSprings = <String>[];
  final modConfig = <int>[];
  for (var i = 0; i < 5; i++) {
    modSprings.add(springs);
    modConfig.addAll(springConfig);
  }
  return '${modSprings.join('?')} ${modConfig.join(',')}';
}

int createPermutations(String line) {
  final [allSprings, springCondition] = line.split(' ');
  final conditions = springCondition.split(',').map(int.parse).toList();
  final springs = allSprings.split('');
  var springPermutations = [(group: 0, amount: 0, permutations: 1)];
  final springPermutationCounts = {(group: 0, amount: 0): 1};
  var springsChecked = 0;
  for (final spring in springs) {
    if (spring != '?') {
      springPermutations = springPermutationCounts.entries
          .map(
            (e) => (
              group: e.key.group,
              amount: e.key.amount,
              permutations: e.value
            ),
          )
          .map(
            (e) => [
              if (spring == '#' &&
                  e.group < conditions.length &&
                  e.amount < conditions[e.group])
                (
                  group: e.group,
                  amount: e.amount + 1,
                  permutations: e.permutations
                )
              else if (spring == '.' && e.amount == 0)
                e
              else if (spring == '.' && e.amount == conditions[e.group])
                (group: e.group + 1, amount: 0, permutations: e.permutations),
            ],
          )
          .flattened
          .toList();
    } else {
      springPermutations = springPermutationCounts.entries
          .map(
            (e) => (
              group: e.key.group,
              amount: e.key.amount,
              permutations: e.value
            ),
          )
          .map(
            (e) => [
              if (e.group < conditions.length && e.amount < conditions[e.group])
                (
                  group: e.group,
                  amount: e.amount + 1,
                  permutations: e.permutations
                ),
              if (e.amount == 0)
                e
              else if (e.amount == conditions[e.group])
                (group: e.group + 1, amount: 0, permutations: e.permutations),
            ],
          )
          .flattened
          .toList();
    }
    springsChecked++;
    final springsLeft = allSprings.substring(springsChecked).length;
    springPermutations = springPermutations
        .where(
          (element) => element.group > conditions.length
              ? element.amount == 0
              : springsLeft + element.amount >=
                  conditions.skip(element.group).sum,
        )
        .toList();

    springPermutationCounts.clear();
    for (final springPermutation in springPermutations) {
      springPermutationCounts.update(
        (group: springPermutation.group, amount: springPermutation.amount),
        (value) => value + springPermutation.permutations,
        ifAbsent: () => springPermutation.permutations,
      );
    }
  }

  return springPermutations.map((e) => e.permutations).sum;
}