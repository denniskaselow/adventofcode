import 'dart:io';

void main(List<String> args) {
  final (day, year) = switch (args) {
    [final day, final year] => (int.parse(day), int.parse(year)),
    final _ => (DateTime.now().day, DateTime.now().year),
  };
  final paddedDay = day.toString().padLeft(2, '0');

  final taskFile = File('lib/src/$year/day$paddedDay.dart');
  if (!taskFile.existsSync()) {
    taskFile.createSync(recursive: true);
  }
  taskFile.writeAsStringSync('''
import '../utils.dart';

_processInput(Input input) => input.getLines();

int day${paddedDay}star1(Input input) {
  final result = _processInput(input).map((line) {
    final converted = line.split('').map((cell) {
      return cell;
    });
    return converted;
  });

  print(result.join('\\n'));
  return result.length;
}

int day${paddedDay}star2(Input input) => _processInput(input).length;
''');

  final testFile = File('test/$year/day${paddedDay}_test.dart');
  if (!testFile.existsSync()) {
    testFile.createSync(recursive: true);
  }
  testFile.writeAsStringSync('''
import 'package:adventofcode/adventofcode$year.dart';
import 'package:adventofcode/src/utils.dart';
import 'package:test/test.dart';

void main() {
  const input = Input(\'\'\'
\'\'\');

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
export 'src/$year/day$paddedDay.dart' show day${paddedDay}star1, day${paddedDay}star2;
''',
    mode: FileMode.append,
  );
}
