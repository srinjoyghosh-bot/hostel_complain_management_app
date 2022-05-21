import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hostel_complain_management_app/presentation/widgets/app_drawer.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);
  static const String id = 'feed';
  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feed'),
      ),
      body: const Center(
        child: Text('Feed'),
      ),
      drawer: const AppDrawer(),
    );
  }
}
