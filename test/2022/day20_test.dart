import 'package:adventofcode/adventofcode2022.dart';
import 'package:test/test.dart';

void main() {
  const input = '''
1
2
-3
3
-2
0
4''';

  test('day 20 first star', () {
    expect(day20star1(input), equals(3));
  });
  test('day 20 second star', () {
    expect(day20star2(input), equals(1623178306));
  });
}
