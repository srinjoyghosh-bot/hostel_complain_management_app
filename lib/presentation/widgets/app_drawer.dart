import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hostel_complain_management_app/business_logic/auth/auth_event.dart';
import 'package:hostel_complain_management_app/business_logic/auth/auth_state.dart';
import 'package:hostel_complain_management_app/data/data_providers/local_storage_service.dart';
import 'package:hostel_complain_management_app/presentation/screens/add_complain_screen.dart';
import 'package:hostel_complain_management_app/presentation/screens/auth_screen.dart';
import 'package:hostel_complain_management_app/presentation/screens/complain_screen.dart';
import 'package:hostel_complain_management_app/presentation/screens/feed_screen.dart';
import 'package:hostel_complain_management_app/presentation/utils/snackbars.dart';

import '../../business_logic/auth/auth_bloc.dart';

class AppDrawer extends StatelessWidget {
  AppDrawer({Key? key}) : super(key: key);

  final LocalStorageService _service = LocalStorageService.instance;

  @override
  Widget build(BuildContext context) {
    String studentName = _service.studentName;
    String hostelName = _service.hostelName;
    String secretary = _service.secretaryDepartment;
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
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.purple),
              child: Column(
                children: [
                  const Spacer(),
                  Text(
                    studentName,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                    softWrap: true,
                  ),
                  Text(
                    hostelName,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                    softWrap: true,
                  ),
                  if (secretary != 'None')
                    Text(
                      '$secretary Secretary',
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                      softWrap: true,
                    ),
                  const Spacer(),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.list,
                size: 30,
              ),
              title: const Text(
                'Feed',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.pushReplacementNamed(context, FeedScreen.id);
              },
            ),
            if (secretary == 'None')
              ListTile(
                leading: const Icon(
                  Icons.list_alt,
                  size: 30,
                ),
                title: const Text(
                  'Your Complains',
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () {
                  Navigator.pushReplacementNamed(context, ComplainScreen.id);
                },
              ),
            ListTile(
              leading: const Icon(
                Icons.add,
                size: 30,
              ),
              title: const Text(
                'Add Complains',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.pushReplacementNamed(context, AddComplainScreen.id);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.logout,
                size: 30,
              ),
              title: const Text(
                'Log out',
                style: TextStyle(fontSize: 20),
              ),
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
