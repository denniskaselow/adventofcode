import 'package:collection/collection.dart';

Iterable<String> _processInput(String input) {
  return input.split('\n');
}

day4star1(String input) {
  return _processInput(input)
      .map((e) => e.split(',').map((e) => e.split('-').map(int.parse)))
      .where((element) =>
          element.first.first >= element.last.first &&
              element.first.last <= element.last.last ||
          element.first.first <= element.last.first &&
              element.first.last >= element.last.last)
      .length;
}

day4star2(String input) {
  return _processInput(input)
      .map((e) => e.split(',').map((e) => e.split('-').map(int.parse)))
      .where((element) =>
          element.first.first <= element.last.first &&
              element.first.last >= element.last.first ||
          element.first.first <= element.last.last &&
              element.first.first >= element.last.first ||
          element.first.first >= element.last.first &&
              element.first.last <= element.last.last ||
          element.first.first <= element.last.first &&
              element.first.last >= element.last.last)
      .length;
}
