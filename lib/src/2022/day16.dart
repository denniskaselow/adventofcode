import 'dart:math';

import 'package:collection/collection.dart';
import 'package:more/more.dart';

final regExp = RegExp(
    r'Valve (..) has flow rate=(\d+); tunnel(s?) lead(s?) to valve(s?)? (.+)');

int day16star1(String input) {
  final caverns = getCaverns(input);
  final nodes = visitNodes(Node(0, 'AA', {}, 30), caverns);
  return nodes.map((e) => e.pressure).fold(0, max);
}

int day16star2(String input) {
  final caverns = getCaverns(input);
  final nodes = visitNodes2(Node2(0, null, {}, [], 26), caverns);
  return nodes.max;
}

Map<String, Cavern> getCaverns(String input) {
  final lines = _processInput(input);
  final caverns = <String, Cavern>{};
  for (final line in lines) {
    final match = regExp.firstMatch(line)!;
    final id = match.group(1)!;
    final tunnels = {
      for (final tunnel in match.group(6)!.split(', ')) tunnel: 1
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

List<Node> visitNodes(Node current, Map<String, Cavern> caverns) {
  final candidates = caverns.values.where((element) =>
      element.flow > 0 && !current.cavernsDone.contains(element.id));
  final result = <Node>[];
  var outOfTime = true;
  for (final candidate in candidates) {
    final timeLeft = current.minutesLeft -
        caverns[current.cavernId]!.tunnels[candidate.id]! -
        1;
    if (timeLeft >= 0) {
      outOfTime = false;
      final node = Node(
          timeLeft * candidate.flow + current.pressure,
          candidate.id,
          current.cavernsDone.toSet()..add(candidate.id),
          timeLeft);
      result.addAll(visitNodes(node, caverns));
    }
  }
  if (candidates.isEmpty || outOfTime) {
    result.add(current);
  }
  return result;
}

List<int> visitNodes2(Node2 current, Map<String, Cavern> caverns) {
  final candidates = caverns.values
      .where((element) =>
          element.flow > 0 && !current.cavernsDone.contains(element.id))
      .sorted((a, b) => b.flow - a.flow);
  final result = <int>[];
  var outOfTime = true;
  if (current.actions.isEmpty && candidates.isNotEmpty) {
    for (final candidate in candidates.combinations(2)) {
      print(candidate.join('\n'));
      print('---');
      final actions = candidate
          .map((e) => Action(
              e.id, current.timeLeft - caverns['AA']!.tunnels[e.id]! - 1))
          .sorted(byTimeLeft);
      final done = candidate.map((e) => e.id);
      final node = Node2(0, current, current.cavernsDone.toSet()..addAll(done),
          actions, current.timeLeft);
      final watch = Stopwatch()..start();
      result.add(visitNodes2(node, caverns).max);
      print(result);
      print(watch.elapsed);
    }
  } else if (current.actions.isNotEmpty) {
    final action = current.actions.last;
    final timeLeft = action.timeLeft;
    if (timeLeft >= 0) {
      outOfTime = false;
      if (candidates.isNotEmpty) {
        for (final candidate in candidates) {
          final cavern = caverns[action.cavernId]!;
          final nextAction = Action(
              candidate.id, timeLeft - cavern.tunnels[candidate.id]! - 1);
          final actions = [current.actions[0], nextAction].sorted(byTimeLeft);
          final node = Node2(
              current.pressure + timeLeft * cavern.flow,
              current,
              current.cavernsDone.toSet()..add(candidate.id),
              actions,
              timeLeft);
          result.addAll(visitNodes2(node, caverns));
        }
      } else {
        current.actions.removeLast();
        final cavern = caverns[action.cavernId]!;
        final node = Node2(
            current.pressure + timeLeft * cavern.flow,
            current,
            current.cavernsDone.toSet(),
            [if (current.actions.length == 1) current.actions[0]],
            timeLeft);
        result.addAll(visitNodes2(node, caverns));
      }
    }
  }
  if (candidates.isEmpty || outOfTime) {
    result.add(current.pressure);
  }
  return result;
}

int byTimeLeft(Action a, Action b) => a.timeLeft - b.timeLeft;

List<String> _processInput(String input) => input.split('\n');

class Cavern {
  final String id;
  int flow;
  final Map<String, int> tunnels;
  Cavern(this.id, this.flow, this.tunnels);

  @override
  String toString() => 'Cavern{id: $id, flow: $flow, tunnels: $tunnels}';
}

class Node {
  final int pressure;
  final String cavernId;
  final Set<String> cavernsDone;
  final int minutesLeft;
  Node(this.pressure, this.cavernId, this.cavernsDone, this.minutesLeft);

  @override
  String toString() =>
      'Node{pressure: $pressure, cavernId: $cavernId, cavernsDone: $cavernsDone, minutesLeft: $minutesLeft}';
}

class Node2 {
  final int pressure;
  final Set<String> cavernsDone;
  final int timeLeft;
  final List<Action> actions;
  final Node2? parent;
  Node2(this.pressure, this.parent, this.cavernsDone, this.actions,
      this.timeLeft);

  @override
  String toString() =>
      'Node{pressure: $pressure, cavernsDone: $cavernsDone, minutesLeft: $timeLeft, actions: $actions, parent: $parent}';
}

class Action {
  String cavernId;
  int timeLeft;
  Action(this.cavernId, this.timeLeft);

  @override
  String toString() => 'Action{cavernId: $cavernId, timeLeft: $timeLeft}';
}
