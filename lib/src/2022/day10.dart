int day10star1(String input) {
  final ops = _processInput(input);
  var totalTime = 0;
  var i = 0;
  var sum = 1;
  var totalSum = 0;
  for (final op in ops) {
    totalTime += op.length;
    if (totalTime >= getCycleNumber(i)) {
      totalSum += sum * getCycleNumber(i);
      i++;
    }
    sum += op.value;
  }
  return totalSum;
}

String day10star2(String input) {
  final ops = _processInput(input).toList();
  final output = StringBuffer();
  var totalTime = 0;
  var spritePosition = 0;
  var opIndex = 0;
  var cycle = 0;
  while (true) {
    if (totalTime + ops[opIndex].length == cycle) {
      final op = ops[opIndex];
      opIndex++;
      totalTime += op.length;
      spritePosition += op.value;
    }
    if (cycle >= spritePosition && cycle <= spritePosition + 2) {
      output.write('#');
    } else {
      output.write('.');
    }

    if (opIndex == ops.length - 1) {
      break;
    }
    if (cycle % 40 == 39) {
      output.write('\n');
      spritePosition += 40;
    }
    cycle++;
  }
  return output.toString();
}

Iterable<Op> _processInput(String input) {
  return input.split('\n').map((e) => Op(e));
}

int getCycleNumber(int i) {
  return 20 + i * 40;
}

abstract class Op {
  int get length;

  int get value;

  factory Op(String line) {
    if (line == 'noop') {
      return Noop();
    }
    return AddOp(int.parse(line.split(' ')[1]));
  }
}

class Noop implements Op {
  @override
  int get value => 0;

  @override
  int get length => 1;
}

class AddOp implements Op {
  @override
  final int value;

  AddOp(this.value);

  @override
  int get length => 2;
}
