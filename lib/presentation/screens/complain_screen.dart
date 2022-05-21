import 'package:flutter/material.dart';

import '../widgets/app_drawer.dart';

class ComplainScreen extends StatefulWidget {
  const ComplainScreen({Key? key}) : super(key: key);
  static const String id = 'complain';

  @override
  _ComplainScreenState createState() => _ComplainScreenState();
}

class _ComplainScreenState extends State<ComplainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complains'),
      ),
      body: const Center(
        child: Text('Complains'),
      ),
      drawer: const AppDrawer(),
    );
  }
}
