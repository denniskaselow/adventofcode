import 'package:adventofcode/adventofcode2024.dart';
import 'package:adventofcode/src/utils.dart';
import 'package:test/test.dart';

void main() {
  const input = Input('''
Register A: 10
Register B: 0
Register C: 0

Program: 5,0,5,1,5,4''');
  const input2 = Input('''
Register A: 729
Register B: 0
Register C: 0

Program: 0,1,5,4,3,0''');
  const input3 = Input('''
Register A: 117440
Register B: 0
Register C: 0

Program: 0,3,5,4,3,0''');

  test('first star', () {
    expect(day17star1(input), equals('0,1,2'));
    expect(day17star1(input2), equals('4,6,3,5,6,3,5,2,1,0'));
    expect(day17star1(input3), equals('0,3,5,4,3,0'));
  });
  test('second star', () {
    expect(day17star2(input3), equals(117440));
  });
}
