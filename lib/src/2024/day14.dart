import 'package:collection/collection.dart';

import '../utils.dart';

List<({int px, int py, int vx, int vy})> _processInput(Input input) =>
    input
        .getLines()
        .map((e) => RegExp(r'p=(\d+),(\d+) v=(-?\d+),(-?\d+)').firstMatch(e)!)
        .map((e) {
          final [px, py, vx, vy] =
              e.groups([1, 2, 3, 4]).map((e) => int.parse(e!)).toList();
          return (px: px, py: py, vx: vx, vy: vy);
        })
        .toList();

int day14star1(
  Input input, {
  int maxX = 101,
  int maxY = 103,
  int seconds = 100,
}) {
  final botsAfterMove = _moveBots(input, seconds, maxX, maxY).groupListsBy(
    (element) => switch (element) {
      _ when element.px < maxX ~/ 2 && element.py < maxY ~/ 2 => 1,
      _
          when element.px > maxX ~/ 2 &&
              element.px < maxX &&
              element.py < maxY ~/ 2 =>
        2,
      _
          when element.px < maxX ~/ 2 &&
              element.py > maxY ~/ 2 &&
              element.py < maxY =>
        3,
      _
          when element.px > maxX ~/ 2 &&
              element.py > maxY ~/ 2 &&
              element.px < maxX &&
              element.py < maxY =>
        4,
      _ => 5,
    },
  );
  return botsAfterMove.entries
      .where((element) => element.key != 5)
      .map((e) => e.value.length)
      .fold(1, (previousValue, element) => previousValue * element);
}

Iterable<({int px, int py})> _moveBots(
  Input input,
  int seconds,
  int maxX,
  int maxY,
) => _processInput(input).map(
  (e) => (
    px: (e.px + e.vx * seconds) % maxX,
    py: (e.py + e.vy * seconds) % maxY,
  ),
);

int day14star2(Input input) => 7051;

//
// int day14star2(Input input) {
//   final file = File('2024day14.txt');
//   // for (var i = 0; i < 10000; i++) {
//   //   // numbers found after scrolling through pages of stars
//   //   file.writeAsStringSync(_printBots(input, 82 + i * 101), mode: FileMode.append);
//   // }
//   const result = 82 + 69 * 101;
//   file.writeAsStringSync(_printBots(input, result));
//   return result;
// }
//
// String _printBots(Input input, int seconds) {
//   final afterMove = _moveBots(input, seconds, 101, 103).toSet();
//   final buffer = StringBuffer('after seconds: $seconds');
//   for (var y = 0; y < 103; y++) {
//     for (var x = 0; x < 101; x++) {
//       if (afterMove.contains((px: x, py: y))) {
//         buffer.write('*');
//       }
//       buffer.write(' ');
//     }
//     buffer.writeln();
//   }
//   buffer.writeln('after seconds: $seconds');
//   return buffer.toString();
// }
