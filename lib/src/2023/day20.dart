import '../utils.dart';

enum SignalType {
  low,
  high;

  SignalType get invert => switch (this) {
        low => high,
        high => low,
      };
}

sealed class Module {
  Module(this.targets);
  final List<String> targets;
  SignalType? onSignal(Signal signal) => signal.type;
}

class FlipFlop extends Module {
  FlipFlop(super.targets);
  bool on = false;

  @override
  SignalType? onSignal(Signal signal) {
    if (signal.type == SignalType.low) {
      on = !on;
      return on ? SignalType.high : SignalType.low;
    }
    return null;
  }
}

class Conjunction extends Module {
  Conjunction(super.targets);
  Map<String, SignalType> memory = {};

  @override
  SignalType? onSignal(Signal signal) {
    memory[signal.source] = signal.type;
    return memory.values.every((element) => element == SignalType.high)
        ? SignalType.low
        : SignalType.high;
  }
}

class Broadcaster extends Module {
  Broadcaster(super.targets);
}

typedef Modules = Map<String, Module>;
typedef Signal = ({String source, String target, SignalType type});

int day20star1(String input) {
  final modules = getModules(input);

  var low = 0;
  var high = 0;
  for (var i = 0; i < 1000; i++) {
    final open = <Signal>[
      (source: 'button', target: 'broadcaster', type: SignalType.low),
    ];
    while (open.isNotEmpty) {
      final signal = open.removeAt(0);
      low += signal.type == SignalType.low ? 1 : 0;
      high += signal.type == SignalType.high ? 1 : 0;

      if (modules[signal.target] case final receiver?) {
        final type = receiver.onSignal(signal);
        for (final target in receiver.targets) {
          if (type != null) {
            open.add((type: type, source: signal.target, target: target));
          }
        }
      }
    }
  }

  return high * low;
}

Map<String, Module> getModules(String input) {
  final modules = input.getLines().fold(Modules(), (prev, line) {
    final [source, targets] = line.split(' -> ');
    final targetList = targets.split(',').map((e) => e.trim()).toList();
    final module = switch (source.substring(0, 1)) {
      '%' => FlipFlop(targetList),
      '&' => Conjunction(targetList),
      final _ => Broadcaster(targetList),
    };
    final moduleName = switch (module) {
      Broadcaster() => source,
      final _ => source.substring(1),
    };

    prev[moduleName] = module;
    return prev;
  });

  for (final MapEntry(key: name, value: module) in modules.entries) {
    if (module case Conjunction()) {
      for (final source in modules.entries
          .where((element) => element.value.targets.contains(name))
          .map((e) => e.key)) {
        module.memory[source] = SignalType.low;
      }
    }
  }
  return modules;
}

int day20star2(String input) => 0;
