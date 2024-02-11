import 'package:get/get.dart';

class ProductData {
  int id;
  String title;
  double price;
  String description;
  String category;
  String image;
  Rating rating;
  bool fav;

  ProductData(
      {required this.id,
      required this.title,
      required this.price,
      required this.description,
      required this.category,
      required this.image,
      required this.rating,
      this.fav = false});

  factory ProductData.fromJson(Map<String, dynamic> json) {
    return ProductData(
      id: json['id'],
      title: json['title'],
      price: json['price'].toDouble(),
      description: json['description'],
      category: json['category'],
      image: json['image'],
      fav: false,
      rating: Rating(
        rate: json['rating']['rate'].toDouble(),
        count: json['rating']['count'],
      ),
    );
  }

  static Category _parseCategory(String categoryString) {
    switch (categoryString.toLowerCase()) {
      case 'electronics':
        return Category.ELECTRONICS;
      case 'jewelery':
        return Category.JEWELERY;
      case 'men\'s clothing':
        return Category.MEN_S_CLOTHING;
      case 'women\'s clothing':
        return Category.WOMEN_S_CLOTHING;
      default:
        throw ArgumentError('Invalid category: $categoryString');
    }
  }
}

enum Category { ELECTRONICS, JEWELERY, MEN_S_CLOTHING, WOMEN_S_CLOTHING }

class Rating {
  double rate;
  int count;

  Rating({
    required this.rate,
    required this.count,
  });
}
