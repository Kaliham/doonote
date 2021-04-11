import 'package:hive/hive.dart';

part 'sketch.g.dart';

const sketchBoxName = "sketchs";

@HiveType(typeId: 0)
class Sketch extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String title;
  @HiveField(2)
  int order;
}
