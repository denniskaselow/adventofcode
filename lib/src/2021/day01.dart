import 'package:collection/collection.dart';
import 'package:more/more.dart';

import '../utils.dart';

Iterable<int> _processInput(Input input) => input.getLines().map(int.parse);

int day01star1(Input input) => _processInput(
  input,
).window(2).count((element) => element.first < element.last);

int day01star2(Input input) => _processInput(input)
    .window(3)
    .map((e) => e.sum)
    .window(2)
    .count((element) => element.first < element.last);
