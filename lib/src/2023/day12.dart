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
  var state = {(group: 0, amount: 0): 1};
  var nextState = <({int group, int amount}), int>{};
  var brokenSpringsLeft = springs.where((element) => element != '.').length;
  final minRequiredBrokenSpringsLeft = [];
  for (var i = 0; i <= conditions.length; i++) {
    minRequiredBrokenSpringsLeft.add(conditions.skip(i).sum);
  }
  for (final spring in springs) {
    if (spring != '.') {
      brokenSpringsLeft--;
    }
    for (final MapEntry(key: (:group, :amount), value: permutations)
        in state.entries) {
      if (spring == '#' || spring == '?') {
        if (group < conditions.length && amount < conditions[group]) {
          nextState[(group: group, amount: amount + 1)] = permutations;
        }
      }
      if (spring == '.' || spring == '?') {
        if (amount == 0) {
          nextState.update(
            (group: group, amount: 0),
            (value) => value + permutations,
            ifAbsent: () => permutations,
          );
        } else if (amount == conditions[group]) {
          nextState.update(
            (group: group + 1, amount: 0),
            (value) => value + permutations,
            ifAbsent: () => permutations,
          );
        }
      }
    }

    nextState.removeWhere(
      (key, value) =>
          brokenSpringsLeft + key.amount <
          minRequiredBrokenSpringsLeft[key.group],
    );

    state.clear();
    (state, nextState) = (nextState, state);
  }

  return state.values.sum;
}
