import 'package:adventofcode/adventofcode2023.dart';
import 'package:adventofcode/src/utils.dart';
import 'package:test/test.dart';

void main() {
  const input1 = Input('''
broadcaster -> a, b, c
%a -> b
%b -> c
%c -> inv
&inv -> a''');
  const input2 = Input('''
broadcaster -> a
%a -> inv, con
&inv -> b
%b -> con
&con -> output''');

  test('first star', () {
    expect(day20star1(input1), equals(32000000));
    expect(day20star1(input2), equals(11687500));
  });
}
