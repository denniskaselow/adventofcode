int calculate(String input) {
  return input
      .split('\n\n')
      .map((e) => e.split('\n'))
      .map((e) => e.map(int.parse).reduce(_sum))
      .fold(
          0,
          (previousValue, element) =>
              previousValue > element ? previousValue : element);
}

int _sum(previousValue, element) => previousValue + element;

int calculate2(String input) {
  final caloriesPerElf = input
      .split('\n\n')
      .map((e) => e.split('\n'))
      .map((e) => e.map(int.parse).fold(0, _sum)).toList();
  caloriesPerElf.sort((a, b) => b - a);
  return caloriesPerElf.take(3).fold(0, _sum);
}
