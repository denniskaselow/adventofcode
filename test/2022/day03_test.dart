import 'package:adventofcode/adventofcode2022.dart';
import 'package:test/test.dart';

void main() {
  const input = '''
vJrwpWtwJgWrhcsFMMfFFhFp
jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
PmmdzqPrVvPwwTWBwg
wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
ttgJtRGJQctTZtZT
CrZsJsPPZsGzwwsLwLmpwMDw''';

  test('first star', () {
    expect(day3star1(input), equals(157));
  });
  test('second star', () {
    expect(day3star2(input), equals(70));
  });
}
