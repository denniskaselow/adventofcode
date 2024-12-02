import 'package:adventofcode/adventofcode2024.dart';
import 'package:adventofcode/src/utils.dart';
import 'package:test/test.dart';

void main() {
  const input = Input('''
7 6 4 2 1
1 2 7 8 9
9 7 6 2 1
1 3 2 4 5
8 6 4 4 1
1 3 6 7 9''');

  test('first star', () {
    expect(day02star1(input), equals(2));
  });
  test('second star', () {
    expect(day02star2(input), equals(4));
  });
}
