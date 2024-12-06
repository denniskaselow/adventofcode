import 'dart:convert';

extension ToInt on String {
  int toInt({int offset = 0}) {
    if (length > 1) {
      throw Exception('$this needs to be a character');
    }
    final base =
        compareTo('A') >= 0 && compareTo('Z') <= 0
            ? 'A'.codeUnits.first
            : compareTo('a') >= 0 && compareTo('z') <= 0
            ? 'a'.codeUnits.first
            : (throw Exception("don't know what to do with $this"));
    return codeUnits.first - base + offset;
  }
}

extension type const Input(String _) implements String {
  List<Input> getLines() => const LineSplitter().convert(this).cast<Input>();
  List<Input> getInputGroups() => split(RegExp(r'(\r?\n){2}')).cast<Input>();
}

extension FirstIndexWhere<T> on Iterable<T> {
  int firstIndexWhere(bool Function(T element) test) {
    var index = 0;
    for (final element in this) {
      if (test(element)) {
        return index;
      }
      index++;
    }
    return -1;
  }
}

extension ReduceUntil<E> on Iterable<E> {
  int reduceUntil(
    E Function(E value, E element) combine,
    bool Function(E value) test,
  ) {
    final iterator = this.iterator;
    if (!iterator.moveNext()) {
      throw Exception('no element');
    }
    var value = iterator.current;
    var index = 0;
    while (iterator.moveNext()) {
      value = combine(value, iterator.current);
      index++;
      if (test(value)) {
        return index;
      }
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
    void Function(int index, T item) debugFunction,
  ) sync* {
    var index = 0;
    for (final item in this) {
      debugFunction(index++, item);
      yield item;
    }
  }
}

extension PrimeFactors on int {
  static final _primes = <int>[2, 3];

  List<int> getPrimeFactors() {
    final result = <int>[];
    var current = this;
    var primeIndex = 0;
    while (current != 1) {
      if (primeIndex >= _primes.length) {
        _createMissingPrimes(primeIndex);
      }
      final currentPrime = _primes[primeIndex];
      if (current % currentPrime == 0) {
        result.add(currentPrime);
        current = current ~/ currentPrime;
      } else {
        primeIndex++;
      }
    }
    return result;
  }

  void _createMissingPrimes(int primeIndex) {
    var next = _primes.last;
    do {
      next += 2;
      var isPrime = true;
      for (final prime in _primes) {
        if (next % prime == 0) {
          isPrime = false;
          break;
        }
      }
      if (isPrime) {
        _primes.add(next);
      }
    } while (primeIndex >= _primes.length);
  }
}

int sum(int a, int b) => a + b;

enum Direction {
  n(0, -1),
  ne(1, -1),
  e(1, 0),
  se(1, 1),
  s(0, 1),
  sw(-1, 1),
  w(-1, 0),
  nw(-1, -1);

  const Direction(this.x, this.y);

  final int x;
  final int y;
  static const List<Direction> plus = [n, e, s, w];

  Direction get opposite => switch (this) {
    n => s,
    e => w,
    s => n,
    w => e,
    nw => se,
    ne => sw,
    se => nw,
    sw => ne,
  };
  String get orientation => switch (this) {
    n || s => '|',
    e || w => '-',
    nw || se => r'\',
    ne || sw => '/',
  };
  Direction get nextClockwise => switch (this) {
    n => e,
    e => s,
    s => w,
    w => n,
    _ => throw 'unsupported',
  };
}
