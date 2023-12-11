import 'package:collection/collection.dart';
import 'package:more/more.dart';

import '../utils.dart';

Iterable<String> _processInput(String input) => input.getLines();

int day11star1(String input) => getSolution(input, 1);

int day11star2(String input) => getSolution(input, 1000000 - 1);
int day11star2with10(String input) => getSolution(input, 10 - 1);
int day11star2with100(String input) => getSolution(input, 100 - 1);

int getSolution(String input, int inflation) {
  final lines = _processInput(input);
  final galaxies = lines
      .indexed()
      .map((e) => '#'.allMatches(e.value).map((f) => (x: f.start, y: e.index)))
      .flattened
      .toList();

  final inflationX = galaxies.map((e) => e.x).toMap(value: (_) => 0);
  final inflationY = galaxies.map((e) => e.y).toMap(value: (_) => 0);

  var inflate = 0;
  for (var i = 0; i < lines.first.length; i++) {
    if (!inflationX.containsKey(i)) {
      inflate += inflation;
    } else {
      inflationX[i] = inflate;
    }
  }
  inflate = 0;
  for (var i = 0; i < lines.length; i++) {
    if (!inflationY.containsKey(i)) {
      inflate += inflation;
    } else {
      inflationY[i] = inflate;
    }
  }

  final inflatedGalaxy = galaxies
      .map((e) => (x: e.x + inflationX[e.x]!, y: e.y + inflationY[e.y]!))
      .toList();

  var distance = 0;
  for (var i = 0; i < inflatedGalaxy.length - 1; i++) {
    for (var j = i + 1; j < inflatedGalaxy.length; j++) {
      final galaxy1 = inflatedGalaxy[i];
      final galaxy2 = inflatedGalaxy[j];
      final delta =
          (galaxy1.x - galaxy2.x).abs() + (galaxy1.y - galaxy2.y).abs();
      distance += delta;
    }
  }

  return distance;
}
