import 'package:adventofcode2022/adventofcode2022.dart';
import 'package:test/test.dart';

void main() {
  const input = '''''';

  test('day 15 first star', () {
    expect(day15star1(input), equals(0));
  });
  test('day 15 second star', () {
    expect(day15star2(input), equals(0));
  });
}
