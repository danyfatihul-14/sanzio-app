// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductAdapter extends TypeAdapter<Product> {
  @override
  final int typeId = 0;

  @override
  Product read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Product(
      id: fields[0] as int,
      categoryId: fields[1] as int,
      title: fields[2] as String,
      imageUrl: fields[3] as String,
      subtitle: fields[4] as String,
      description: fields[5] as String,
      gender: fields[6] as String,
      price: fields[7] as int,
      rating: fields[8] as double,
      isAvailable: fields[9] as bool,
      productDetails: (fields[10] as List).cast<DetailProduct>(),
    );
  }

  @override
  void write(BinaryWriter writer, Product obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.categoryId)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.imageUrl)
      ..writeByte(4)
      ..write(obj.subtitle)
      ..writeByte(5)
      ..write(obj.description)
      ..writeByte(6)
      ..write(obj.gender)
      ..writeByte(7)
      ..write(obj.price)
      ..writeByte(8)
      ..write(obj.rating)
      ..writeByte(9)
      ..write(obj.isAvailable)
      ..writeByte(10)
      ..write(obj.productDetails);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DetailProductAdapter extends TypeAdapter<DetailProduct> {
  @override
  final int typeId = 1;

  @override
  DetailProduct read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DetailProduct(
      id: fields[0] as int,
      productId: fields[1] as int,
      size: fields[2] as String,
      stock: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, DetailProduct obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.productId)
      ..writeByte(2)
      ..write(obj.size)
      ..writeByte(3)
      ..write(obj.stock);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DetailProductAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
