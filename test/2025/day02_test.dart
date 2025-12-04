import 'package:adventofcode/adventofcode2025.dart';
import 'package:adventofcode/src/utils.dart';
import 'package:test/test.dart';

void main() {
  const input = Input(
    '''
11-22,95-115,998-1012,1188511880-1188511890,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124''',
  );

  test('first star', () {
    expect(day02star1('11-22' as Input), equals(33));
    expect(day02star1('1698522-1698528' as Input), equals(0));
    expect(day02star1('38593856-38593862' as Input), equals(38593859));
    expect(day02star1(input), equals(1227775554));
  });
  test('second star', () {
    expect(day02star2('11-22' as Input), equals(33));
    expect(day02star2('998-1012' as Input), equals(999 + 1010));
    expect(day02star2('1698522-1698528' as Input), equals(0));
    expect(day02star2('38593856-38593862' as Input), equals(38593859));
    expect(day02star2('565653-565659' as Input), equals(565656));
    expect(day02star2(input), equals(4174379265));
  });
}
