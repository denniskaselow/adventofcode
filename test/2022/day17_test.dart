import 'package:adventofcode/adventofcode2022.dart';
import 'package:test/test.dart';

void main() {
  const input = '''>>><<><>><<<>><>>><<<>>><<<><<<>><>><<>>''';

  test('day 17 first star', () {
    expect(day17star1(input), equals(3068));
  });
  test('day 17 second star', () {
    expect(day17star2(input), equals(1514285714288));
  });
}
