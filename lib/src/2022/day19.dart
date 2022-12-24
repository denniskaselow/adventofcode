import 'dart:math';

final _regExp = RegExp(
    r'Blueprint (?<id>\d+): Each ore robot costs (?<ore>\d+) ore. Each clay robot costs (?<clay>\d+) ore. Each obsidian robot costs (?<obsidianOre>\d+) ore and (?<obsidianClay>\d+) clay. Each geode robot costs (?<geodeOre>\d+) ore and (?<geodeObsidian>\d+) obsidian.');

int day19star1(String input) {
  final blueprints = _processInput(input);
  var result = 0;
  for (final blueprint in blueprints) {
    harvestGeodes(blueprint);
    result += blueprint.id * blueprint.maxGeodes;
  }
  return result;
}

int day19star2(String input) {
  final blueprints = _processInput(input);
  var result = 1;
  for (final blueprint in blueprints.take(3)) {
    harvestGeodes(blueprint, 32);
    result *= blueprint.maxGeodes;
  }
  return result;
}

Iterable<Blueprint> _processInput(String input) => input
    .split('\n')
    .map((e) => _regExp.allMatches(e).first)
    .map((e) => Blueprint(int.parse(e.namedGroup('id')!), [
          [int.parse(e.namedGroup('ore')!), 0, 0],
          [int.parse(e.namedGroup('clay')!), 0, 0],
          [
            int.parse(e.namedGroup('obsidianOre')!),
            int.parse(e.namedGroup('obsidianClay')!),
            0
          ],
          [
            int.parse(e.namedGroup('geodeOre')!),
            0,
            int.parse(e.namedGroup('geodeObsidian')!)
          ]
        ]));

void harvestGeodes(Blueprint blueprint,
    [int timeLeft = 24,
    List<int> res = const [0, 0, 0, 0],
    List<int> bots = const [1, 0, 0, 0],
    List<int> lastharvest = const [0, 0, 0, 0]]) {
  final harvest = bots.toList();
  blueprint.maxGeodes = max(blueprint.maxGeodes, res[3]);
  if (timeLeft > 0) {
    var bot = 3;
    final possibleObsidianBots = min(
            timeLeft,
            min(
                (res[1] + harvest[1] + timeLeft * (bots[1] + timeLeft / 2)) /
                    blueprint.costs[2][1],
                (res[0] + harvest[0] + timeLeft * (bots[0] + timeLeft / 2)) /
                    blueprint.costs[2][0])) ~/
        2;
    final possibleGeodeBots = min(
            timeLeft,
            (res[2] +
                    harvest[2] +
                    timeLeft * (bots[2] + possibleObsidianBots)) ~/
                blueprint.costs[3][2]) /
        2;
    if (res[3] + harvest[3] + timeLeft * (bots[3] + possibleGeodeBots) >
        blueprint.maxGeodes) {
      var canBuildEverything = true;
      for (final cost in blueprint.costs.reversed) {
        if (res[0] >= cost[0] && res[1] >= cost[1] && res[2] >= cost[2]) {
          // don't produce bots if they already produce enough ressources of
          // their type to build a building every minute
          if (bot == 3 || blueprint.maxCosts[bot] > bots[bot]) {
            // don't build a bot that could have already been produced the
            // previous minute
            if (bot == 3 ||
                !(res[0] - lastharvest[0] >= cost[0] &&
                    res[1] - lastharvest[1] >= cost[1] &&
                    res[2] - lastharvest[2] >= cost[2])) {
              final nextBots = bots.toList();
              nextBots[bot]++;
              harvestGeodes(
                  blueprint,
                  timeLeft - 1,
                  [
                    res[0] - cost[0] + harvest[0],
                    res[1] - cost[1] + harvest[1],
                    res[2] - cost[2] + harvest[2],
                    res[3] + harvest[3]
                  ],
                  nextBots,
                  harvest);
            }
          }
        } else {
          canBuildEverything = false;
        }
        bot--;
      }
      if (!canBuildEverything) {
        harvestGeodes(
            blueprint,
            timeLeft - 1,
            [
              res[0] + harvest[0],
              res[1] + harvest[1],
              res[2] + harvest[2],
              res[3] + harvest[3]
            ],
            bots,
            harvest);
      }
    }
  }
}

class Blueprint {
  final int id;
  final List<List<int>> costs;
  final List<int> maxCosts;
  int maxGeodes = 0;
  Blueprint(this.id, this.costs)
      : maxCosts = costs.fold(
            [0, 0, 0],
            (previousValue, element) => [
                  max(previousValue[0], element[0]),
                  max(previousValue[1], element[1]),
                  max(previousValue[2], element[2]),
                ]);
}
