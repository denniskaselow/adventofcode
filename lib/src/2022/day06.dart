int day6star1(String input) => getIndex(input, 4);
int day6star2(String input) => getIndex(input, 14);

int getIndex(String input, int distinct) {
  for (var i = distinct; i < input.length; i++) {
    if (input.substring(i - distinct, i).codeUnits.toSet().length == distinct) {
      return i;
    }
  }
  return -1;
}
