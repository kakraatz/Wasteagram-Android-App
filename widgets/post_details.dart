import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wasteagram/widgets/posts_list.dart';
import '../models/food_waste_post.dart';

class PostDetails extends StatelessWidget {
  final FoodWastePost foodWastePost;
  final dynamic postID;
  const PostDetails({Key? key, required this.postID, required this.foodWastePost}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Center(
                child: Semantics(
                    label: 'Displays the date of this post.',
                    enabled: true,
                    child: Text(
                        DateFormat.yMMMMEEEEd().format(foodWastePost.date))))),
        Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 25),
            child: Center(
                child: Semantics(
                    label: 'Displays the image of this post.',
                    enabled: true,
                    child: SizedBox(
                        height: 500,
                        width: 500,
                        child: Image.network(foodWastePost.imageURL))))),
        Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Center(
                child: Semantics(
                    label: 'Displays the count of food waste items.',
                    enabled: true,
                    child: Text(
                        'Waste Items: ${foodWastePost.quantity.toString()}')))),
        Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Center(
              child: Semantics(
                  label: 'Displays the latitude and longitude of this post.',
                  enabled: true,
                  child: Text(
                      'Location: (${foodWastePost.latitude}, ${foodWastePost.longitude})')),
            )),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Delete Post?'),
                      content:
                          Text('Are you sure you want to delete this post?'),
                      actions: <Widget>[
                        TextButton(
                          child: Text('Cancel'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: Text('Delete'),
                          onPressed: () {
                            deleteDocument(postID); // Delete the document
                            Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PostsList()));
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: Icon(Icons.delete_forever, size: 40),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> deleteDocument(dynamic postID) async {
    try {
      await FirebaseFirestore.instance
          .collection('posts')
          .doc(postID)
          .delete();
    } catch (e) {
      print('Error deleting document: $e');
    }
  }
}
