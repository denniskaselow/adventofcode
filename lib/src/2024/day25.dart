import 'package:collection/collection.dart';

import '../utils.dart';

typedef Pos = ({int x, int y});
typedef Grid = Map<Pos, String>;

List<Grid> _processInput(Input input) =>
    input
        .getInputGroups()
        .map(
          (e) => e.getLines().foldIndexed(<({int x, int y}), String>{}, (
            y,
            grid,
            line,
          ) {
            line.split('').forEachIndexed((x, cell) {
              grid[(x: x, y: y)] = cell;
            });
            return grid;
          }),
        )
        .toList();

int day25star1(Input input) {
  const maxX = 5;
  const maxY = 6;
  final locks = <List<int>>[];
  final keys = <List<int>>[];

  final lockasAndKeys = _processInput(input);

  for (final lockOrKey in lockasAndKeys) {
    var isLock = false;
    if (lockOrKey[(x: 0, y: 0)] == '#') {
      isLock = true;
    }
    final keyLockInfo = List.filled(maxX, 0);
    for (var x = 0; x < maxX; x++) {
      for (var y = 0; y < maxY; y++) {
        if (isLock && lockOrKey[(x: x, y: y)] == '#' ||
            !isLock && lockOrKey[(x: x, y: y)] == '.') {
          keyLockInfo[x] = y;
        }
      }
    }
    if (isLock) {
      locks.add(keyLockInfo.toList());
    } else {
      keys.add(keyLockInfo.toList());
    }
  }

  var result = 0;
  for (final lock in locks) {
    for (final key in keys) {
      var keyFits = true;
      for (var x = 0; x < maxX; x++) {
        if (lock[x] > key[x]) {
          keyFits = false;
        }
      }
      if (keyFits) {
        result++;
      }
    }
  }

  return result;
}

int day25star2(Input input) => 0;
