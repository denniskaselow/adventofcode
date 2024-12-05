import 'package:collection/collection.dart';

import '../utils.dart';

List<Input> _processInput(Input input) => input.getInputGroups();

int day05star1(Input input) {
  final [ordering, manuals] = _processInput(input);
  final pageorder = ordering
      .getLines()
      .map((element) => element.split('|').map(int.parse))
      .fold(
        <int, List<int>>{},
        (previous, element) =>
            previous..update(
              element.first,
              (value) => value..add(element.last),
              ifAbsent: () => [element.last],
            ),
      );

  return manuals
      .getLines()
      .map((element) => element.split(',').map(int.parse).toList())
      .where((pages) => _haveCorrectOrder(pages, pageorder))
      .map((pages) => pages[pages.length ~/ 2])
      .sum;
}

bool _haveCorrectOrder(List<int> pages, Map<int, List<int>> pageorder) {
  final pagesBefore = pages.reversed.fold(<int, Set<int>>{}, (
    previous,
    element,
  ) {
    for (final key in previous.keys) {
      previous[key]!.add(element);
    }
    previous[element] = {};
    return previous;
  });
  for (final page in pages) {
    final before = pagesBefore[page]!;
    final order = (pageorder[page] ?? []).toSet();
    if (before.intersection(order).isNotEmpty) {
      return false;
    }
  }
  return true;
}

int day05star2(Input input) {
  final [ordering, manuals] = _processInput(input);
  final pageorder = ordering
      .getLines()
      .map((element) => element.split('|').map(int.parse))
      .fold(
        <int, List<int>>{},
        (previous, element) =>
            previous..update(
              element.first,
              (value) => value..add(element.last),
              ifAbsent: () => [element.last],
            ),
      );

  return manuals
      .getLines()
      .map((element) => element.split(',').map(int.parse).toList())
      .where((pages) => !_haveCorrectOrder(pages, pageorder))
      .map((pages) {
        final reorderedPages = pages.toList();
        while (!_haveCorrectOrder(reorderedPages, pageorder)) {
          final pagesBefore = reorderedPages.reversed.fold(<int, Set<int>>{}, (
            previous,
            element,
          ) {
            for (final key in previous.keys) {
              previous[key]!.add(element);
            }
            previous[element] = {};
            return previous;
          });
          for (final page in pages) {
            final before = pagesBefore[page]!;
            final order = (pageorder[page] ?? []).toSet();
            final wrongPages = before.intersection(order);
            if (wrongPages.isNotEmpty) {
              for (final wrongPage in wrongPages) {
                final index = reorderedPages.indexOf(page);
                reorderedPages
                  ..remove(wrongPage)
                  ..insert(index, wrongPage);
              }
            }
          }
        }

        return reorderedPages;
      })
      .map((pages) => pages[pages.length ~/ 2])
      .sum;
}
