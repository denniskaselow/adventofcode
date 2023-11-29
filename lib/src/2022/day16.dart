import 'dart:math';

import 'package:collection/collection.dart';

final regExp = RegExp(
  r'Valve (..) has flow rate=(\d+); tunnel(s?) lead(s?) to valve(s?)? (.+)',
);

int day16star1(String input) {
  final caverns = getCaverns(input);
  return visitNodes(Node('AA', {}, 30), caverns);
}

int day16star2(String input) {
  final caverns = getCaverns(input);
  return visitNodes(Node('AA', {}, 26), caverns, withElephant: true);
}

Map<String, Cavern> getCaverns(String input) {
  final lines = _processInput(input);
  final caverns = <String, Cavern>{};
  for (final line in lines) {
    final match = regExp.firstMatch(line)!;
    final id = match.group(1)!;
    final tunnels = {
      for (final tunnel in match.group(6)!.split(', ')) tunnel: 1,
    };
    tunnels[id] = 0;
    caverns[id] = Cavern(id, int.parse(match.group(2)!), tunnels);
  }
  for (var i = 2; i < caverns.length; i++) {
    for (final cavern in caverns.values) {
      for (final tunnel in cavern.tunnels.keys.toList()) {
        final targetCavern = caverns[tunnel]!;
        for (final nextTunnel in targetCavern.tunnels.entries) {
          if (nextTunnel.key == cavern.id) {
            continue;
          }
          final distance = cavern.tunnels[nextTunnel.key];
          final newDistance = targetCavern.tunnels[nextTunnel.key]! +
              cavern.tunnels[targetCavern.id]!;
          if (distance == null || distance > newDistance) {
            cavern.tunnels[nextTunnel.key] = newDistance;
          }
        }
      }
    }
  }
  return caverns;
}

int visitNodes(
  Node current,
  Map<String, Cavern> caverns, {
  bool withElephant = false,
}) {
  final cacheKey =
      '''${current.cavernId}-${current.minutesLeft}-${current.cavernsDone.sorted((a, b) => a.compareTo(b))}''';
  final candidates = caverns.values.where(
    (element) => element.flow > 0 && !current.cavernsDone.contains(element.id),
  );
  var pressure = cache[cacheKey] ?? 0;
  if (pressure == 0) {
    for (final candidate in candidates) {
      final timeLeft = current.minutesLeft -
          caverns[current.cavernId]!.tunnels[candidate.id]! -
          1;
      if (timeLeft >= 0) {
        final node = Node(
          candidate.id,
          current.cavernsDone.toSet()..add(candidate.id),
          timeLeft,
        );
        final youPressure =
            visitNodes(node, caverns, withElephant: withElephant);
        final elephantStart = Node('AA', node.cavernsDone.toSet(), 26);
        pressure = max(
          max(
                youPressure,
                withElephant ? visitNodes(elephantStart, caverns) : 0,
              ) +
              timeLeft * candidate.flow,
          pressure,
        );
      }
    }
    cache[cacheKey] = pressure;
  }
  return pressure;
}

final Map<String, int> cache = {};

List<String> _processInput(String input) => input.split('\n');

class Cavern {
  Cavern(this.id, this.flow, this.tunnels);
  final String id;
  final int flow;
  final Map<String, int> tunnels;
}

class Node {
  Node(this.cavernId, this.cavernsDone, this.minutesLeft);
  final String cavernId;
  final Set<String> cavernsDone;
  final int minutesLeft;
}
