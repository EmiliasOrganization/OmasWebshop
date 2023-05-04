
class ProductSummary {
  String name;
  String? description;
  String? category;
  String id;
  String? subCategory;

  // double price;

  ProductSummary({required this.name,  this.description, required this.id, this.category, this.subCategory});

  factory ProductSummary.fromJson(Map<String, dynamic> json) {
    return ProductSummary(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      category: json['category'],

    );
  }
}