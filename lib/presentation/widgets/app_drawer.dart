import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hostel_complain_management_app/business_logic/auth/auth_event.dart';
import 'package:hostel_complain_management_app/business_logic/auth/auth_state.dart';
import 'package:hostel_complain_management_app/presentation/screens/add_complain_screen.dart';
import 'package:hostel_complain_management_app/presentation/screens/auth_screen.dart';
import 'package:hostel_complain_management_app/presentation/screens/complain_screen.dart';
import 'package:hostel_complain_management_app/presentation/screens/feed_screen.dart';
import 'package:hostel_complain_management_app/presentation/utils/snackbars.dart';

import '../../business_logic/auth/auth_bloc.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LogOutFailureState) {
          showErrorSnackbar(state.message, context);
        } else if (state is LogOutSuccessState) {
          Navigator.pushReplacementNamed(context, AuthScreen.id);
        }
      },
      child: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.purple),
              child: Text('Student Name'),
            ),
            ListTile(
              leading: const Icon(Icons.list),
              title: const Text('Feed'),
              onTap: () {
                // context.read<HomeBloc>().add(const HomeNavEvent(index: 0));
                Navigator.pushReplacementNamed(context, FeedScreen.id);
              },
            ),
            ListTile(
              leading: const Icon(Icons.list_alt),
              title: const Text('Your Complains'),
              onTap: () {
                // context.read<HomeBloc>().add(const HomeNavEvent(index: 1));
                Navigator.pushReplacementNamed(context, ComplainScreen.id);
              },
            ),
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text('Add Complains'),
              onTap: () {
                // context.read<HomeBloc>().add(const HomeNavEvent(index: 2));
                Navigator.pushReplacementNamed(context, AddComplainScreen.id);
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Log out'),
              onTap: () {
                context.read<AuthBloc>().add(const LogOutEvent());
              },
            ),
          ],
        ),
      ),
    );
  }
}
