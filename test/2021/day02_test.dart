import 'package:adventofcode/adventofcode2021.dart';
import 'package:adventofcode/src/utils.dart';
import 'package:test/test.dart';

void main() {
  const input = Input('''
forward 5
down 5
forward 8
up 3
down 8
forward 2''');

  test('first star', () {
    expect(day02star1(input), equals(150));
  });
  test('second star', () {
    expect(day02star2(input), equals(900));
  });
}
