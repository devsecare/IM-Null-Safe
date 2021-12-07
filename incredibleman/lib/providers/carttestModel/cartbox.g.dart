// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cartbox.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CartBoxAdapter extends TypeAdapter<CartBox> {
  @override
  final int typeId = 0;

  @override
  CartBox read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CartBox(
      fields[0] as int,
      fields[1] as int,
      fields[2] as String,
      fields[3] as String,
      fields[4] as String,
      fields[5] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, CartBox obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.quntity)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.price)
      ..writeByte(4)
      ..write(obj.urlImage)
      ..writeByte(5)
      ..write(obj.sample);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartBoxAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
