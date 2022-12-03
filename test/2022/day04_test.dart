import 'package:adventofcode2022/adventofcode2022.dart';
import 'package:test/test.dart';

void main() {
  final input = '''''';

  test('first star', () {
    expect(day4star1(input), equals(157));
  });
  test('second star', () {
    expect(day4star2(input), equals(70));
  });
}
