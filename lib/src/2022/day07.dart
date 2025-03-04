import 'package:collection/collection.dart';

import '../utils.dart';

Iterable<String> _processInput(Input input) => input.getLines();

int day7star1(Input input) {
  final root = getRoot(input);

  return root
      .allDirectories()
      .map((e) => e.size)
      .where((element) => element < 100000)
      .fold(0, (previousValue, element) => previousValue + element);
}

int day7star2(Input input) {
  final root = getRoot(input);
  final required = 30000000 - (70000000 - root.size);

  return root
      .allDirectories()
      .map((e) => e.size)
      .sorted((a, b) => a - b)
      .firstWhere((element) => element > required);
}

Directory getRoot(Input input) {
  final root = Directory(null);
  var currentDir = root;
  for (final line in _processInput(input)) {
    if (line == r'$ cd /') {
      currentDir = root;
    } else if (line == r'$ cd ..') {
      currentDir = currentDir.parent!;
    } else if (line.startsWith(r'$ cd ')) {
      final dir = line.substring(5);
      currentDir = currentDir.directories[dir]!;
    } else if (line.startsWith(r'$ ls')) {
      continue;
    } else {
      final content = line.split(' ');
      if (content[0] == 'dir') {
        currentDir.directories[content[1]] = Directory(currentDir);
      } else {
        currentDir.files[content[1]] = File(int.parse(content[0]));
      }
    }
  }
  return root;
}

class Directory {
  Directory(this.parent);

  Map<String, File> files = {};
  Map<String, Directory> directories = {};
  Directory? parent;

  int get size =>
      directories.values.fold(0, (value, element) => value + element.size) +
      files.values
          .fold(0, (previousValue, element) => previousValue + element.size);

  Iterable<Directory> allDirectories() => directories.values
      .followedBy(directories.values.map((e) => e.allDirectories()).flattened);
}

class File {
  File(this.size);
  int size;
}
