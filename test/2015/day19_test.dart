import 'package:adventofcode/adventofcode2015.dart';
import 'package:adventofcode/src/utils.dart';
import 'package:test/test.dart';

void main() {
  const input1 = Input('''
e => H
e => O
H => HO
H => OH
O => HH

HOH''');
  const input2 = Input('''
e => H
e => O
H => HO
H => OH
O => HH

HOHOHO''');

  test('first star', () {
    expect(day19star1(input1), equals(4));
    expect(day19star1(input2), equals(7));
  });
  test('second star', () {
    expect(day19star2(input1), equals(3));
    expect(day19star2(input2), equals(6));
  });
}
