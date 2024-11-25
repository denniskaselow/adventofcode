import 'package:adventofcode/adventofcode2023.dart';
import 'package:adventofcode/src/utils.dart';
import 'package:test/test.dart';

void main() {
  const input = Input('''
???.### 1,1,3
.??..??...?##. 1,1,3
?#?#?#?#?#?#?#? 1,3,1,6
????.#...#... 4,1,1
????.######..#####. 1,6,5
?###???????? 3,2,1''');

  test('first star', () {
    expect(day12star1('???.### 1,1,3' as Input), equals(1));
    expect(day12star1('.??..??...?##. 1,1,3' as Input), equals(4));
    expect(day12star1('?###???????? 3,2,1' as Input), equals(10));
    expect(day12star1(input), equals(21));
  });
  test('second star', () {
    expect(day12star2('???.### 1,1,3' as Input), equals(1));
    expect(day12star2('.??.??...?##. 1,1,3' as Input), equals(16384));
    expect(day12star2(input), equals(525152));
  });
}
