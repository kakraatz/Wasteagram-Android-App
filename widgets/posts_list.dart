import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'new_post_button.dart';
import '../models/food_waste_post.dart';
import '../screens/detail_screen.dart';

class PostsList extends StatefulWidget {
  const PostsList({Key? key}) : super(key: key);
  @override
  PostsListState createState() => PostsListState();
}

class PostsListState extends State<PostsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: const Icon(Icons.recycling),
          title: const Text('Wasteagram'),
          actions: [
            const Padding(
                padding: EdgeInsets.fromLTRB(0, 22, 5, 0),
                child: Text('Total Waste:')),
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 22, 15, 0),
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('posts')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      num totalItems = 0;
                      if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                        for (var post in snapshot.data!.docs) {
                          totalItems += post['quantity'];
                        }
                      }
                      return Text(totalItems.toString());
                    }))
          ]),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('posts')
              .orderBy('date', descending: true)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var post = snapshot.data!.docs[index];
                    //totalItems += post['quantity'];
                    return Semantics(
                        enabled: true,
                        label:
                            'Wasteagram post that displays date of post and number of food waste items.',
                        onLongPressHint: 'Tap post to view its details.',
                        child: Card(
                            shadowColor: Colors.green,
                            elevation: 5,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            child: ListTile(
                                leading: SizedBox(
                                    height: 40,
                                    width: 40,
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: Image.network(post['imageURL'],
                                            fit: BoxFit.cover))),
                                title: Text(DateFormat.yMMMMEEEEd()
                                    .format(post['date'].toDate())),
                                trailing: Text(post['quantity'].toString()),
                                shape: const RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 0.2, color: Colors.green)),
                                onTap: () => viewPost(post))));
                  });
            } else {
              return Center(
                  child: Semantics(
                      label:
                          'Displayed when post list is empty or when loading data.',
                      child: const CircularProgressIndicator()));
            }
          }),
      floatingActionButton: NewPostButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Future<dynamic> viewPost(QueryDocumentSnapshot post) {
    return Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DetailScreen(postID: post.id, 
                foodWastePost: FoodWastePost.getDetails(queryDetails(post)))));
  }

  Map<String, dynamic> queryDetails(QueryDocumentSnapshot post) {
    return {
      'date': post['date'],
      'imageURL': post['imageURL'],
      'quantity': post['quantity'],
      'latitude': post['latitude'],
      'longitude': post['longitude']
    };
  }
}
