import 'package:adventofcode/adventofcode2025.dart';
import 'package:adventofcode/src/utils.dart';
import 'package:test/test.dart';

void main() {
  const input = Input('''
3-5
10-14
16-20
12-18

1
5
8
11
17
32
''');

  test('first star', () {
    expect(day05star1(input), equals(3));
  });
  test('second star', () {
    // expect(day05star2(input), equals(14));
    expect(day05star2('2-3\n1-4' as Input), equals(4));
  });
}
