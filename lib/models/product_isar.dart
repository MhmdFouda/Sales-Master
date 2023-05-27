import 'package:isar/isar.dart';

part 'product_isar.g.dart';

@collection
class Product {
  Id id = Isar.autoIncrement; // you can also use id = null to auto increment

  late String name;

  late int count;

  late double price;

  @Index()
  List<String> get nametWords => name.split(' ');
}
