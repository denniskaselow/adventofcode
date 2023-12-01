import 'package:adventofcode/adventofcode2015.dart';
import 'package:test/test.dart';

void main() {
  const input = '''
abcdef''';

  test('first star', () {
    expect(day04star1(input), equals(609043));
  });
  test('second star', () {
    expect(day04star2(input), equals(6742839));
  });
}
