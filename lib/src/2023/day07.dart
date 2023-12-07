import 'package:more/more.dart';

import '../utils.dart';

Iterable<String> _processInput(String input) => input.getLines();

int day07star1(String input) => getWinnings(input, '23456789TJQKA');

int day07star2(String input) =>
    getWinnings(input, 'J23456789TQKA', hasJoker: true);

int getWinnings(String input, String mapping, {bool hasJoker = false}) =>
    _processInput(input)
        .map((e) {
          final [hand, bid] = e.split(' ');
          final cards = hand.split('').map((e) => mapping.indexOf(e));
          final countPerCard = cards.fold(
            <int, int>{},
            (previousValue, element) => previousValue
              ..update(element, (value) => value + 1, ifAbsent: () => 1),
          );
          if (hasJoker) {
            updateWithJoker(countPerCard);
          }
          final type = countPerCard.values.toSortedList(
            comparator: (a, b) => b.compareTo(a),
          );
          return (
            sortableHand:
                '''${type.join().padRight(5, '0')}_${cards.map((e) => e.toString().padLeft(2, '0')).join()}''',
            bid: int.parse(bid),
          );
        })
        .toSortedList(
          comparator: (a, b) => a.sortableHand.compareTo(b.sortableHand),
        )
        .indexed(offset: 1)
        .fold(
          0,
          (previousValue, element) =>
              previousValue + element.index * element.value.bid,
        );

void updateWithJoker(Map<int, int> countPerCard) {
  var jokerCount = 0;
  if (countPerCard[0] case final tmp?) {
    if (tmp < 5) {
      jokerCount = tmp;
      countPerCard.remove(0);
    }
  }
  final bestCard = countPerCard.entries.fold(
    (strength: -1, count: 0),
    (previousValue, element) => element.value > previousValue.count ||
            (element.value == previousValue.count &&
                element.key > previousValue.strength)
        ? (strength: element.key, count: element.value)
        : previousValue,
  );
  countPerCard[bestCard.strength] = bestCard.count + jokerCount;
}
