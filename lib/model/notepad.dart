import 'package:hive/hive.dart';

part 'notepad.g.dart';

const notepadBoxName = "notepad";
const notepadIdsBoxName = "notepadIds";

@HiveType(typeId: 1)
class Notepad extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String title;
  @HiveField(2)
  int order;
}
