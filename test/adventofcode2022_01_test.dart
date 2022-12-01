import 'package:adventofcode2022/adventofcode2022_01.dart';
import 'package:test/test.dart';

void main() {
  test('first star', () {
    final input = '''1000
2000
3000

4000

5000
6000

7000
8000
9000

10000''';
    expect(calculate(input), equals(24000));
  });
  test('second star', () {
    final input = '''1000
2000
3000

4000

5000
6000

7000
8000
9000

10000''';
    expect(calculate2(input), equals(45000));
  });
}
