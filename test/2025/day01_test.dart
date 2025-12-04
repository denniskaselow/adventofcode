import 'package:adventofcode/adventofcode2025.dart';
import 'package:adventofcode/src/utils.dart';
import 'package:test/test.dart';

void main() {
  const input = Input('''
L68
L30
R48
L5
R60
L55
L1
L99
R14
L82
''');

  test('first star', () {
    expect(day01star1(input), equals(3));
  });
  test('second star', () {
    expect(day01star2('L50' as Input), equals(1));
    expect(day01star2('L50\nR1' as Input), equals(1));
    expect(day01star2('L50\nL1' as Input), equals(1));
    expect(day01star2('L50\nR100' as Input), equals(2));
    expect(day01star2('L50\nR100\nL1\nR1' as Input), equals(3));
    expect(day01star2('L50\nR100\nL1\nL1' as Input), equals(2));
    expect(day01star2('L50\nL100' as Input), equals(2));
    expect(day01star2('R50' as Input), equals(1));

    expect(day01star2(input), equals(6));
  });
}
