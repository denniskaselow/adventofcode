import 'package:adventofcode/adventofcode2024.dart';
import 'package:adventofcode/src/utils.dart';
import 'package:test/test.dart';

void main() {
  const input = Input('''
2333133121414131402''');
  const input2 = Input('''
1910101010101010101''');

  test('first star', () {
    expect(day09star1(input), equals(1928));
  });
  test('second star', () {
    expect(
      day09star2(input2),
      equals(
        0 * 0 +
            9 * 1 +
            8 * 2 +
            7 * 3 +
            6 * 4 +
            5 * 5 +
            4 * 6 +
            3 * 7 +
            2 * 8 +
            1 * 9,
      ),
    );
    expect(day09star2(input), equals(2858));
  });
}
