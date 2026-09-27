// lib/models/product.dart

class Product {
  final String id;
  final String title;
  final String price;
  final double rating;
  final String imageUrl;
  final String category;
  final String description;
  final String? badge;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.rating,
    required this.imageUrl,
    this.category = 'General',
    this.description = 'Prenda de excelente calidad confeccionada con los mejores materiales.',
    this.badge,
  });
}