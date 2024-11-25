import '../utils.dart';

final digitWords = [
  ('one', '1'),
  ('two', '2'),
  ('three', '3'),
  ('four', '4'),
  ('five', '5'),
  ('six', '6'),
  ('seven', '7'),
  ('eight', '8'),
  ('nine', '9'),
];

int day1star1(Input input) => input
    .getLines()
    .map(
      (e) => e
          .split('')
          .where((element) => '123456789'.contains(element))
          .map(int.parse),
    )
    .map((e) => e.first * 10 + e.last)
    .reduce(sum);

int day1star2(Input input) => input
    .getLines()
    .map((e) {
      var index = 999;
      (String, String)? first;
      (String, String)? last;
      for (final digitWord in digitWords) {
        final idx = e.indexOf(digitWord.$1);
        if (idx != -1 && idx < index) {
          first = digitWord;
          index = idx;
        }
      }
      index = -1;
      for (final digitWord in digitWords) {
        final idx = e.lastIndexOf(digitWord.$1);
        if (idx > index) {
          last = digitWord;
          index = idx;
        }
      }
      if (first != null) {
        e = e.replaceFirst(first.$1, '_${first.$2}_${first.$1}') as Input;
      }
      if (last != null) {
        e = e.replaceFirst(last.$1, '${last.$1}_${last.$2}_', index) as Input;
      }
      return e;
    })
    .map(
      (e) => e
          .split('')
          .where((element) => '0123456789'.contains(element))
          .map(int.parse),
    )
    .map((e) => e.first * 10 + e.last)
    .reduce(sum);
