import 'dart:convert';
import 'package:amazon_clone_with_nodejs/Features/Models/rating.dart';

class Product {
  final String name;

  final String description;

  final int quantity;

  final List<String> images;

  final String category;

  final int price;

  final String? id;

  final String? userId;

  final List<Rating>? ratings;

  Product({
    required this.name,
    required this.description,
    required this.quantity,
    required this.images,
    required this.category,
    required this.price,
    this.id,
    this.userId,
    this.ratings,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'quantity': quantity,
      'images': images,
      'category': category,
      'price': price,
      '_id': id,
      'userId': userId,
      'ratings': ratings,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      name: map['name'] as String,
      description: map['description'] as String,
      quantity: map['quantity'],
      images: (map['images'] as List<dynamic>).cast<String>(),
      category: map['category'] as String,
      price: map['price'],
      id: map['_id'],
      userId: map['userId'],
      ratings: map['ratings'] != null
          ? List<Rating>.from(
              map['ratings']?.map(
                (x) => Rating.fromMap(x),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) => Product.fromMap(json.decode(source) as Map<String, dynamic>);
}
