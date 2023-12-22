import 'package:adventofcode/adventofcode2023.dart';
import 'package:test/test.dart';

void main() {
  const input = '''
1,0,1~1,2,1
0,0,2~2,0,2
0,2,3~2,2,3
0,0,4~0,2,4
2,0,5~2,2,5
0,1,6~2,1,6
1,1,8~1,1,9''';

  test('first star', () {
    expect(day22star1(input), equals(5));
  });
  test('second star', () {
    expect(day22star2(input), equals(7));
  });
}
