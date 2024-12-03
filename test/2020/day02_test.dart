import 'package:adventofcode/adventofcode2020.dart';
import 'package:adventofcode/src/utils.dart';
import 'package:test/test.dart';

void main() {
  const input = Input('''
1-3 a: abcde
1-3 b: cdefg
2-9 c: ccccccccc''');

  test('first star', () {
    expect(day02star1(input), equals(2));
  });
  test('second star', () {
    expect(day02star2(input), equals(1));
  });
}
