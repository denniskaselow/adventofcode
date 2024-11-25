// ignore_for_file: avoid_dynamic_calls

import 'dart:convert';
import 'dart:math';

import 'package:collection/collection.dart';

import '../utils.dart';

int day13star1(Input input) {
  final pairs = _processInput(input);
  final correctIndex = <int>[];
  var index = 1;
  for (final pair in pairs) {
    final left = jsonDecode(pair.first) as List;
    final right = jsonDecode(pair.last) as List;
    if (compare(left, right) < 0) {
      correctIndex.add(index);
    }
    index++;
  }
  return correctIndex.sum;
}

int day13star2(Input input) {
  final pairs = _processInput(input);
  final all = <List<dynamic>>[];
  for (final pair in pairs) {
    final left = jsonDecode(pair.first) as List;
    final right = jsonDecode(pair.last) as List;
    all.addAll([left, right]);
  }
  const marker1 = [
    [2],
  ];
  const marker2 = [
    [6],
  ];
  all.addAll([marker1, marker2]);
  final sorted = all.sorted(compare);
  final result = sorted
      .mapIndexed((index, element) => [index + 1, element])
      .where((element) => element[1] == marker1 || element[1] == marker2);
  return (result.first.first as int) * (result.last.first as int);
}

int compare(List<dynamic> left, List<dynamic> right) {
  var result = 0;
  for (var i = 0; i < max(left.length, right.length); i++) {
    if (i == left.length && i < right.length) {
      result = -1;
    } else if (i <= left.length && i == right.length) {
      result = 1;
    } else if (left[i] is int && right[i] is int) {
      if ((left[i] as int) < (right[i] as int)) {
        result = -1;
      } else if ((left[i] as int) > (right[i] as int)) {
        result = 1;
      }
    } else if (left[i] is int && right[i] is List) {
      result = compare([left[i]], right[i] as List);
    } else if (left[i] is List && right[i] is int) {
      result = compare(left[i] as List, [right[i]]);
    } else {
      result = compare(left[i] as List, right[i] as List);
    }
    if (result != 0) {
      return result;
    }
  }
  return result;
}

List<List<String>> _processInput(Input input) =>
    input.getInputGroups().map((e) => e.getLines().toList()).toList();
