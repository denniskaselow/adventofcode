import 'package:adventofcode/adventofcode2025.dart';
import 'package:adventofcode/src/utils.dart';
import 'package:test/test.dart';

void main() {
  const input = Input('''
..@@.@@@@.
@@@.@.@.@@
@@@@@.@.@@
@.@@@@..@.
@@.@@@@.@@
.@@@@@@@.@
.@.@.@.@@@
@.@@@.@@@@
.@@@@@@@@.
@.@.@@@.@.
''');

  test('first star', () {
    expect(day04star1(input), equals(13));
  });
  test('second star', () {
    expect(day04star2(input), equals(43));
  });
}
