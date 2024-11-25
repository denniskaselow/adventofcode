import 'package:adventofcode/adventofcode2022.dart';
import 'package:adventofcode/src/utils.dart';
import 'package:test/test.dart';

void main() {
  const input = Input('''
A Y
B X
C Z''');

  test('first star', () {
    expect(day2star1(input), equals(15));
  });
  test('second star', () {
    expect(day2star2(input), equals(12));
  });
}
