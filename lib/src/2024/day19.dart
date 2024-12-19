import '../utils.dart';

({List<Input> patterns, Set<String> towels}) _processInput(Input input) =>
    input.getInputGroups().convert(
      (self) => (
        towels: self[0].split(', ').toSet(),
        patterns: self[1].getLines(),
      ),
    );

int day19star1(Input input) {
  final (:towels, :patterns) = _processInput(input);
  final impossiblePatterns = <String>{};
  final possibleCounts = <String, int>{};

  var result = 0;
  for (final pattern in patterns) {
    if (_countPossibleArrangements(
          pattern,
          towels,
          impossiblePatterns,
          possibleCounts,
        ) >
        0) {
      result++;
    }
  }

  return result;
}

int day19star2(Input input) {
  final (:towels, :patterns) = _processInput(input);
  final impossiblePatterns = <String>{};
  final possibleCounts = <String, int>{};

  var result = 0;
  for (final pattern in patterns) {
    result += _countPossibleArrangements(
      pattern,
      towels,
      impossiblePatterns,
      possibleCounts,
    );
  }
  return result;
}

int _countPossibleArrangements(
  String pattern,
  Set<String> towels,
  Set<String> impossiblePatterns,
  Map<String, int> possibleCounts,
) {
  if (impossiblePatterns.contains(pattern)) {
    return 0;
  }
  if (possibleCounts[pattern] case final count?) {
    return count;
  }
  var count = 0;
  for (final towel in towels) {
    if (pattern == towel) {
      count++;
    } else if (pattern.startsWith(towel)) {
      count += _countPossibleArrangements(
        pattern.substring(towel.length),
        towels,
        impossiblePatterns,
        possibleCounts,
      );
    }
  }
  if (count == 0) {
    impossiblePatterns.add(pattern);
  } else {
    possibleCounts[pattern] = count;
  }
  return count;
}
