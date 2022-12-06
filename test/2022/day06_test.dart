import 'package:adventofcode2022/adventofcode2022.dart';
import 'package:test/test.dart';

void main() {
  test('day 6 first star', () {
    expect(day6star1('mjqjpqmgbljsphdztnvjfqwrcgsmlb'), equals(7));
    expect(day6star1('bvwbjplbgvbhsrlpgdmjqwftvncz'), equals(5));
    expect(day6star1('nppdvjthqldpwncqszvftbrmjlhg'), equals(6));
    expect(day6star1('nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg'), equals(10));
    expect(day6star1('zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw'), equals(11));
  });
  test('day 6 second star', () {
    expect(day6star2('mjqjpqmgbljsphdztnvjfqwrcgsmlb'), equals(19));
    expect(day6star2('bvwbjplbgvbhsrlpgdmjqwftvncz'), equals(23));
    expect(day6star2('nppdvjthqldpwncqszvftbrmjlhg'), equals(23));
    expect(day6star2('nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg'), equals(29));
    expect(day6star2('zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw'), equals(26));
  });
}
