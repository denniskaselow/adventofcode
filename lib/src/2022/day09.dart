import 'dart:math';

import 'package:collection/collection.dart';

import '../utils.dart';

int day9star1(String input) => evaluate(input, 1);
int day9star2(String input) => evaluate(input, 9);

int evaluate(String input, int tailLength) {
  final movements = input.lines.map((e) => e.split(' '));
  var x = 0;
  var y = 0;
  var minX = 0;
  var maxX = 0;
  var minY = 0;
  var maxY = 0;
  for (final movement in movements) {
    final tmp = int.parse(movement[1]);
    if (movement[0] == 'R') {
      x += tmp;
    } else if (movement[0] == 'L') {
      x -= tmp;
    } else if (movement[0] == 'U') {
      y += tmp;
    } else {
      y -= tmp;
    }
    minX = min(x, minX);
    minY = min(y, minY);
    maxX = max(x, maxX);
    maxY = max(y, maxY);
  }
  final grid = List.generate(
    maxX - minX + 1,
    (index) => List.generate(maxY - minY + 1, (index) => false),
  );
  final startX = -minX;
  final startY = -minY;
  grid[startX][startY] = true;
  final rope = Rope(startX, startY, tailLength);
  for (final movement in movements) {
    move(grid, movement, rope);
  }
  return grid.flattened.where((element) => element).length;
}

void move(List<List<bool>> grid, List<String> movement, Rope rope) {
  final tmp = int.parse(movement[1]);
  for (var i = 0; i < tmp; i++) {
    if (movement[0] == 'R') {
      rope.xHead += 1;
    } else if (movement[0] == 'L') {
      rope.xHead -= 1;
    } else if (movement[0] == 'U') {
      rope.yHead += 1;
    } else {
      rope.yHead -= 1;
    }
    var nextXPos = rope.xHead;
    var nextYPos = rope.yHead;
    for (var j = 0; j < rope.xTail.length; j++) {
      if ((nextXPos - rope.xTail[j]).abs() > 1 ||
          (nextYPos - rope.yTail[j]).abs() > 1) {
        final deltaX = nextXPos - rope.xTail[j];
        final deltaY = nextYPos - rope.yTail[j];
        rope.xTail[j] += deltaX.sign;
        rope.yTail[j] += deltaY.sign;
        nextXPos = rope.xTail[j];
        nextYPos = rope.yTail[j];
      } else {
        break;
      }
    }
    grid[rope.xTail.last][rope.yTail.last] = true;
  }
}

class Rope {
  Rope(this.xHead, this.yHead, int tailLength)
      : xTail = List.filled(tailLength, xHead),
        yTail = List.filled(tailLength, yHead);
  int xHead;
  int yHead;
  List<int> xTail;
  List<int> yTail;
}
