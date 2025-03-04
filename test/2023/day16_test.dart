import 'package:adventofcode/adventofcode2023.dart';
import 'package:adventofcode/src/utils.dart';
import 'package:test/test.dart';

void main() {
  const input = Input(r'''
.|...\....
|.-.\.....
.....|-...
........|.
..........
.........\
..../.\\..
.-.-/..|..
.|....-|.\
..//.|....''');

  test('first star', () {
    expect(day16star1(input), equals(46));
  });
  test('second star', () {
    expect(day16star2(input), equals(51));
  });
}
