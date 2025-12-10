import 'dart:math';

import 'package:collection/collection.dart';

import '../utils.dart';

List<
  ({
    List<Set<int>> buttons,
    Set<int> indicatorLights,
    List<int> joltageRequirements,
  })
>
_processInput(Input input) => input.getLines().map((e) {
  final [indicatorLights, ...buttons, joltageRequirements] = e
      .split(' ')
      .toList();
  return (
    indicatorLights: indicatorLights
        .replaceAll(RegExp(r'[\[\]]'), '')
        .split('')
        .indexed
        .where((element) => element.$2 == '#')
        .map((e) => e.$1)
        .toSet(),
    buttons: buttons
        .map(
          (e) => e
              .replaceAll(RegExp('[()]'), '')
              .split(',')
              .map(int.parse)
              .toSet(),
        )
        .toList(),
    joltageRequirements: joltageRequirements
        .replaceAll(RegExp('[{}]'), '')
        .split(',')
        .map(int.parse)
        .toList(),
  );
}).toList();

int day10star1(Input input) {
  final lines = _processInput(input);
  var result = 0;
  for (final (:indicatorLights, :buttons, joltageRequirements: _) in lines) {
    final tmp = _pressIndicatorButtons(indicatorLights, <int>{}, buttons);
    result += tmp.$2!.length;
  }

  return result;
}

(bool, List<Set<int>>?) _pressIndicatorButtons(
  Set<int> targetState,
  Set<int> currentState,
  List<Set<int>> buttons,
) {
  if (buttons.isEmpty) {
    return (false, null);
  }
  int? minButtonPresses;
  List<Set<int>>? bestButtons;
  for (final (index, button) in buttons.indexed) {
    final nextState = currentState.toSet();
    for (final wire in button) {
      if (nextState.contains(wire)) {
        nextState.remove(wire);
      } else {
        nextState.add(wire);
      }
    }
    final intersection = targetState.intersection(nextState);
    final targetStateReached =
        intersection.length == targetState.length &&
        intersection.length == nextState.length;
    if (targetStateReached) {
      return (true, [button]);
    }
    final tmp = _pressIndicatorButtons(
      targetState,
      nextState,
      buttons.skip(index + 1).toList(),
    );
    if (tmp.$1) {
      final nextButtons = tmp.$2!;
      if (minButtonPresses == null || minButtonPresses > nextButtons.length) {
        minButtonPresses = nextButtons.length;
        bestButtons = [button, ...nextButtons];
      }
    }
  }
  return (bestButtons != null, bestButtons);
}

int day10star2(Input input) => 0;
