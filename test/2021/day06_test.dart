import 'package:adventofcode/adventofcode2021.dart';
import 'package:adventofcode/src/utils.dart';
import 'package:test/test.dart';

void main() {
  const input = Input('''
3,4,3,1,2''');

  test('first star', () {
    expect(day06star1(input, days: 18), equals(26));
    expect(day06star1(input), equals(5934));
  });
  test('second star', () {
    expect(day06star2(input), equals(26984457539));
  });
}
