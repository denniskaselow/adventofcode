import 'package:collection/collection.dart';
import 'package:more/collection.dart';

import '../utils.dart';

const cardsMapping = '23456789TJQKA';
const cardsMappingPart2 = 'J23456789TQKA';

Iterable<String> _processInput(String input) => input.getLines();

int day07star1(String input) {
  final lines = _processInput(input).map((e) => e.split(' '));
  final hands = getHands(lines, cardsMapping).map(
    (line) {
      final counts = countFaces(line);
      final sortedCounts = sortByFacecount(counts);
      final comparableHand = getComparablePart1(sortedCounts, line);
      return (cards: line.$1, comparable: comparableHand, bid: line.$2);
    },
  ).sorted((a, b) => a.comparable.compareTo(b.comparable));

  var result = 0;
  var counter = 1;
  for (final hand in hands) {
    result += hand.bid * counter;
    counter++;
  }

  return result;
}

int day07star2(String input) {
  final lines = _processInput(input).map((e) => e.split(' '));

  final hands = getHands(lines, cardsMappingPart2).map(
    (line) {
      final counts = countFaces(line);
      var jokers = counts.remove(0) ?? 0;
      if (jokers == 5) {
        counts[0] = 5;
        jokers = 0;
      }
      final sortedCounts = sortByFacecount(counts);
      final comparableHand = getSortablePart2(sortedCounts, jokers, line);
      return (cards: line.$1, comparable: comparableHand, bid: line.$2);
    },
  ).sorted((a, b) => a.comparable.compareTo(b.comparable));

  var result = 0;
  var counter = 1;
  for (final hand in hands) {
    result += hand.bid * counter;
    counter++;
  }

  return result;
}

Iterable<(List<int>, int)> getHands(
  Iterable<List<String>> lines,
  String mappingToUse,
) =>
    lines.map(
      (e) => (
        e.first.split('').map((e) => mappingToUse.indexOf(e[0])).toList(),
        int.parse(e.last),
      ),
    );

Map<int, int> countFaces((List<int>, int) line) => line.$1.fold(
      <int, int>{},
      (previousValue, element) => previousValue
        ..update(element, (value) => value + 1, ifAbsent: () => 1),
    );

List<({List<int> cards, int count})> sortByFacecount(Map<int, int> counts) =>
    counts.entries
        .fold(
          <int, List<int>>{},
          (previousValue, element) => previousValue
            ..update(
              element.value,
              (value) => value..add(element.key),
              ifAbsent: () => [element.key],
            ),
        )
        .entries
        .map((e) => (count: e.key, cards: e.value))
        .toList()
      ..sort((a, b) {
        var result = b.count.compareTo(a.count);
        if (result == 0) {
          for (final MapEntry<int, int>(:index, value: card)
              in b.cards.indexed()) {
            result = card.compareTo(a.cards[index]);
            if (result != 0) {
              return result;
            }
          }
        }
        return result;
      });

String getComparablePart1(
  List<({List<int> cards, int count})> sortedCounts,
  (List<int>, int) line,
) =>
    '''${sortedCounts.map((e) => '${e.count}' * e.cards.length).join().padRight(5, '0')}_${line.$1.map((e) => e.toString().padLeft(2, '0')).join()}''';

String getSortablePart2(
  List<({List<int> cards, int count})> sortedCounts,
  int jokers,
  (List<int>, int) line,
) =>
    '''${sortedCounts.indexed().map((e) => e.value.cards.indexed().map((f) => e.value.count + (e.index == 0 && f.index == 0 ? jokers : 0)).join()).join().padRight(5, '0')}_${line.$1.map((e) => e.toString().padLeft(2, '0')).join()}''';
