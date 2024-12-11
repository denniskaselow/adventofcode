import 'package:adventofcode/adventofcode2024.dart';
import 'package:adventofcode/src/utils.dart';
import 'package:test/test.dart';

void main() {
  const input = Input('''
125 17''');

  test('first star', () {
    expect(day11star1(input), equals(55312));
  });
}
