import 'package:adventofcode/adventofcode2024.dart';
import 'package:adventofcode/src/utils.dart';
import 'package:test/test.dart';

void main() {
  const input1 = Input('''
029A''');
  const input2 = Input('''
029A
980A
179A
456A
379A''');

  test('first star', () {
    expect(day21star1(input1), equals(68 * 29));
    expect(day21star1(input2), equals(126384));
  });
  test('second star', () {
    expect(day21star2(input1, levelsOfIndirection: 2), equals(68 * 29));
  });
}
