import 'package:adventofcode2022/adventofcode2022.dart';
import 'package:test/test.dart';

void main() {
  final input = r'''''';

  test('day 11 first star', () {
    expect(day11star1(input), equals(0));
  });
  test('day 11 second star', () {
    expect(day11star2(input), equals(0));
  });
}
