Iterable<String> _processInput(String input) => input.split('\n');

int day4star1(String input) => _processInput(input)
    .map((e) => e.split(',').map((e) => e.split('-').map(int.parse)))
    .where((element) =>
        element.first.first >= element.last.first &&
            element.first.last <= element.last.last ||
        element.first.first <= element.last.first &&
            element.first.last >= element.last.last)
    .length;

int day4star2(String input) => _processInput(input)
    .map((e) => e.split(',').map((e) => e.split('-').map(int.parse)))
    .where((element) => !(element.first.first > element.last.last ||
        element.first.last < element.last.first))
    .length;
