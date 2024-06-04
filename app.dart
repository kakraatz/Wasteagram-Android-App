import 'package:flutter/material.dart';
import '../screens/list_screen.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class App extends StatelessWidget {

  const App({Key? key}) : super(key: key);
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Wasteagram',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        navigatorObservers: <NavigatorObserver>[observer],
        home: Scaffold(body: ListScreen(observer: observer, analytics: analytics)));
  }
}
