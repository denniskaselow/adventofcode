import 'package:adventofcode/adventofcode2022.dart';
import 'package:adventofcode/src/utils.dart';
import 'package:test/test.dart';

void main() {
  const input = Input('''
[1,1,3,1,1]
[1,1,5,1,1]

[[1],[2,3,4]]
[[1],4]

[9]
[[8,7,6]]

[[4,4],4,4]
[[4,4],4,4,4]

[7,7,7,7]
[7,7,7]

[]
[3]

[[[]]]
[[]]

[1,[2,[3,[4,[5,6,7]]]],8,9]
[1,[2,[3,[4,[5,6,0]]]],8,9]''');

  test('day 13 first star', () {
    expect(day13star1(input), equals(13));
  });
  test('day 13 second star', () {
    expect(day13star2(input), equals(140));
  });
}
