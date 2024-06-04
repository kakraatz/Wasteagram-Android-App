import 'package:flutter/material.dart';
import '../models/food_waste_post.dart';
import '../widgets/post_details.dart';
import '../widgets/back_button.dart' as backButton;

class DetailScreen extends StatelessWidget {
  final FoodWastePost foodWastePost;
  final dynamic postID;
  const DetailScreen({Key? key, required this.postID, required this.foodWastePost}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const backButton.BackButton(),
          title: const Text('Wasteagram'),
          centerTitle: true,
        ),
        body: PostDetails(postID: postID, foodWastePost: foodWastePost));
  }
}
