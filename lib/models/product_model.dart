class ProductModel {
  final int id;
  final String title;
  final double price;
  final double rating;
  final String thumbnail;
  final String category;
  final String description;
  final String availabilityStatus;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.rating,
    required this.thumbnail,
    required this.category,
    required this.description,
    required this.availabilityStatus,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title'],
      price: json['price'].toDouble(),
      rating: json['rating'].toDouble(),
      thumbnail: json['thumbnail'],
      category: json['category'],
      description: json['description'],
      availabilityStatus: json['availabilityStatus'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'rating': rating,
      'thumbnail': thumbnail,
      'category': category,
      'description': description,
      'availabilityStatus': availabilityStatus,
    };
  }
}
