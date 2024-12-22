import 'package:collection/collection.dart';
import 'package:more/collection.dart';

import '../utils.dart';

typedef Pos = ({int x, int y});
typedef Grid = Map<Pos, String>;

Iterable<List<String>> _processInput(Input input) =>
    input.getLines().map((e) => e.split('').toList());

int day21star1(Input input, {int levelsOfIndirection = 2}) {
  final buttonsList = _processInput(input);

  var result = 0;
  for (final buttons in buttonsList) {
    final code = int.parse(buttons.take(buttons.length - 1).join());
    final user = Cursorpad(1);
    var controller = user;
    for (var i = 0; i < levelsOfIndirection; i++) {
      controller = Cursorpad(i + 2, controller);
    }
    final numpad = Numpad(0, controller);

    final buttonsPressed = numpad.pressButtons(buttons);
    result += buttonsPressed * code;
  }

  return result;
}

int day21star2(Input input, {int levelsOfIndirection = 25}) =>
    day21star1(input, levelsOfIndirection: levelsOfIndirection);

abstract class Keypad {
  Keypad(this.level, this.controller);

  final int level;
  final Cursorpad? controller;
  var currentKey = 'A';
  Grid? _pad;

  Input get layout;
  Grid get pad =>
      _pad ??= layout.getLines().foldIndexed<Grid>(
        <({int x, int y}), String>{},
        (y, grid, line) {
          line.split('').forEachIndexed((x, cell) {
            grid[(x: x, y: y)] = cell;
          });
          return grid;
        },
      );

  int pressButtons(Iterable<String> buttons) {
    var buttonsPressed = 0;
    final dontTouchPos =
        pad.entries.firstWhere((element) => element.value == '#').key;
    if (controller case final controller?) {
      for (final button in buttons) {
        final currentPos =
            pad.entries
                .firstWhere((element) => element.value == currentKey)
                .key;
        final targetPos =
            pad.entries.firstWhere((element) => element.value == button).key;

        if (currentPos == targetPos) {
          buttonsPressed += 1;
        } else {
          final movement = (
            x: targetPos.x - currentPos.x,
            y: targetPos.y - currentPos.y,
          );
          final dontTouch = (
            x: dontTouchPos.x - currentPos.x,
            y: dontTouchPos.y - currentPos.y,
          );
          buttonsPressed += controller.moveArm(movement, dontTouch);
        }
        currentKey = button;
      }
    } else {
      buttonsPressed += buttons.length;
    }
    return buttonsPressed;
  }
}

class Numpad extends Keypad {
  Numpad(super.level, super.controller);

  @override
  Input get layout => const Input('''
789
456
123
#0A''');
}

class Cursorpad extends Keypad {
  Cursorpad(super.level, [super.controller]);

  final Map<String, int> buttonCache = {};
  @override
  Input get layout => const Input('''
#^A
<v>''');

  int moveArm(Pos movement, Pos dontTouchMovement) {
    final cacheKey = '$movement$dontTouchMovement';
    if (buttonCache[cacheKey] case final bestMovement?) {
      return bestMovement;
    }
    final possibleInputs = _getPossibleMovements(movement);
    _getPossibleMovements(dontTouchMovement).forEach(
      (impossibleMove) => possibleInputs.removeWhere(
        (element) => element.startsWith(impossibleMove),
      ),
    );
    var moveCount = -1;
    var buttonsPressed = 0;
    for (final possibleInput in possibleInputs) {
      final buttonsToPress = possibleInput.split('').followedBy(['A']);
      final tmp = pressButtons(buttonsToPress);
      if (tmp < moveCount || moveCount == -1) {
        moveCount = tmp;
        buttonsPressed = tmp;
      }
    }
    buttonCache[cacheKey] = buttonsPressed;
    return buttonsPressed;
  }

  Set<String> _getPossibleMovements(Pos movement) {
    final buttons = switch (movement) {
      (x: final x, y: final y) when x >= 0 && y >= 0 => '>' * x + 'v' * y,
      (x: final x, y: final y) when x >= 0 && y <= 0 => '>' * x + '^' * y.abs(),
      (x: final x, y: final y) when x <= 0 && y >= 0 => '<' * x.abs() + 'v' * y,
      (x: final x, y: final y) when x <= 0 && y <= 0 =>
        '<' * x.abs() + '^' * y.abs(),
      (x: _, y: _) => throw ArgumentError('impossible movement $movement'),
    };

    final possibleInputs =
        buttons
            .split('')
            .permutations(buttons.length)
            .map((e) => e.join())
            .toSet();
    return possibleInputs;
  }
}
