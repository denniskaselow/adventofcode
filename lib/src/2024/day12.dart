import 'package:collection/collection.dart';

import '../utils.dart';

typedef Grid = Map<({int x, int y}), String>;
typedef PlotIds = Map<({int x, int y}), int>;

Map<({int x, int y}), String> _processInput(Input input) =>
    input.getLines().foldIndexed(<({int x, int y}), String>{}, (y, grid, line) {
      line.split('').forEachIndexed((x, element) {
        grid[(x: x, y: y)] = element;
      });
      return grid;
    });

int day12star1(Input input) {
  final grid = _processInput(input);

  final idsOfPlot = _getIdsOfPlots(grid);

  final result =
      idsOfPlot.entries
          .fold(<int, ({int fences, int area})>{}, (previousValue, cell) {
            var fences = 0;
            for (final direction in Direction.plus) {
              if (idsOfPlot[(
                    x: cell.key.x + direction.x,
                    y: cell.key.y + direction.y,
                  )] !=
                  cell.value) {
                fences++;
              }
            }
            previousValue.update(
              cell.value,
              (value) => (fences: value.fences + fences, area: value.area + 1),
              ifAbsent: () => (fences: fences, area: 1),
            );
            return previousValue;
          })
          .values
          .map((e) => e.fences * e.area)
          .sum;

  return result;
}

int day12star2(Input input) {
  final maxY = input.getLines().length;
  final maxX = input.getLines().first.length;
  final grid = _processInput(input);
  final idsOfPlot = _getIdsOfPlots(grid);
  final sidesOfPlots = <int, int>{};

  for (final direction in [Direction.n, Direction.s]) {
    var currentPlotId = -1;
    for (var y = 0; y < maxY; y++) {
      for (var x = 0; x < maxX; x++) {
        final plot = (x: x, y: y);
        final neighborPlot = (x: x + direction.x, y: y + direction.y);
        final plotId = idsOfPlot[plot]!;
        final neighborId = idsOfPlot[neighborPlot];
        if (plotId != neighborId && plotId != currentPlotId) {
          currentPlotId = plotId;
          sidesOfPlots.update(plotId, (value) => value + 1, ifAbsent: () => 1);
        } else if (plotId == neighborId) {
          currentPlotId = -1;
        }
      }
    }
  }
  for (final direction in [Direction.w, Direction.e]) {
    var currentPlotId = -1;
    for (var x = 0; x < maxX; x++) {
      for (var y = 0; y < maxY; y++) {
        final plot = (x: x, y: y);
        final neighborPlot = (x: x + direction.x, y: y + direction.y);
        final plotId = idsOfPlot[plot]!;
        final neighborId = idsOfPlot[neighborPlot];
        if (plotId != neighborId && plotId != currentPlotId) {
          currentPlotId = plotId;
          sidesOfPlots.update(plotId, (value) => value + 1, ifAbsent: () => 1);
        } else if (plotId == neighborId) {
          currentPlotId = -1;
        }
      }
    }
  }

  final result =
      idsOfPlot.entries
          .fold(<int, int>{}, (previousValue, cell) {
            previousValue.update(
              cell.value,
              (value) => value + 1,
              ifAbsent: () => 1,
            );
            return previousValue;
          })
          .entries
          .map((e) => e.value * sidesOfPlots[e.key]!)
          .sum;

  return result;
}

Map<({int x, int y}), int> _getIdsOfPlots(Map<({int x, int y}), String> grid) {
  final idsOfPlot = <({int x, int y}), int>{};
  var currentPlotId = 0;
  for (final MapEntry(key: plot, :value) in grid.entries) {
    final int plotId;
    if (!idsOfPlot.containsKey(plot)) {
      plotId = currentPlotId++;
    } else {
      plotId = idsOfPlot[plot]!;
    }
    idsOfPlot[plot] = plotId;
    _updatePlotIds(grid, idsOfPlot, value, plotId, plot, {});
  }
  return idsOfPlot;
}

void _updatePlotIds(
  Grid grid,
  PlotIds idsOfPlot,
  String value,
  int plotId,
  ({int x, int y}) plot,
  Set<({int x, int y})> visited,
) {
  if (visited.add(plot)) {
    for (final direction in Direction.plus) {
      final nextX = plot.x + direction.x;
      final nextY = plot.y + direction.y;
      final nextPlot = (x: nextX, y: nextY);
      if (grid[nextPlot] == value) {
        idsOfPlot[nextPlot] = plotId;
        _updatePlotIds(grid, idsOfPlot, value, plotId, nextPlot, visited);
      }
    }
  }
}
