extension Sum on Iterable<int> {
  int sum() => reduce((value, element) => value + element);
}
