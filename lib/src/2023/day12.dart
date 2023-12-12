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

  // print(converted.join('\n'));

  return converted.map((e) => e.count).sum;
}

({String config, int count, List<List<int>> permutations}) createPermutations(
    String line) {
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
  // print(springs);
  final springPermutations =
      List.generate(1, (index) => List.generate(1, (index) => 0));
  for (final spring in split) {
    final invalidPermutations = [];
    if (spring.$1 == spring.$2) {
      if (spring.$1) {
        for (final springPermutation in springPermutations) {
          final index = springPermutation.length - 1;
          var brokenSprings = springPermutation[index];
          brokenSprings++;
          springPermutation[index] = brokenSprings;
          if (springPermutation.length > conditions.length) {
            print(
                'invalid because too many: $springPermutation vs $conditions');
            invalidPermutations.add(springPermutation);
          } else if (brokenSprings > conditions[index]) {
            // print(
            //     'invalid because to high at $index: $springPermutation vs $conditions');
            invalidPermutations.add(springPermutation);
          }
        }
      } else {
        for (final springPermutation in springPermutations) {
          if (springPermutation.last != 0) {
            final index = springPermutation.length - 1;
            if (springPermutation.last != conditions[index]) {
              invalidPermutations.add(springPermutation);
              // print(
              //     'invalid because not equal at $index: $springPermutation vs $conditions');
            }
            springPermutation.add(0);
          }
        }
      }
    } else {
      final additionalConfigs = <List<int>>[];
      for (final (permutationIndex, springPermutation)
          in springPermutations.indexed) {
        additionalConfigs.add(springPermutation.toList());
        final index = springPermutation.length - 1;
        var brokenSprings = springPermutation[index];
        brokenSprings++;
        springPermutation[index] = brokenSprings;
        if (springPermutation.length > conditions.length ||
            brokenSprings > conditions[index]) {
          // print(
          //     'invalid because to high at $index: $springPermutation vs $conditions');
          invalidPermutations.add(springPermutation);
        }
        if (additionalConfigs[permutationIndex].last != 0) {
          if (additionalConfigs[permutationIndex].last != conditions[index]) {
            invalidPermutations.add(additionalConfigs[permutationIndex]);
            // print(
            //     'invalid because not equal at $index: ${additionalConfigs[permutationIndex]} vs $conditions');
          }
          additionalConfigs[permutationIndex].add(0);
        }
      }
      springPermutations.addAll(additionalConfigs);
    }
    // print('removing invalid $invalidPermutations');
    // print(springPermutations);
    invalidPermutations.forEach(springPermutations.remove);
    // print('remaining: $springPermutations');
  }
  // print('final remaining: $springPermutations');

  var count = 0;
  for (final springPermutation in springPermutations) {
    if (springPermutation.last == 0) {
      springPermutation.removeLast();
    }
    if (springPermutation.length == conditions.length &&
        conditions.indexed
            .every((element) => element.$2 == springPermutation[element.$1])) {
      count++;
    }
  }

  return (permutations: springPermutations, config: config, count: count);
}
