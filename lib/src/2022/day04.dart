import '../utils.dart';

Iterable<String> _processInput(Input input) => input.getLines();

int day4star1(Input input) => _processInput(input)
    .map((e) => e.split(',').map((e) => e.split('-').map(int.parse)))
    .where(
      (element) =>
          element.first.first >= element.last.first &&
              element.first.last <= element.last.last ||
          element.first.first <= element.last.first &&
              element.first.last >= element.last.last,
    )
    .length;

int day4star2(Input input) => _processInput(input)
    .map((e) => e.split(',').map((e) => e.split('-').map(int.parse)))
    .where(
      (element) => !(element.first.first > element.last.last ||
          element.first.last < element.last.first),
    )
    .length;
