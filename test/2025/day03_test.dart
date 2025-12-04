import 'package:adventofcode/adventofcode2025.dart';
import 'package:adventofcode/src/utils.dart';
import 'package:test/test.dart';

void main() {
  const input = Input('''
987654321111111
811111111111119
234234234234278
818181911112111
''');

  test('first star', () {
    expect(day03star1(input), equals(357));
  });
  test('second star', () {
    expect(day03star2(input), equals(3121910778619));
  });
}
