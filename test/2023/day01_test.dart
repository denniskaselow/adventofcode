import 'package:adventofcode/adventofcode2023.dart';
import 'package:adventofcode/src/utils.dart';
import 'package:test/test.dart';

void main() {
  const input = Input('''
1abc2
pqr3stu8vwx
a1b2c3d4e5f
treb7uchet''');

  test('first star', () {
    expect(day1star1(input), equals(142));
  });
  test('second star', () {
    expect(
      day1star2(
        const Input('''
two1nine
eightwothree
abcone2threexyz
xtwone3four
4nineeightseven2
zoneight234
7pqrstsixteen'''),
      ),
      equals(281),
    );
  });
}
