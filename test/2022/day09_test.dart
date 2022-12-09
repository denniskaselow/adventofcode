import 'package:adventofcode2022/adventofcode2022.dart';
import 'package:test/test.dart';

void main() {
  final input = r'''''';

  test('day 9 first star', () {
    expect(day9star1(input), equals(0));
  });
  test('day 9 second star', () {
    expect(day9star2(input), equals(0));
  });
}
