import 'package:crypto/crypto.dart';

import '../utils.dart';

int _processInput(Input input, int count) {
  var index = 0;
  do {
    index++;
  } while (!md5
      .convert('$input$index'.codeUnits)
      .toString()
      .startsWith('0' * count));
  return index;
}

int day04star1(Input input) => _processInput(input, 5);

int day04star2(Input input) => _processInput(input, 6);
