import 'package:collection/collection.dart';

Iterable<String> _processInput(String input) => input.split('\n');

int day2star1(String input) => _processInput(input)
    .map((e) => e.split(' ').map(Rps.forItem1))
    .map((e) => e.last.getScore(e.first))
    .sum;

int day2star2(String input) => _processInput(input)
    .map(Rps.forItem2)
    .map((e) => e.last.getScore(e.first))
    .sum;

enum Rps {
  rock(1),
  paper(2),
  scissors(3);

  final int value;
  const Rps(this.value);

  static Rps forItem1(String item) {
    if (item == 'A' || item == 'X') {
      return Rps.rock;
    } else if (item == 'B' || item == 'Y') {
      return Rps.paper;
    }
    return Rps.scissors;
  }

  static List<Rps> forItem2(String item) {
    final items = item.split(' ');
    final result = [Rps.rock, Rps.rock];
    result[0] = Rps.forItem1(items[0]);
    if (items[1] == 'X') {
      result[1] = Rps.values[(result[0].index - 1) % 3];
    } else if (items[1] == 'Z') {
      result[1] = Rps.values[(result[0].index + 1) % 3];
    } else {
      result[1] = result[0];
    }
    return result;
  }

  int getScore(Rps opponent) {
    if (this == opponent) {
      return 3 + value;
    } else if ((index + 1) % 3 == opponent.index) {
      return 0 + value;
    }
    return 6 + value;
  }
}
