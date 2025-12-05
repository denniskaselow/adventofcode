import 'dart:math';

import 'package:collection/collection.dart';

import '../utils.dart';

class _Range {
  _Range({required this.from, required this.to});
  final int from;
  final int to;

  bool contains(int value) => value >= from && value <= to;

  bool canBeMerged(_Range otherRange) =>
      from <= otherRange.to + 1 && to >= otherRange.from - 1;

  _Range mergeWith(_Range otherRange) =>
      _Range(from: min(from, otherRange.from), to: max(to, otherRange.to));

  int get length => to - from + 1;
}

({Iterable<int> ingredients, Iterable<_Range> ranges}) _processInput(
  Input input,
) {
  final groups = input.getInputGroups();
  final ranges = groups.first.getLines().map((e) {
    final [from, to] = e.split('-').map(int.parse).toList();
    return _Range(from: from, to: to);
  });
  final ingredients = groups.last.getLines().map(int.parse);
  return (ranges: ranges, ingredients: ingredients);
}

int day05star1(Input input) {
  final (:ranges, :ingredients) = _processInput(input);
  var result = 0;
  for (final ingredient in ingredients) {
    for (final range in ranges) {
      if (range.contains(ingredient)) {
        result++;
        break;
      }
    }
  }

  return result;
}

int day05star2(Input input) {
  final (ranges: initialRanges, ingredients: _) = _processInput(input);

  var ranges = initialRanges;
  var hasChanges = false;
  do {
    final nextRanges = <_Range>[];
    final mergedRanges = <_Range>{};
    hasChanges = false;
    for (final (index, range) in ranges.indexed) {
      var currentRange = range;
      for (final otherRange in ranges.skip(index + 1)) {
        if (currentRange.canBeMerged(otherRange)) {
          currentRange = currentRange.mergeWith(otherRange);
          mergedRanges.add(otherRange);
          hasChanges = true;
        }
      }
      if (!mergedRanges.contains(currentRange)) {
        nextRanges.add(currentRange);
      }
    }

    ranges = nextRanges;
  } while (hasChanges);

  return ranges.map((e) => e.length).sum;
}
