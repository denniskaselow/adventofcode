import 'dart:io';

void main(List<String> args) {
  final (day, year) = switch (args) {
    [final day, final year] => (int.parse(day), int.parse(year)),
    final _ => (DateTime.now().day, DateTime.now().year),
  };
  final paddedDay = day.toString().padLeft(2, '0');

  File('lib/src/$year/day$paddedDay.dart').writeAsStringSync('''
import '../utils.dart';

Iterable<String> _processInput(String input) => input.lines;

int day${paddedDay}star1(String input) => _processInput(input).length;

int day${paddedDay}star2(String input) => _processInput(input).length;
''');

  File('test/$year/day${paddedDay}_test.dart').writeAsStringSync('''
import 'package:adventofcode/adventofcode$year.dart';
import 'package:test/test.dart';

void main() {
  const input = \'\'\'
\'\'\';

  test('first star', () {
    expect(day${paddedDay}star1(input), equals(0));
  });
  test('second star', () {
    expect(day${paddedDay}star2(input), equals(0));
  });
}
''');

  File('lib/adventofcode$year.dart').writeAsStringSync(
    '''
export 'src/$year/day$paddedDay.dart';
''',
    mode: FileMode.append,
  );
}
