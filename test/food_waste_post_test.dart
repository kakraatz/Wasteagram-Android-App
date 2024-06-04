import 'package:test/test.dart';
import 'package:wasteagram/models/food_waste_post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  group('FoodWastePost unit testing', () {
    test('Post created from Map should have appropriate property values', () {
      final date = Timestamp.now();
      const imageURL = 'Fake';
      const quantity = 1;
      const latitude = 1.0;
      const longitude = 2.0;

      final food_waste_post = FoodWastePost.getDetails({
        'date': date,
        'imageURL': imageURL,
        'quantity': quantity,
        'latitude': latitude,
        'longitude': longitude
      });

      expect(food_waste_post.date, date.toDate());
      expect(food_waste_post.imageURL, imageURL);
      expect(food_waste_post.quantity, quantity);
      expect(food_waste_post.latitude, latitude);
      expect(food_waste_post.longitude, longitude);
    });

    test('Post created from Map should have appropriate property values', () {
      final date = Timestamp.fromDate(DateTime.parse('2023-03-24'));
      const imageURL = 'Fake';
      const quantity = 0;
      const latitude = 5.0;
      const longitude = 5.0;

      final food_waste_post = FoodWastePost.getDetails({
        'date': date,
        'imageURL': imageURL,
        'quantity': quantity,
        'latitude': latitude,
        'longitude': longitude
      });

      expect(food_waste_post.date, date.toDate());
      expect(food_waste_post.imageURL, imageURL);
      expect(food_waste_post.quantity, quantity);
      expect(food_waste_post.latitude, latitude);
      expect(food_waste_post.longitude, longitude);
    });

    test('Post created from Map should have appropriate property values', () {
      final date = Timestamp.now();
      const imageURL = 'Fake';
      const quantity = 100;
      const latitude = 54.022;
      const longitude = -22.507;

      final food_waste_post = FoodWastePost.getDetails({
        'date': date,
        'imageURL': imageURL,
        'quantity': quantity,
        'latitude': latitude,
        'longitude': longitude
      });

      expect(food_waste_post.date, date.toDate());
      expect(food_waste_post.imageURL, imageURL);
      expect(food_waste_post.quantity, quantity);
      expect(food_waste_post.latitude, latitude);
      expect(food_waste_post.longitude, longitude);
    });
  });
}
