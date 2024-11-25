import 'package:adventofcode/adventofcode2022.dart';
import 'package:adventofcode/src/utils.dart';
import 'package:test/test.dart';

void main() {
  const input = Input('''
    [D]    
[N] [C]    
[Z] [M] [P]
 1   2   3 

move 1 from 2 to 1
move 3 from 1 to 3
move 2 from 2 to 1
move 1 from 1 to 2''');

  test('day 5 first star', () {
    expect(day5star1(input), equals('CMZ'));
  });
  test('day 5 second star', () {
    expect(day5star2(input), equals('MCD'));
  });
}
