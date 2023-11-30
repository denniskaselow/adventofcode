import 'dart:io';

void main() {
  final date = DateTime.now();
  final year = date.year;
  final paddedDay = date.day.toString().padLeft(2, '0');

  File('lib/src/$year/day$paddedDay.dart').writeAsStringSync('''
import '../utils.dart';

Iterable<String> _processInput(String input) => input.lines;

int day${paddedDay}star1(String input) => _processInput(input).length;

int day${paddedDay}star2(String input) => _processInput(input).length;
''');

  File('test/$year/day${paddedDay}_test.dart').writeAsStringSync('''
import 'package:adventofcode/adventofcode2023.dart';
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
