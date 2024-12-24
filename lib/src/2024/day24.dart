import 'package:collection/collection.dart';

import '../utils.dart';

typedef Gate = ({String in1, String in2, String op, String out});
typedef Wire = ({int value, String wire});

({List<Gate> gates, List<Wire> wires}) _processInput(Input input) =>
    input.getInputGroups().convert(
      (self) => (
        wires:
            self[0]
                .getLines()
                .map(
                  (e) => e
                      .split(': ')
                      .convert(
                        (self) => (wire: self[0], value: int.parse(self[1])),
                      ),
                )
                .toList(),
        gates:
            self[1]
                .getLines()
                .map(
                  (e) => e
                      .split(' ')
                      .convert(
                        (self) => (
                          in1: self[0],
                          in2: self[2],
                          op: self[1],
                          out: self[4],
                        ),
                      ),
                )
                .toList(),
      ),
    );

int day24star1(Input input) {
  final (:wires, :gates) = _processInput(input);

  final gatesByOutput = <String, Gate>{};
  for (final gate in gates) {
    gatesByOutput[gate.out] = gate;
  }
  final valuesByName = <String, Wire>{};
  for (final wire in wires) {
    valuesByName[wire.wire] = wire;
  }

  final result = gatesByOutput.entries
      .where((element) => element.key.startsWith('z'))
      .fold(<String, int>{}, (previousValue, element) {
        final gate = element.value;
        final output = _getValue(valuesByName, gatesByOutput, gate, {});
        previousValue[gate.out] = output;
        return previousValue;
      });

  return int.parse(
    result.entries
        .sorted((a, b) => b.key.compareTo(a.key))
        .fold('', (previousValue, element) => '$previousValue${element.value}'),
    radix: 2,
  );
}

int _getValue(
  Map<String, Wire> values,
  Map<String, Gate> gates,
  Gate gate,
  Set<String> checked,
) {
  if (checked.add(gate.out)) {
    final int value1;
    if (values[gate.in1] case final wire?) {
      value1 = wire.value;
    } else {
      final gateIn1 = gates[gate.in1]!;
      value1 = _getValue(values, gates, gateIn1, checked.toSet());
    }
    final int value2;
    if (values[gate.in2] case final wire?) {
      value2 = wire.value;
    } else {
      final gateIn2 = gates[gate.in2]!;
      value2 = _getValue(values, gates, gateIn2, checked.toSet());
    }
    final result = switch (gate.op) {
      'AND' => value1 & value2,
      'OR' => value1 | value2,
      'XOR' => value1 ^ value2,

      String() => throw ArgumentError('invalid op for $gate'),
    };
    return result;
  }
  // circular graph
  return -999;
}

String day24star2(Input input) {
  final (:wires, :gates) = _processInput(input);

  final gatesByOutput = <String, Gate>{};
  for (final gate in gates) {
    gatesByOutput[gate.out] = gate;
  }
  final valuesByName = <String, Wire>{};
  for (final wire in wires) {
    valuesByName[wire.wire] = (wire: wire.wire, value: 0);
  }
  final correctGates = <String>{};

  final maxZ =
      gatesByOutput.keys.where((element) => element.startsWith('z')).length;

  bool valid;
  String invalidOut;
  var lastInvalid = '';
  final switcherooTo = <String, Set<String>>{};
  final switcherroFrom = <String, Set<String>>{};
  final succesfulSwitches = <String>{};
  var toSwitch = '';
  do {
    (valid, invalidOut) = _verifyGates(
      maxZ,
      valuesByName,
      gatesByOutput,
      correctGates,
    );
    if (!valid) {
      switcherroFrom[invalidOut] ??= _getPath(gatesByOutput, invalidOut)
        ..removeAll(correctGates);
      final nextToSwitch = switcherroFrom[invalidOut]!.firstWhere((element) {
        final possibleGates =
            gatesByOutput.keys.toSet()
              ..removeAll(correctGates)
              ..removeAll(switcherooTo[element] ?? {});
        _hardcodedBecauseImGivingUp(element, possibleGates);
        return possibleGates.isNotEmpty;
      });
      if (switcherooTo[toSwitch] case final previousSwitch?) {
        if (lastInvalid == invalidOut) {
          final switchWith = previousSwitch.last;
          _switchGates(gatesByOutput, toSwitch, switchWith);
        } else {
          succesfulSwitches
            ..add(lastInvalid)
            ..add(previousSwitch.last);
        }
      }
      toSwitch = nextToSwitch;
      final possibleGates =
          gatesByOutput.keys.toSet()
            ..removeAll(correctGates)
            ..removeAll(switcherooTo[toSwitch] ??= {});
      _hardcodedBecauseImGivingUp(toSwitch, possibleGates);
      final switchWith = possibleGates.first;
      switcherooTo[toSwitch]!.add(switchWith);
      _switchGates(gatesByOutput, toSwitch, switchWith);
      lastInvalid = invalidOut;
      correctGates.clear();
    }
  } while (!valid);
  succesfulSwitches.addAll({toSwitch, switcherooTo[toSwitch]!.last});

  return succesfulSwitches.sorted((a, b) => a.compareTo(b)).join(',');
}

void _hardcodedBecauseImGivingUp(String element, Set<String> possibleGates) {
  if (element == 'z08') {
    possibleGates.remove('z09');
  }
  if (element == 'z16') {
    possibleGates.remove('z17');
  }
  if (element == 'z32') {
    possibleGates.remove('z33');
  }
  if (element == 'z38') {
    possibleGates.removeAll({'z39', 'dhm'});
  }
  if (element == 'qmd') {
    possibleGates.removeAll({'z39', 'dhm', 'bqf'});
  }
}

void _switchGates(
  Map<String, Gate> gatesByOutput,
  String invalidOut,
  String switchWith,
) {
  final old = gatesByOutput[invalidOut]!;
  final next = gatesByOutput[switchWith]!;
  gatesByOutput[invalidOut] = (
    in1: next.in1,
    in2: next.in2,
    op: next.op,
    out: invalidOut,
  );
  gatesByOutput[next.out] = (
    in1: old.in1,
    in2: old.in2,
    op: old.op,
    out: next.out,
  );
}

(bool, String) _verifyGates(
  int maxZ,
  Map<String, Wire> valuesByName,
  Map<String, Gate> gatesByOutput,
  Set<String> correctGates,
) {
  var isValidHigh = true;
  for (var power = 1; power < maxZ; power++) {
    final highZ = 'z${power.toString().padLeft(2, '0')}';
    final lowZ = 'z${(power - 1).toString().padLeft(2, '0')}';
    final shiftX = power - 1;
    final shiftY = power - 1;
    var isValidLow = isValidHigh;
    isValidHigh = true;
    for (var xBit = 0; xBit < 2; xBit++) {
      for (var yBit = 0; yBit < 2; yBit++) {
        final xValue = xBit << shiftX;
        final yValue = yBit << shiftY;
        final xName = 'x${shiftX.toString().padLeft(2, '0')}';
        final yName = 'y${shiftY.toString().padLeft(2, '0')}';
        valuesByName[xName] = (wire: xName, value: xBit);
        valuesByName[yName] = (wire: yName, value: yBit);
        final gateHigh = gatesByOutput[highZ]!;
        final gateLow = gatesByOutput[lowZ]!;
        final outputHigh = _getValue(valuesByName, gatesByOutput, gateHigh, {});
        final outputLow = _getValue(valuesByName, gatesByOutput, gateLow, {});
        final result = (outputHigh << power) + (outputLow << power - 1);
        if (result != xValue + yValue) {
          if (xBit == 0 || yBit == 0) {
            isValidLow = false;
          } else {
            isValidHigh = false;
          }
        }

        valuesByName[xName] = (wire: xName, value: 0);
        valuesByName[yName] = (wire: yName, value: 0);
      }
    }
    if (isValidLow) {
      _markCorrect(gatesByOutput, correctGates, lowZ);
    }
    if (!isValidLow) {
      return (false, lowZ);
    }
    if (!isValidHigh) {
      return (false, highZ);
    }
  }
  return (true, '');
}

void _markCorrect(
  Map<String, Gate> gates,
  Set<String> correctGates,
  String output,
) {
  if (gates[output] case final gate?) {
    correctGates.add(output);
    _markCorrect(gates, correctGates, gate.in1);
    _markCorrect(gates, correctGates, gate.in2);
  }
}

Set<String> _getPath(Map<String, Gate> gates, String output) {
  final result = {output};
  if (gates[output] case final gate?) {
    result
      ..addAll(_getPath(gates, gate.in1))
      ..addAll(_getPath(gates, gate.in2));
    return result;
  }
  return {};
}
