import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hostel_complain_management_app/business_logic/auth/auth_bloc.dart';
import 'package:hostel_complain_management_app/business_logic/auth/auth_event.dart';
import 'package:hostel_complain_management_app/business_logic/auth/auth_state.dart';
import 'package:hostel_complain_management_app/presentation/screens/auth_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const String id = 'home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LogOutSuccessState) {
          Navigator.pushReplacementNamed(context, AuthScreen.id);
        } else if (state is LogOutFailureState) {
          print(state.message);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
        ),
        body: const Center(
          child: Text('home'),
        ),
        drawer: _drawer(),
      ),
    );
  }

  Widget _drawer() {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.purple),
            child: Text('Student Name'),
          ),
          ListTile(
            leading: const Icon(Icons.add),
            title: const Text('Feed'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.add),
            title: const Text('Your Complains'),
            onTap: () {},
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
    );
  }
}
