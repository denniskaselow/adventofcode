import 'package:adventofcode/adventofcode2023.dart';
import 'package:test/test.dart';

void main() {
  const input = '''
32T3K 765
T55J5 684
KK677 28
KTJJT 220
QQQJA 483''';

  test('first star', () {
    expect(day07star1('''
2AAAA 10
23456 1000
33332 100'''), equals(1000 * 1 + 100 * 3 + 10 * 2));

    expect(day07star1('''
77888 10
77788 100'''), equals(100 * 1 + 10 * 2));

    expect(day07star1(input),
        equals(765 * 1 + 220 * 2 + 28 * 3 + 684 * 4 + 483 * 5));
  });
  test('second star', () {
    expect(day07star2('''
QJJQ2 10
JKKK2 100'''), equals(100 * 1 + 10 * 2));

    expect(day07star2(input), equals(5905));
  });
}
