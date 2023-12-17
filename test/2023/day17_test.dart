import 'package:adventofcode/adventofcode2023.dart';
import 'package:test/test.dart';

void main() {
  const input = '''
2413432311323
3215453535623
3255245654254
3446585845452
4546657867536
1438598798454
4457876987766
3637877979653
4654967986887
4564679986453
1224686865563
2546548887735
4322674655533''';

  test('first star', () {
    expect(day17star1(input), equals(102));
  });
  test('second star', () {
    expect(day17star2(input), equals(0));
  });
}
