import 'package:adventofcode2022/adventofcode2022.dart';
import 'package:test/test.dart';

void main() {
  const input = '''
1=-0-2
12111
2=0=
21
2=01
111
20012
112
1=-1=
1-12
12
1=
122''';

  test('day 25 first star', () {
    expect(day25star1(input), equals('2=-1=0'));
  });
  test('day 25 second star', () {
    expect(day25star2(input), equals(301));
  });
}
