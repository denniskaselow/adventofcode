import 'package:adventofcode/adventofcode2024.dart';
import 'package:adventofcode/src/utils.dart';
import 'package:test/test.dart';

void main() {
  const input = Input('''
5,4
4,2
4,5
3,0
2,1
6,3
2,4
1,5
0,6
3,3
2,6
5,1
1,2
5,5
2,5
6,5
1,4
0,4
6,4
1,1
6,1
1,0
0,5
1,6
2,0''');

  test('first star', () {
    expect(day18star1(input, size: 6, amount: 12), equals(22));
  });
  test('second star', () {
    expect(day18star2(input, size: 6), equals('6,1'));
  });
}
