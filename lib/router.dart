import 'package:flutter/material.dart';
import 'package:hostel_complain_management_app/presentation/screens/add_complain_screen.dart';
import 'package:hostel_complain_management_app/presentation/screens/auth_screen.dart';
import 'package:hostel_complain_management_app/presentation/screens/complain_screen.dart';
import 'package:hostel_complain_management_app/presentation/screens/feed_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case FeedScreen.id:
        return MaterialPageRoute(builder: (_) => const FeedScreen());
      case ComplainScreen.id:
        return MaterialPageRoute(builder: (_) => const ComplainScreen());
      case AddComplainScreen.id:
        return MaterialPageRoute(builder: (_) => const AddComplainScreen());
      case AuthScreen.id:
        return MaterialPageRoute(builder: (_) => const AuthScreen());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route for ${settings.name}'),
                  ),
                ));
    }
  }
}
