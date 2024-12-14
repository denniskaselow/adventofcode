import 'package:adventofcode/adventofcode2024.dart';
import 'package:adventofcode/src/utils.dart';
import 'package:test/test.dart';

void main() {
  const input = Input('''
p=0,4 v=3,-3
p=6,3 v=-1,-3
p=10,3 v=-1,2
p=2,0 v=2,-1
p=0,0 v=1,3
p=3,0 v=-2,-2
p=7,6 v=-1,-3
p=3,0 v=-1,-2
p=9,3 v=2,3
p=7,3 v=-1,2
p=2,4 v=2,-3
p=9,5 v=-3,-3''');
  const input2 = Input('''
p=4,0 v=-3,3
p=3,6 v=-3,-1
p=3,10 v=2,-1
p=0,2 v=-1,2
p=0,0 v=3,1
p=0,3 v=-2,-2
p=6,7 v=-3,-1
p=0,3 v=-2,-1
p=3,9 v=3,2
p=3,7 v=2,-1
p=4,2 v=-3,2
p=5,9 v=-3,-3''');

  test('first star', () {
    expect(day14star1(input, maxX: 11, maxY: 7), equals(12));
    expect(day14star1(input2, maxX: 7, maxY: 11), equals(12));
  });
}
