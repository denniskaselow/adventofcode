import 'package:adventofcode/adventofcode2023.dart';
import 'package:adventofcode/src/utils.dart';
import 'package:test/test.dart';

void main() {
  const input1 = Input('''
.....
.S-7.
.|.|.
.L-J.
.....''');
  const input2 = Input('''
..F7.
.FJ|.
SJ.L7
|F--J
LJ...''');
  const input3 = Input('''
...........
.S-------7.
.|F-----7|.
.||.....||.
.||.....||.
.|L-7.F-J|.
.|..|.|..|.
.L--J.L--J.
...........''');
  const input4 = Input('''
..........
.S------7.
.|F----7|.
.||OOOO||.
.||OOOO||.
.|L-7F-J|.
.|II||II|.
.L--JL--J.
..........''');
  const input5 = Input('''
.F----7F7F7F7F-7....
.|F--7||||||||FJ....
.||.FJ||||||||L7....
FJL7L7LJLJ||LJ.L-7..
L--J.L7...LJS7F-7L7.
....F-J..F7FJ|L7L7L7
....L7.F7||L7|.L7L7|
.....|FJLJ|FJ|F7|.LJ
....FJL-7.||.||||...
....L---J.LJ.LJLJ...''');
  const input6 = Input('''
FF7FSF7F7F7F7F7F---7
L|LJ||||||||||||F--J
FL-7LJLJ||||||LJL-77
F--JF--7||LJLJ7F7FJ-
L---JF-JLJ.||-FJLJJ7
|F|F-JF---7F7-L7L|7|
|FFJF7L7F-JF7|JL---7
7-L-JL7||F7|L7F-7F7|
L.L7LFJ|||||FJL7||LJ
L7JLJL-JLJLJL--JLJ.L''');

  test('first star', () {
    expect(day10star1(input1), equals(4));
    expect(day10star1(input2), equals(8));
  });
  test('second star', () {
    expect(day10star2(input3), equals(4));
    expect(day10star2(input4), equals(4));
    expect(day10star2(input5), equals(8));
    expect(day10star2(input6), equals(10));
  });
}
