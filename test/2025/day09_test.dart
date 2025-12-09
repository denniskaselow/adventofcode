import 'package:adventofcode/adventofcode2025.dart';
import 'package:adventofcode/src/utils.dart';
import 'package:test/test.dart';

void main() {
  const input = Input('''
7,1
11,1
11,7
9,7
9,5
2,5
2,3
7,3
''');

  test('first star', () {
    expect(day09star1(input), equals(50));
  });
  test('second star', () {
    expect(day09star2(input), equals(24));
  });
}
