import 'package:adventofcode/adventofcode2024.dart';
import 'package:adventofcode/src/utils.dart';
import 'package:test/test.dart';

void main() {
  const input = Input('''
89010123
78121874
87430965
96549874
45678903
32019012
01329801
10456732''');

  test('first star', () {
    expect(day10star1(input), equals(36));
  });
  test('second star', () {
    expect(day10star2(input), equals(81));
  });
}
