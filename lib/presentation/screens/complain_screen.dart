import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hostel_complain_management_app/business_logic/complains/complains_bloc.dart';
import 'package:hostel_complain_management_app/business_logic/complains/complains_event.dart';
import 'package:hostel_complain_management_app/business_logic/complains/complains_state.dart';
import 'package:hostel_complain_management_app/presentation/widgets/complain_tile.dart';

import '../widgets/app_drawer.dart';

class ComplainScreen extends StatefulWidget {
  const ComplainScreen({Key? key}) : super(key: key);
  static const String id = 'complain';

  @override
  _ComplainScreenState createState() => _ComplainScreenState();
}

class _ComplainScreenState extends State<ComplainScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ComplainsBloc>().add(const ComplainsFetchingEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complains'),
      ),
      body: BlocBuilder<ComplainsBloc, ComplainsState>(
        builder: (context, state) {
          if (state is ComplainsSuccessState) {
            final complains = state.complains;
            if (complains.isEmpty) {
              return const Center(child: Text('You have no complains'));
            }
            return ListView.builder(
              itemBuilder: (context, index) =>
                  ComplainTile(complain: complains[index]),
              itemCount: complains.length,
            );
          } else if (state is ComplainsFailureState) {
            return Center(child: Text(state.message));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      drawer: AppDrawer(),
    );
  }
}
