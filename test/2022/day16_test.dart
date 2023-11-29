import 'package:adventofcode/adventofcode2022.dart';
import 'package:test/test.dart';

void main() {
  const input = '''
Valve AA has flow rate=0; tunnels lead to valves DD, II, BB
Valve BB has flow rate=13; tunnels lead to valves CC, AA
Valve CC has flow rate=2; tunnels lead to valves DD, BB
Valve DD has flow rate=20; tunnels lead to valves CC, AA, EE
Valve EE has flow rate=3; tunnels lead to valves FF, DD
Valve FF has flow rate=0; tunnels lead to valves EE, GG
Valve GG has flow rate=0; tunnels lead to valves FF, HH
Valve HH has flow rate=22; tunnel leads to valve GG
Valve II has flow rate=0; tunnels lead to valves AA, JJ
Valve JJ has flow rate=21; tunnel leads to valve II''';

  test('day 16 first star', () {
    expect(day16star1(input), equals(1651));
  });
  test('day 16 second star', () {
    expect(day16star2(input), equals(1707));
  });
}
