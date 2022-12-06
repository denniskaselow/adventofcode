import 'package:more/more.dart';

import '../utils.dart';

int day6star1(String input) => getIndex(input, 4);
int day6star2(String input) => getIndex(input, 14);

int getIndex(String input, int distinct) =>
    input
        .toList()
        .window(distinct)
        .firstIndexWhere((element) => element.toSet().length == distinct) +
    distinct;
