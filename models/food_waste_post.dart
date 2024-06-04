class FoodWastePost {
  final DateTime date;
  final String imageURL;
  final num quantity;
  final double latitude;
  final double longitude;

  FoodWastePost(
    {required this.date,
    required this.imageURL,
    required this.quantity,
    required this.latitude,
    required this.longitude
    });

  factory FoodWastePost.getDetails(Map<String, dynamic> post) {
    return FoodWastePost(
      date: post['date'].toDate(),
      imageURL: post['imageURL'],
      quantity: post['quantity'],
      latitude: post['latitude'],
      longitude: post['longitude']
    );
  }
}
