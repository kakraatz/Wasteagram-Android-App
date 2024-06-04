import 'package:flutter/material.dart';
import '../widgets/posts_list.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ListScreen extends StatefulWidget {
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;
  const ListScreen({Key? key, required this.analytics, required this.observer})
      : super(key: key);
  @override
  ListScreenState createState() => ListScreenState();
}

class ListScreenState extends State<ListScreen> {
  Future<void> _sendAnalyticsEvent() async {
    await widget.analytics.logEvent(name: 'app_startup');
  }

  Future<void> _deleteDatabaseEntries() async {
    try {
      final QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('posts').get();

      for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
        await documentSnapshot.reference.delete();
      }

      print('All documents in the "posts" collection have been deleted.');
    } catch (e) {
      print('Error deleting documents: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    _sendAnalyticsEvent();
    _deleteDatabaseEntries();
    return const PostsList();
  }
}
