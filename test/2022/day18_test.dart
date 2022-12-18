import 'package:adventofcode2022/adventofcode2022.dart';
import 'package:test/test.dart';

void main() {
  const input = '''
  2,2,2
1,2,2
3,2,2
2,1,2
2,3,2
2,2,1
2,2,3
2,2,4
2,2,6
1,2,5
3,2,5
2,1,5
2,3,5''';

  test('day 18 first star', () {
    expect(day18star1(input), equals(64));
  });
  test('day 18 second star', () {
    expect(day18star2(input), equals(58));
  });
}
