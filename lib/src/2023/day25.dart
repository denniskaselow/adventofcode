import 'package:more/more.dart';

import '../utils.dart';

typedef Graph = Map<String, Set<String>>;

Iterable<String> _processInput(Input input) => input.getLines();

int day25star1(Input input) {
  final graph = _processInput(input).fold(Graph(), (graph, line) {
    final [nodes, connections] =
        line.split(':').map((e) => e.trim().split(' ')).toList();
    for (final node in nodes) {
      for (final node2 in connections) {
        graph.putIfAbsent(node, () => <String>{}).add(node2);
        graph.putIfAbsent(node2, () => <String>{}).add(node);
      }
    }
    return graph;
  });

  // loosely based on https://www.reddit.com/r/adventofcode/comments/18qbsxs/2023_day_25_solutions/kfoynua/
  final start = farthestNode(graph, graph.keys.first);
  final end = farthestNode(graph, start);
  final forbiddenEdges = <(String, String)>{};
  var subgraphSize = 0;
  for (var i = 0; i < 4; i++) {
    final (:path, :visited) =
        shortestDistinctPath(graph, start, end, forbiddenEdges);

    for (final edge in path.window(2)) {
      edge.sort();
      forbiddenEdges.add((edge[0], edge[1]));
    }

    subgraphSize = visited.length;
  }
  return subgraphSize * (graph.length - subgraphSize);
}

({Set<String> path, Set<String> visited}) shortestDistinctPath(
  Graph graph,
  String source,
  String dest,
  Set<(String, String)> forbiddenEdges,
) {
  final open = {
    (node: source, path: <String>{}),
  };
  var current = open.first;
  final visited = <String>{};
  while (open.isNotEmpty) {
    current = open.first;
    open.remove(current);
    if (current.node == dest) {
      return (path: current.path..add(dest), visited: visited);
    }
    if (current.path.add(current.node)) {
      for (final node in graph[current.node]!) {
        final edge = [node, current.node]..sort();
        if (!forbiddenEdges.contains((edge[0], edge[1]))) {
          if (visited.add(node)) {
            open.add((node: node, path: current.path.toSet()));
          }
        }
      }
    }
  }
  return (path: {}, visited: visited);
}

String farthestNode(Graph graph, String source) {
  final open = {source};
  final visited = <String>{};
  var current = '';
  while (open.isNotEmpty) {
    current = open.first;
    open.remove(current);
    if (visited.add(current)) {
      for (final node in graph[current]!) {
        if (!visited.contains(node)) {
          open.add(node);
        }
      }
    }
  }
  return current;
}

int day25star2(Input input) => _processInput(input).length;
