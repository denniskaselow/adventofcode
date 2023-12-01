import 'package:crypto/crypto.dart';

int _processInput(String input, int count) {
  var index = 0;
  do {
    index++;
  } while (!md5
      .convert('$input$index'.codeUnits)
      .toString()
      .startsWith('0' * count));
  return index;
}

int day04star1(String input) => _processInput(input, 5);

int day04star2(String input) => _processInput(input, 6);
