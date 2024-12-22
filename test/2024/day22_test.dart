import 'package:adventofcode/adventofcode2024.dart';
import 'package:adventofcode/src/utils.dart';
import 'package:test/test.dart';

void main() {
  const input = Input('''
1
10
100
2024''');
  const input2 = Input('''
1
2
3
2024''');

  test('first star', () {
    expect(day22star1(input), equals(37327623));
  });
  test('second star', () {
    expect(day22star2(input2), equals(23));
  });
}
