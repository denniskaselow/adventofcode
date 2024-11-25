import 'package:adventofcode/adventofcode2022.dart';
import 'package:adventofcode/src/utils.dart';
import 'package:test/test.dart';

void main() {
  test('day 6 first star', () {
    expect(day6star1('mjqjpqmgbljsphdztnvjfqwrcgsmlb' as Input), equals(7));
    expect(day6star1('bvwbjplbgvbhsrlpgdmjqwftvncz' as Input), equals(5));
    expect(day6star1('nppdvjthqldpwncqszvftbrmjlhg' as Input), equals(6));
    expect(day6star1('nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg' as Input), equals(10));
    expect(day6star1('zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw' as Input), equals(11));
  });
  test('day 6 second star', () {
    expect(day6star2('mjqjpqmgbljsphdztnvjfqwrcgsmlb' as Input), equals(19));
    expect(day6star2('bvwbjplbgvbhsrlpgdmjqwftvncz' as Input), equals(23));
    expect(day6star2('nppdvjthqldpwncqszvftbrmjlhg' as Input), equals(23));
    expect(day6star2('nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg' as Input), equals(29));
    expect(day6star2('zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw' as Input), equals(26));
  });
}
