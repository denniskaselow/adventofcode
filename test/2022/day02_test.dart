import 'package:adventofcode2022/adventofcode2022.dart';
import 'package:test/test.dart';

void main() {
  final input = '''
''';

  test('first star', () {
    expect(day2star1(input), equals(24000));
  });
  test('second star', () {
    expect(day2star2(input), equals(45000));
  });
}
