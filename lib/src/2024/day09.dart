import '../utils.dart';

List<({int id, int length, int space})> _processInput(Input input) =>
    RegExp(r'(\d)(\d)')
        .allMatches('0${input.getLines().first}')
        .indexed
        .map(
          (e) => (
            id: e.$1,
            length: int.parse(e.$2[2]!),
            space: int.parse(e.$2[1]!),
          ),
        )
        .toList();

int day09star1(Input input) {
  final files = _processInput(input);
  var currentFileId = 0;
  var fileToMoveId = files.length - 1;
  var result = 0;
  var pos = 0;
  while (currentFileId <= fileToMoveId) {
    var currentPos = pos;
    if (files[currentFileId].space == files[fileToMoveId].length) {
      for (var j = pos; j < pos + files[fileToMoveId].length; j++) {
        result += files[fileToMoveId].id * j;
        currentPos++;
      }
      pos = currentPos;
      for (var j = pos; j < pos + files[currentFileId].length; j++) {
        result += files[currentFileId].id * j;
        currentPos++;
      }
      pos = currentPos;

      fileToMoveId--;
      currentFileId++;
    } else if (files[currentFileId].space > files[fileToMoveId].length) {
      for (var j = pos; j < pos + files[fileToMoveId].length; j++) {
        result += files[fileToMoveId].id * j;
        currentPos++;
      }
      pos = currentPos;

      files[currentFileId] = (
        id: files[currentFileId].id,
        length: files[currentFileId].length,
        space: files[currentFileId].space - files[fileToMoveId].length,
      );
      fileToMoveId--;
    } else if (files[currentFileId].space < files[fileToMoveId].length) {
      for (var j = pos; j < pos + files[currentFileId].space; j++) {
        result += files[fileToMoveId].id * j;
        currentPos++;
      }
      pos = currentPos;

      files[fileToMoveId] = (
        id: files[fileToMoveId].id,
        length: files[fileToMoveId].length - files[currentFileId].space,
        space: files[fileToMoveId].space,
      );

      for (var j = pos; j < pos + files[currentFileId].length; j++) {
        result += files[currentFileId].id * j;
        currentPos++;
      }
      pos = currentPos;
      currentFileId++;
    }
  }
  return result;
}

int day09star2(Input input) {
  final files = _processInput(input);
  final filesWithPos = <({int id, int pos, int length, int space})>[];

  var pos = 0;
  for (final file in files) {
    filesWithPos.add((
      id: file.id,
      pos: pos + file.space,
      length: file.length,
      space: file.space,
    ));
    pos += file.length + file.space;
  }

  for (var fileToMoveId = files.length - 1; fileToMoveId >= 0; fileToMoveId--) {
    var currentFileId = 0;
    while (currentFileId <= fileToMoveId) {
      final fileToMove = filesWithPos[fileToMoveId];
      final currentFile = filesWithPos[currentFileId];
      if (currentFile.space >= fileToMove.length) {
        filesWithPos[currentFileId] = (
          id: currentFile.id,
          pos: currentFile.pos,
          length: currentFile.length,
          space: currentFile.space - fileToMove.length,
        );
        filesWithPos[fileToMoveId] = (
          id: fileToMove.id,
          pos: currentFile.pos - currentFile.space,
          length: fileToMove.length,
          space: 0,
        );
        break;
      }
      currentFileId++;
    }
  }

  var result = 0;
  for (final file in filesWithPos) {
    for (var i = file.pos; i < file.pos + file.length; i++) {
      result += i * file.id;
    }
  }

  return result;
}
