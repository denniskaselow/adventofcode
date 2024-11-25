import 'package:adventofcode/adventofcode2015.dart';
import 'package:adventofcode/src/utils.dart';
import 'package:test/test.dart';

void main() {
  const input = Input('''()())''');

  test('first star', () {
    expect(day1star1(input), equals(-1));
  });
  test('second star', () {
    expect(day1star2(input), equals(5));
  });
}
