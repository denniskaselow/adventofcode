import 'package:adventofcode/adventofcode2021.dart';
import 'package:adventofcode/src/utils.dart';
import 'package:test/test.dart';

void main() {
  const input = Input('''
199
200
208
210
200
207
240
269
260
263''');

  test('first star', () {
    expect(day01star1(input), equals(7));
  });
  test('second star', () {
    expect(day01star2(input), equals(5));
  });
}
