import 'package:hive/hive.dart';
part 'cartbox.g.dart';

@HiveType(typeId: 0)
class CartBox {
  @HiveField(0)
  int quntity;
  @HiveField(1)
  int id;
  @HiveField(2)
  String name;
  @HiveField(3)
  String price;
  @HiveField(4)
  String urlImage;
  @HiveField(5)
  bool sample;
  CartBox(
      this.quntity, this.id, this.name, this.price, this.urlImage, this.sample);
}
