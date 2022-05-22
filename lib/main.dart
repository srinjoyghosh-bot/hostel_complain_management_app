import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hostel_complain_management_app/business_logic/add_complain/add_complain_bloc.dart';
import 'package:hostel_complain_management_app/business_logic/auth/auth_bloc.dart';
import 'package:hostel_complain_management_app/business_logic/complains/complains_bloc.dart';
import 'package:hostel_complain_management_app/business_logic/complains/complains_event.dart';
import 'package:hostel_complain_management_app/business_logic/feed/feed_bloc.dart';
import 'package:hostel_complain_management_app/business_logic/feed/feed_event.dart';
import 'package:hostel_complain_management_app/data/data_providers/local_storage_service.dart';
import 'package:hostel_complain_management_app/data/enums.dart';
import 'package:hostel_complain_management_app/data/repositories/add_complain_repository.dart';
import 'package:hostel_complain_management_app/data/repositories/complains_repository.dart';
import 'package:hostel_complain_management_app/data/repositories/feed_repository.dart';
import 'package:hostel_complain_management_app/presentation/screens/auth_screen.dart';
import 'package:hostel_complain_management_app/presentation/screens/feed_screen.dart';
import 'package:hostel_complain_management_app/router.dart';

import 'data/repositories/auth_repository.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await LocalStorageService.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthBloc(repo: AuthRepository())),
        BlocProvider(
            create: (_) => AddComplainBloc(repo: AddComplainRepository())),
        BlocProvider(
            create: (_) => FeedBloc(repo: FeedRepository())
              ..add(const FeedFetchingEvent(type: ComplainType.none))),
        BlocProvider(
            create: (_) => ComplainsBloc(repo: ComplainsRepository())
              ..add(const ComplainsFetchingEvent())),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        initialRoute: LocalStorageService.instance.isLoggedIn
            ? FeedScreen.id
            : AuthScreen.id,
        onGenerateRoute: AppRouter.generateRoute,
      ),
    );
  }
}
