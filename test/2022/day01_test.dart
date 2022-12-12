import 'package:adventofcode2022/adventofcode2022.dart';
import 'package:test/test.dart';

void main() {
  const input = '''
1000
2000
3000

4000

5000
6000

7000
8000
9000

10000''';

  test('first star', () {
    expect(day1star1(input), equals(24000));
  });
  test('second star', () {
    expect(day1star2(input), equals(45000));
  });
}
