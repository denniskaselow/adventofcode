import 'package:adventofcode/adventofcode2023.dart';
import 'package:test/test.dart';

void main() {
  const input = '''
rn=1,cm-,qp=3,cm=2,qp-,pc=4,ot=9,ab=5,pc-,pc=6,ot=7''';

  test('first star', () {
    expect(day15star1(input), equals(1320));
  });
  test('second star', () {
    expect(day15star2(input), equals(145));
  });
}
