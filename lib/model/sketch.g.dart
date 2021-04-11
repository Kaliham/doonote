// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sketch.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SketchAdapter extends TypeAdapter<Sketch> {
  @override
  final int typeId = 0;

  @override
  Sketch read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Sketch()
      ..id = fields[0] as String
      ..title = fields[1] as String
      ..order = fields[2] as int;
  }

  @override
  void write(BinaryWriter writer, Sketch obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.order);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SketchAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
