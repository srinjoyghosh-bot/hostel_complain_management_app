import 'package:flutter/material.dart';
import 'package:hostel_complain_management_app/data/enums.dart';
import 'package:hostel_complain_management_app/data/models/complain.dart';

class ComplainTile extends StatefulWidget {
  const ComplainTile({Key? key, required this.complain}) : super(key: key);
  final Complain complain;

  @override
  _ComplainTileState createState() => _ComplainTileState();
}

class _ComplainTileState extends State<ComplainTile> {
  Widget getIcon(ComplainType type) {
    switch (type) {
      case ComplainType.miscellaneous:
        return const Icon(
          Icons.miscellaneous_services,
        );
      case ComplainType.mess:
        return const Icon(Icons.food_bank);
      case ComplainType.maintenance:
        return const Icon(Icons.work);
      case ComplainType.cultural:
        return const Icon(Icons.festival_rounded);
      case ComplainType.sports:
        return const Icon(Icons.sports_cricket);

      default:
        return const Icon(Icons.miscellaneous_services);
    }
  }

  @override
  Widget build(BuildContext context) {
    Complain complain = widget.complain;
    return Container(
      margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
        border: Border.all(color: Colors.purple),
      ),
      child: ListTile(
        title: Text(complain.title),
        subtitle: Text('by ${complain.complainant} on ${complain.date}'),
        leading: CircleAvatar(
          backgroundColor: Colors.deepPurple,
          child: Center(child: getIcon(complain.type)),
        ),
      ),
    );
  }
}
