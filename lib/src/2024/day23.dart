import 'package:collection/collection.dart';
import 'package:more/collection.dart';

import '../utils.dart';

List<List<String>> _processInput(Input input) =>
    input
        .getLines()
        .map((e) => e.split('-').permutations(2))
        .expand((element) => element)
        .toList();

int day23star1(Input input) {
  final connections = _processInput(input);
  const groupStartsWith = 't';

  final groups = <String, Set<String>>{};
  for (final connection in connections) {
    for (final system in connection) {
      (groups[system] ??= {}).addAll(connection);
    }
  }

  final possibleGroups = groups.entries.where(
    (element) => element.key.startsWith(groupStartsWith),
  );

  final resultList = <String>{};
  for (final MapEntry(key: system, value: group) in possibleGroups) {
    final checked = {system};
    while (true) {
      if (group.firstWhereOrNull((element) => !checked.contains(element))
          case final toCheck?) {
        final groupToCheck = groups[toCheck]!;
        final others = groupToCheck.intersection(group)
          ..removeAll({system, toCheck});
        for (final other in others) {
          resultList.add([system, toCheck, other].sorted().join());
        }
        checked.add(toCheck);
      } else {
        break;
      }
    }
  }
  return resultList.length;
}

String day23star2(Input input) {
  final connections = _processInput(input);
  const groupSize = 3;

  final groups = <String, Set<String>>{};
  for (final connection in connections) {
    for (final system in connection) {
      (groups[system] ??= {}).addAll(connection);
    }
  }

  final networks = <String, List<Set<String>>>{};
  for (final system in groups.keys) {
    final currentGroup = groups[system]!;
    for (final group in groups.entries
        .where((element) => element.key != system)
        .map((e) => e.value)
        .where((element) => element.contains(system))) {
      final intersection = currentGroup.intersection(group);
      if (intersection.length >= groupSize) {
        (networks[system] ??= []).add(intersection);
      }
    }
  }

  final result = networks.entries
      .map(
        (e) => e.value.reduce(
          (previousValue, element) => previousValue.intersection(element),
        ),
      )
      .reduce(
        (value, element) => element.length > value.length ? element : value,
      );
  return result.sorted().join(',');
}
