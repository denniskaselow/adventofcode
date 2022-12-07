import 'package:adventofcode2022/adventofcode2022.dart';
import 'package:test/test.dart';

void main() {
  final input = r'''$ cd /
$ ls
dir a
14848514 b.txt
8504156 c.dat
dir d
$ cd a
$ ls
dir e
29116 f
2557 g
62596 h.lst
$ cd e
$ ls
584 i
$ cd ..
$ cd ..
$ cd d
$ ls
4060174 j
8033020 d.log
5626152 d.ext
7214296 k''';

  test('day 7 first star', () {
    expect(day7star1(input), equals(95437));
  });
  test('day 7 second star', () {
    expect(day7star2(input), equals(24933642));
  });
}
