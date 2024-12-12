import 'package:adventofcode/adventofcode2024.dart';
import 'package:adventofcode/src/utils.dart';
import 'package:test/test.dart';

void main() {
  const input1 = Input('''
AAAA
BBCD
BBCC
EEEC''');
  const input2 = Input('''
OOOOO
OXOXO
OOOOO
OXOXO
OOOOO''');
  const input3 = Input('''
RRRRIICCFF
RRRRIICCCF
VVRRRCCFFF
VVRCCCJFFF
VVVVCJJCFE
VVIVCCJJEE
VVIIICJJEE
MIIIIIJJEE
MIIISIJEEE
MMMISSJEEE''');
  const input4 = Input('''
EEEEE
EXXXX
EEEEE
EXXXX
EEEEE''');
  const input5 = Input('''
AAAAAA
AAABBA
AAABBA
ABBAAA
ABBAAA
AAAAAA''');

  test('first star', () {
    expect(day12star1(input1), equals(140));
    expect(day12star1(input2), equals(772));
    expect(day12star1(input3), equals(1930));
  });
  test('second star', () {
    expect(day12star2(input1), equals(80));
    expect(day12star2(input2), equals(436));
    expect(day12star2(input3), equals(1206));
    expect(day12star2(input4), equals(236));
    expect(day12star2(input5), equals(368));
  });
}
