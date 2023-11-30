import 'package:more/more.dart';

import '../utils.dart';

int day20star1(String input) => _decrypt(input, 1, 1);
int day20star2(String input) => _decrypt(input, 811589153, 10);

int _decrypt(String input, int key, int repeatMix) {
  final numbers = _processInput(input);
  final length = numbers.length;
  final mixed = mix(numbers.map((e) => e * key).indexed().toList(), repeatMix);
  final indexOfZero = mixed.indexWhere((element) => element.value == 0);
  return mixed[(indexOfZero + 1000) % length].value +
      mixed[(indexOfZero + 2000) % length].value +
      mixed[(indexOfZero + 3000) % length].value;
}

List<Indexed<int>> mix(List<Indexed<int>> numbers, int repeatMix) {
  final length = numbers.length;
  final origNumbers = numbers.toList();
  for (var i = 0; i < repeatMix; i++) {
    for (final number in origNumbers) {
      final index = numbers.indexOf(number);
      final newIndex = (index + number.value) % (length - 1);
      numbers.insert(newIndex, numbers.removeAt(index));
    }
  }
  return numbers;
}

List<int> _processInput(String input) => input.lines.map(int.parse).toList();
