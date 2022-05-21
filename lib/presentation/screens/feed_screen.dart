import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hostel_complain_management_app/business_logic/feed/feed_bloc.dart';
import 'package:hostel_complain_management_app/business_logic/feed/feed_event.dart';
import 'package:hostel_complain_management_app/business_logic/feed/feed_state.dart';
import 'package:hostel_complain_management_app/data/enums.dart';
import 'package:hostel_complain_management_app/data/models/complain.dart';
import 'package:hostel_complain_management_app/presentation/widgets/app_drawer.dart';
import 'package:hostel_complain_management_app/presentation/widgets/complain_tile.dart';

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
      body: BlocBuilder<FeedBloc, FeedState>(builder: (context, state) {
        if (state is FeedSuccessState) {
          List<Complain> complains = state.complains.reversed.toList();
          return state.complains.isNotEmpty
              ? ListView.builder(
                  itemBuilder: (context, index) =>
                      ComplainTile(complain: complains[index]),
                  itemCount: state.complains.length,
                )
              : const Center(
                  child: Text('No complains yet'),
                );
        } else if (state is FeedErrorState) {
          return Center(
            child: Text(state.message),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      }),
      drawer: const AppDrawer(),
    );
  }

  @override
  void initState() {
    super.initState();
    context
        .read<FeedBloc>()
        .add(const FeedFetchingEvent(type: ComplainType.none));
  }
}
