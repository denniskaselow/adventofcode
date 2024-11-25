import 'dart:collection';

import 'package:collection/collection.dart';

import '../utils.dart';

Iterable<String> _processInput(Input input) => input.getLines();

int day12star1(Input input) =>
    _processInput(input).map(part1).map(createPermutations).sum;

int day12star2(Input input) =>
    _processInput(input).map(part2).map(createPermutations).sum;

(String, List<int>) part1(String line) {
  final [springs, config] = line.split(' ');
  final springConfig = config.split(',').map(int.parse).toList();
  return (springs, springConfig);
}

(String, List<int>) part2(String line) {
  final [springs, config] = line.split(' ');
  final springConfig = config.split(',').map(int.parse);
  final modSprings = <String>[];
  final modConfig = <int>[];
  for (var i = 0; i < 5; i++) {
    modSprings.add(springs);
    modConfig.addAll(springConfig);
  }
  return (modSprings.join('?'), modConfig);
}

int createPermutations((String, List<int>) line) {
  final (allSprings, conditions) = line;
  final springs = allSprings.split('');
  var state = HashMap<Permutation, int>();
  state[const Permutation(group: 0, amount: 0)] = 1;
  var nextState = HashMap<Permutation, int>();
  var brokenSpringsLeft = springs.where((element) => element != '.').length;
  final minRequiredBrokenSpringsLeft = <int>[];
  for (var i = 0; i <= conditions.length; i++) {
    minRequiredBrokenSpringsLeft.add(conditions.skip(i).sum);
  }
  for (final spring in springs) {
    if (spring != '.') {
      brokenSpringsLeft--;
    }
    for (final MapEntry(key: Permutation(:group, :amount), value: permutations)
        in state.entries) {
      if (spring == '#' || spring == '?') {
        if (group < conditions.length && amount < conditions[group]) {
          nextState[Permutation(group: group, amount: amount + 1)] =
              permutations;
        }
      }
      if (spring == '.' || spring == '?') {
        if (amount == 0) {
          nextState.update(
            Permutation(group: group, amount: 0),
            (value) => value + permutations,
            ifAbsent: () => permutations,
          );
        } else if (amount == conditions[group]) {
          nextState.update(
            Permutation(group: group + 1, amount: 0),
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

class Permutation {
  const Permutation({required this.group, required this.amount});
  final int group;
  final int amount;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Permutation &&
          runtimeType == other.runtimeType &&
          group == other.group &&
          amount == other.amount;

  @override
  int get hashCode => group ^ amount;
}
