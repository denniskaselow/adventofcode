import 'package:adventofcode2022/adventofcode2022.dart';
import 'package:test/test.dart';

void main() {
  final input = '''''';

  test('first star', () {
    expect(day5star1(input), equals(2));
  });
  test('second star', () {
    expect(day5star2(input), equals(4));
  });
}
