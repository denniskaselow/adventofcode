import 'package:more/more.dart';

import '../utils.dart';

typedef Policy = ({int from, int to, String letter, String password});

Iterable<Policy> _processInput(Input input) => input.getLines().map((line) {
  final [from, to, letter, password] = RegExp(
    r'(\d+)-(\d+) (\w): (.*)',
  ).firstMatch(line)!.groups([1, 2, 3, 4]);
  return (
    from: int.parse(from!),
    to: int.parse(to!),
    letter: letter!,
    password: password!,
  );
});

int day02star1(Input input) => _processInput(input).count((policy) {
  final count = policy.password
      .split('')
      .count((char) => char == policy.letter);
  return count >= policy.from && count <= policy.to;
});

int day02star2(Input input) => _processInput(input).count(
  (policy) =>
      (policy.password[policy.from - 1] == policy.letter) ^
      (policy.password[policy.to - 1] == policy.letter),
);
