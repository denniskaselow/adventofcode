import 'package:collection/collection.dart';

import '../utils.dart';

int day09star1(Input input) => getPrediction(input);
int day09star2(Input input) => getPrediction(input, part1: false);

int getPrediction(Input input, {bool part1 = true}) =>
    input.getLines().map((e) {
      final data = [e.split(' ').map(int.parse).toList()];
      var currentRow = data[0];
      while (!currentRow.every((element) => element == 0)) {
        data.add([
          for (var i = 0; i < currentRow.length - 1; i++)
            currentRow[i + 1] - currentRow[i],
        ]);
        currentRow = data.last;
      }
      for (var i = data.length - 2; i >= 0; i--) {
        final current = part1 ? data[i].last : data[i].first;
        final previous = data[i + 1].last * (part1 ? 1 : -1);
        data[i].add(current + previous);
      }
      return data.first.last;
    }).sum;
