import 'package:decimal/decimal.dart';
import 'package:hive/hive.dart';

part 'list_item.g.dart';

//adapter

@HiveType(typeId: 1)
class ListItem {
  ListItem({required this.id, required this.name});
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;


}
