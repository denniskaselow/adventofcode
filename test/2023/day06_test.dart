import 'package:adventofcode/adventofcode2023.dart';
import 'package:test/test.dart';

void main() {
  const input = '''
Time:      7  15   30
Distance:  9  40  200''';

  test('first star', () {
    expect(day06star1(input), equals(288));
  });
  test('second star', () {
    expect(day06star2(input), equals(71503));
  });
}
