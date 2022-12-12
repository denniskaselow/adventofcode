extension ToInt on String {
  int toInt({int offset = 0}) {
    if (length > 1) throw Exception('$this needs to be a character');
    final base = compareTo('A') >= 0 && compareTo('Z') <= 0
        ? 'A'.codeUnits.first
        : compareTo('a') >= 0 && compareTo('z') <= 0
            ? 'a'.codeUnits.first
            : (throw Exception('don\'t know what to do with $this'));
    return codeUnits.first - base + offset;
  }
}

extension FirstIndexWhere<T> on Iterable<T> {
  int firstIndexWhere(bool Function(T element) test) {
    int index = 0;
    for (final element in this) {
      if (test(element)) {
        return index;
      }
      index++;
    }
    return -1;
  }
}

extension DebugIterable<T> on Iterable<T> {
  Iterable<T> debug(void Function(T item) debugFunction) sync* {
    for (final item in this) {
      debugFunction(item);
      yield item;
    }
  }

  Iterable<T> debugIndexed(
      void Function(int index, T item) debugFunction) sync* {
    var index = 0;
    for (final item in this) {
      debugFunction(index++, item);
      yield item;
    }
  }
}


enum Direction {
  north(0, -1),
  south(0, 1),
  east(1, 0),
  west(-1, 0);

  final int x;
  final int y;

  const Direction(this.x, this.y);
}