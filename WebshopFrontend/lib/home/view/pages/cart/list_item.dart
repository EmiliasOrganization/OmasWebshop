

import 'package:hive/hive.dart';


part 'list_item.g.dart';

//adapter

@HiveType(typeId: 1)
class ListItem {


  ListItem({required this.id, required this.name, required this.description, required this.price});


  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  dynamic description;

  @HiveField(3)
  dynamic price;
}

