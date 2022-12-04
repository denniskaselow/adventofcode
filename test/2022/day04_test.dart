import 'package:adventofcode2022/adventofcode2022.dart';
import 'package:test/test.dart';

void main() {
  final input = '''2-4,6-8
2-3,4-5
5-7,7-9
2-8,3-7
6-6,4-6
2-6,4-8''';

  test('first star', () {
    expect(day4star1(input), equals(2));
  });
  test('second star', () {
    expect(day4star2(input), equals(4));
  });
}
