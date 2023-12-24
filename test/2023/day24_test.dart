import 'package:adventofcode/adventofcode2023.dart';
import 'package:test/test.dart';

void main() {
  const input = '''
19, 13, 30 @ -2,  1, -2
18, 19, 22 @ -1, -1, -2
20, 25, 34 @ -2, -2, -4
12, 31, 28 @ -1, -2, -1
20, 19, 15 @  1, -5, -3''';

  test('first star', () {
    expect(day24star1(input, 7, 27), equals(2));
  });
  test('second star', () {
    expect(day24star2(input), equals(47));
  });
}
