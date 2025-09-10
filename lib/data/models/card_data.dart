abstract class CardData {
  final String title;
  final List<String> imageUrl;
  final String description;
  final double rating;
  final double price;

  CardData({
    required this.title,
    required this.imageUrl,
    required this.description,
    required this.rating,
    required this.price,
  });
}
