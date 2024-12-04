import 'package:adventofcode/adventofcode2024.dart';
import 'package:adventofcode/src/utils.dart';
import 'package:test/test.dart';

void main() {
  const input = Input('''
MMMSXXMASM
MSAMXMSMSA
AMXSXMAAMM
MSAMASMSMX
XMASAMXAMM
XXAMMXXAMA
SMSMSASXSS
SAXAMASAAA
MAMMMXMMMM
MXMXAXMASX''');
  const input2 = Input('''
M.M
.A.
S.S
M.S
.A.
M.S
S.S
.A.
M.M
S.M
.A.
S.M''');

  test('first star', () {
    expect(day04star1(input), equals(18));
  });
  test('second star', () {
    expect(day04star2(input2), equals(4));
    expect(day04star2(input), equals(9));
  });
}
