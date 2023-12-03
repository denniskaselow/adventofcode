import 'package:collection/collection.dart';

import '../utils.dart';

String day25star1(String input) => _processInput(input).sum.toSnafu();

int day25star2(String input) => _processInput(input).length;

extension Snafu on int {
  String toSnafu() => toRadixString(5)
      .split('')
      .reversed
      .fold(
        <X>[],
        (previousValue, element) {
          final carry = previousValue.isNotEmpty && previousValue.last.carry;
          final X value;
          if (element == '4') {
            value = X(carry ? '0' : '-', carry: true);
          } else if (element == '3') {
            value = X(carry ? '-' : '=', carry: true);
          } else if (element == '2' && carry) {
            value = X('=', carry: true);
          } else {
            value = X(
              carry ? '${(int.parse(element) + 1) % 5}' : element,
              carry: carry && element == '4',
            );
          }
          return previousValue..add(value);
        },
      )
      .map((e) => e.value)
      .toList()
      .reversed
      .join();
}

List<int> _processInput(String input) => input
    .getLines()
    .map(
      (e) => e
          .split('')
          .reversed
          .fold(<X>[], (previousValue, element) {
            final carry = previousValue.isNotEmpty && previousValue.last.carry;
            final X value;
            if (element == '-') {
              value = X(carry ? '3' : '4', carry: true);
            } else if (element == '=') {
              value = X(carry ? '2' : '3', carry: true);
            } else {
              value = X(
                carry ? '${(int.parse(element) - 1) % 5}' : element,
                carry: carry && element == '0',
              );
            }
            return previousValue..add(value);
          })
          .reversed
          .map((e) => e.value)
          .join(),
    )
    .map((e) => int.parse(e, radix: 5))
    .toList();

class X {
  X(this.value, {this.carry = false});
  String value;
  bool carry;
}
