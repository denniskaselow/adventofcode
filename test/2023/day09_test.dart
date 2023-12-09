import 'package:adventofcode/adventofcode2023.dart';
import 'package:test/test.dart';

void main() {
  const input = '''
0 3 6 9 12 15
1 3 6 10 15 21
10 13 16 21 30 45''';

  test('first star', () {
    expect(day09star1(input), equals(114));
  });
  test('second star', () {
    expect(day09star2(input), equals(2));
  });
}
