import 'package:adventofcode2022/adventofcode2022.dart';
import 'package:test/test.dart';

void main() {
  final input = r'''R 4
U 4
L 3
D 1
R 4
D 1
L 5
R 2''';

  test('day 9 first star', () {
    expect(day9star1(input), equals(13));
  });
  test('day 9 second star', () {
    expect(day9star2(input), equals(1));
  });
  test('day 9 second star 2', () {
    final input2 = '''R 5
U 8
L 8
D 3
R 17
D 10
L 25
U 20''';
    expect(day9star2(input2), equals(36));
  });
}
