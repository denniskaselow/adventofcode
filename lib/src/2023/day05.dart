import 'dart:math';

import 'package:more/more.dart';

import '../utils.dart';

int day05star1(String input) {
  final lines = input.getLines();
  final seeds = getSeeds(lines);
  final mappings = createMappings(lines);
  var closest = 0x7fffffffffffffff;
  for (final seed in seeds) {
    var value = seed;
    for (final mapping in mappings.values) {
      value = mapping
          .firstWhere((element) => element.containsSingle(value),
              orElse: () => Mapping(value, value, 1))
          .convertSingle(value);
    }
    closest = min(value, closest);
  }
  return closest;
}

int day05star2(String input) {
  final lines = input.getLines();
  var seedRanges =
      getSeeds(lines).window(2, step: 2).map((e) => SeedRange(e[0], e[1]));
  final mappings = createMappings(lines);
  var closest = 0x7fffffffffffffff;
  for (final mapping in mappings.values) {
    final seedRangesTmp = <SeedRange>[];
    for (final seedRange in seedRanges) {
      final needsConversion = [seedRange];
      do {
        final tmp = mapping
            .firstWhere(
              (element) =>
                  element.contains(needsConversion.first) ||
                  element.interesectsLeft(needsConversion.first) ||
                  element.interesectsRight(needsConversion.first) ||
                  element.containedBy(needsConversion.first),
              orElse: () => Mapping(needsConversion.first.start,
                  needsConversion.first.start, needsConversion.first.length),
            )
            .convert(needsConversion.first);
        needsConversion
          ..removeAt(0)
          ..addAll(tmp.$2);
        seedRangesTmp.add(tmp.$1);
      } while (needsConversion.isNotEmpty);
    }
    seedRanges = seedRangesTmp;
  }
  for (final seedRange in seedRanges) {
    closest = min(seedRange.start, closest);
  }
  return closest;
}

Iterable<int> getSeeds(Iterable<String> lines) =>
    lines.first.split(':').last.trim().split(' ').map(int.parse);

Map<int, List<Mapping>> createMappings(Iterable<String> lines) {
  final mappingLines = lines.skip(2);
  final mappings = <int, List<Mapping>>{};
  var mappingId = 0;
  for (final mappingLine in mappingLines) {
    if (mappingLine.isEmpty) {
      mappingId++;
    } else if (mappingLine.contains(':')) {
      continue;
    } else {
      final [dest, start, length] =
          mappingLine.split(' ').map(int.parse).toList();
      mappings.putIfAbsent(mappingId, () => []);
      mappings[mappingId]!.add(Mapping(start, dest, length));
    }
  }
  return mappings;
}

class Mapping {
  Mapping(this.source, this.dest, this.length);
  int source;
  int dest;
  int length;
  int get end => source + length - 1;

  bool containsSingle(int value) => value >= source && value < source + length;
  bool contains(SeedRange range) => range.start >= source && range.end <= end;

  bool interesectsLeft(SeedRange range) =>
      range.start < source && range.end >= source && range.end <= end;
  bool interesectsRight(SeedRange range) =>
      range.start >= source && range.start <= end && range.end > end;
  bool containedBy(SeedRange range) => range.start < source && range.end > end;
  int convertSingle(int value) => dest + value - source;
  (SeedRange, List<SeedRange>) convert(SeedRange range) => switch (range) {
        final _ when contains(range) => (
            SeedRange(convertSingle(range.start), range.length),
            [],
          ),
        final _ when interesectsLeft(range) => (
            SeedRange(convertSingle(source), range.end - source + 1),
            [
              SeedRange(range.start, source - range.start),
            ]
          ),
        final _ when interesectsRight(range) => (
            SeedRange(convertSingle(range.start), end - range.start + 1),
            [
              SeedRange(end + 1, range.end - end),
            ]
          ),
        final _ when containedBy(range) => (
            SeedRange(convertSingle(source), length),
            [
              SeedRange(range.start, source - range.start),
              SeedRange(end + 1, range.end - end),
            ]
          ),
        final _ => throw Exception('does not happen'),
      };
}

class SeedRange {
  SeedRange(this.start, this.length);
  int start;
  int length;
  int get end => start + length - 1;
}
