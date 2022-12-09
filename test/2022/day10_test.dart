import 'package:adventofcode2022/adventofcode2022.dart';
import 'package:test/test.dart';

void main() {
  final input = r'''''';

  test('day 10 first star', () {
    expect(day8star1(input), equals(0));
  });
  test('day 10 second star', () {
    expect(day8star2(input), equals(0));
  });
}
