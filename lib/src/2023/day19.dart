import 'package:collection/collection.dart';

import '../utils.dart';

typedef Condition = ({String param, Operation operation, int value});
typedef Rule = ({String target, Condition condition});
typedef Part = Map<String, int>;

enum Operation {
  lt,
  gt,
  none;
}

int day19star1(String input) {
  final lines = input.getLines();
  final workflowsDesc = lines.takeWhile((value) => value != '');
  final partsDesc = lines.skip(workflowsDesc.length + 1);

  final workflows = getWorkflows(workflowsDesc);

  final parts = partsDesc.map(
    (part) => part.substring(1, part.length - 1).split(',').fold(Part(),
        (previousValue, element) {
      final [property, value] = element.split('=');
      previousValue[property] = int.parse(value);
      return previousValue;
    }),
  );

  final accepted = <Map<String, int>>[];
  for (final part in parts) {
    var current = 'in';
    while (current != 'A' && current != 'R') {
      final workflow = workflows[current]!;
      for (final rule in workflow) {
        final target = switch (rule.condition.operation) {
          Operation.none => rule.target,
          Operation.lt
              when part[rule.condition.param]! < rule.condition.value =>
            rule.target,
          Operation.gt
              when part[rule.condition.param]! > rule.condition.value =>
            rule.target,
          final _ => null,
        };
        if (target != null) {
          current = target;
          break;
        }
      }
    }
    if (current == 'A') {
      accepted.add(part);
    }
  }

  return accepted.map((e) => e.values.sum).sum;
}

Map<String, List<Rule>> getWorkflows(Iterable<String> workflowsDesc) {
  final workflows =
      workflowsDesc.fold(<String, List<Rule>>{}, (previous, workflowDesc) {
    final workflowMatch =
        RegExp(r'(?<name>\w+){(?<rules>.+)}').firstMatch(workflowDesc)!;
    final name = workflowMatch.namedGroup('name')!;
    final rulesDesc = workflowMatch.namedGroup('rules')!;
    final rules = rulesDesc.split(',').map((rule) {
      final match =
          RegExp(r'((?<param>\w)(?<op>.)(?<value>\d+):)?(?<target>\w+)')
              .firstMatch(rule)!;
      Rule result;
      if (match.namedGroup('param') case final param?) {
        final value = int.parse(match.namedGroup('value')!);
        final op = switch (match.namedGroup('op')) {
          '<' => Operation.lt,
          '>' => Operation.gt,
          final error => throw Exception('unknown operation $error in $rule'),
        };
        result = (
          target: match.namedGroup('target')!,
          condition: (param: param, operation: op, value: value)
        );
      } else {
        result = (
          target: match.namedGroup('target')!,
          condition: (param: '', operation: Operation.none, value: 0)
        );
      }
      return result;
    });
    previous[name] = rules.toList();
    return previous;
  });
  return workflows;
}

typedef Range = Map<String, ({int start, int end})>;
typedef PartRange = ({Range range, String current});

int day19star2(String input) {
  final lines = input.getLines();
  final workflowsDesc = lines.takeWhile((value) => value != '');

  final workflows = getWorkflows(workflowsDesc);

  var accepted = 0;
  final parts = [
    (
      range: {
        'x': (start: 1, end: 4000),
        'm': (start: 1, end: 4000),
        'a': (start: 1, end: 4000),
        's': (start: 1, end: 4000),
      },
      current: 'in'
    ),
  ];
  while (parts.isNotEmpty) {
    var part = parts.removeAt(0);
    final current = part.current;
    if (current != 'A' && current != 'R') {
      final workflow = workflows[current]!;
      for (final rule in workflow) {
        final (:valid, :invalid) = switch (rule.condition.operation) {
          Operation.none => (
              valid: (range: part.range, current: rule.target),
              invalid: null
            ),
          Operation.lt
              when part.range[rule.condition.param]!.end <
                  rule.condition.value =>
            (valid: (range: part.range, current: rule.target), invalid: null),
          Operation.gt
              when part.range[rule.condition.param]!.start >
                  rule.condition.value =>
            (valid: (range: part.range, current: rule.target), invalid: null),
          Operation.lt
              when part.range[rule.condition.param]!.start >
                  rule.condition.value =>
            (valid: null, invalid: part.range),
          Operation.gt
              when part.range[rule.condition.param]!.end <
                  rule.condition.value =>
            (valid: null, invalid: part.range),
          Operation.lt => getLessThanSplit(part, rule),
          Operation.gt => getGreaterThanSplit(part, rule),
        };
        if (valid != null) {
          parts.add(valid);
          if (invalid == null) {
            break;
          }
        }
        part = invalid! as PartRange;
      }
    }
    if (current == 'A') {
      accepted += part.range.values.fold(
        1,
        (previousValue, element) =>
            previousValue * (element.end - element.start + 1),
      );
    }
  }

  return accepted;
}

({PartRange valid, PartRange invalid}) getLessThanSplit(
  PartRange part,
  Rule rule,
) {
  final moveToTarget = Map.fromEntries(part.range.entries);
  final keepChecking = Map.fromEntries(part.range.entries);
  for (final param in part.range.keys) {
    if (param == rule.condition.param) {
      moveToTarget[param] =
          (start: moveToTarget[param]!.start, end: rule.condition.value - 1);
      keepChecking[param] =
          (start: rule.condition.value, end: keepChecking[param]!.end);
    }
  }
  return (
    valid: (range: moveToTarget, current: rule.target),
    invalid: (range: keepChecking, current: part.current),
  );
}

({PartRange valid, PartRange invalid}) getGreaterThanSplit(
  PartRange part,
  Rule rule,
) {
  final moveToTarget = Map.fromEntries(part.range.entries);
  final keepChecking = Map.fromEntries(part.range.entries);
  for (final param in part.range.keys) {
    if (param == rule.condition.param) {
      moveToTarget[param] =
          (start: rule.condition.value + 1, end: moveToTarget[param]!.end);
      keepChecking[param] =
          (start: keepChecking[param]!.start, end: rule.condition.value);
    }
  }
  return (
    valid: (range: moveToTarget, current: rule.target),
    invalid: (range: keepChecking, current: part.current),
  );
}
