import 'package:adventofcode/adventofcode2025.dart';
import 'package:adventofcode/src/utils.dart';
import 'package:test/test.dart';

void main() {
  const input = Input('''
123 328  51 64 
 45 64  387 23 
  6 98  215 314
*   +   *   +  
''');

  test('first star', () {
    expect(day06star1(input), equals(4277556));
  });
  test('second star', () {
    expect(day06star2(input), equals(3263827));
  });
}
