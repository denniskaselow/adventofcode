import 'dart:math';

import 'package:collection/collection.dart';
import 'package:more/collection.dart';

import '../utils.dart';

List<int> _processInput(Input input) =>
    input.getLines().map(int.parse).toList();

int day22star1(Input input) {
  final seeds = _processInput(input);

  final result = <int>[];
  for (final seed in seeds) {
    var current = seed;
    for (var i = 0; i < 2000; i++) {
      current = ((current * 64) ^ current) % 16777216;
      current = ((current ~/ 32) ^ current) % 16777216;
      current = ((current * 2048) ^ current) % 16777216;
    }
    result.add(current);
  }

  return result.sum;
}

int day22star2(Input input) {
  final seeds = _processInput(input);

  final result = <int>[];
  final changes = <List<int>>[];
  final changeSequences = <Map<String, int>>[];
  for (final seed in seeds) {
    var current = seed;
    final tmp = <int>[];
    for (var i = 0; i < 2000; i++) {
      current = ((current * 64) ^ current) % 16777216;
      current = ((current ~/ 32) ^ current) % 16777216;
      current = ((current * 2048) ^ current) % 16777216;
      tmp.add(current % 10);
    }
    changes.add(tmp.window(2).map((e) => e.last - e.first).toList());

    final test = changes.last;
    final sequences = <String, int>{};
    for (var i = 0; i < 2000 - 4; i++) {
      sequences.putIfAbsent(
        '${test[i]}${test[i + 1]}${test[i + 2]}${test[i + 3]}',
        () => tmp[i + 4],
      );
    }
    changeSequences.add(sequences);

    result.add(current);
  }
  final allChangeSequences = changeSequences.fold(
    <String>{},
    (previousValue, element) =>
        previousValue..addAll(
          element.entries
              .where((element) => element.value != 0)
              .map((e) => e.key),
        ),
  );
  var maxBananas = 0;
  for (final seq in allChangeSequences) {
    var bananas = 0;
    for (final monkey in changeSequences) {
      bananas += monkey[seq] ?? 0;
    }
    maxBananas = max(maxBananas, bananas);
  }

  return maxBananas;
}
