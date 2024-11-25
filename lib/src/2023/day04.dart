import 'dart:math';

import 'package:collection/collection.dart';
import 'package:more/more.dart';

import '../utils.dart';

Iterable<Iterable<int>> _getCards(Input input) => input.getLines().map(
      (e) => e
          .split(':')
          .last
          .split('|')
          .map((f) => f.trim().split(RegExp(r'\s+')).map(int.parse))
          .reduce(
            (value, element) => element.toSet().intersection(value.toSet()),
          ),
    );

int day04star1(Input input) => _getCards(input)
    .where((element) => element.isNotEmpty)
    .map((e) => pow(2, e.length - 1))
    .sum
    .toInt();

int day04star2(Input input) {
  final cards = _getCards(input);
  final winningMultiplier = <int, int>{1: 0};
  for (final card in cards.indexed(start: 1)) {
    final current = (winningMultiplier[card.index] ?? 0) + 1;
    for (var i = 0; i < card.value.length; i++) {
      winningMultiplier.update(
        card.index + i + 1,
        (value) => value + current,
        ifAbsent: () => current,
      );
    }
  }

  return winningMultiplier.values.sum + cards.length;
}
