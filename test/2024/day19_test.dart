import 'package:adventofcode/adventofcode2024.dart';
import 'package:adventofcode/src/utils.dart';
import 'package:test/test.dart';

void main() {
  const input = Input('''
r, wr, b, g, bwu, rb, gb, br

brwrr
bggr
gbbr
rrbgbr
ubwu
bwurrg
brgr
bbrgwb''');

  test('first star', () {
    expect(day19star1(input), equals(6));
  });
  test('second star', () {
    expect(day19star2(input), equals(16));
  });
}
