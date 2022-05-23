import 'package:flutter/material.dart';
import 'package:hostel_complain_management_app/data/models/complain.dart';

class DetailsDialog extends StatelessWidget {
  const DetailsDialog({Key? key, required this.complain}) : super(key: key);
  final Complain complain;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      backgroundColor: Colors.purple,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            Text(
              complain.title,
              softWrap: true,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 25,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              complain.body,
              softWrap: true,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 17,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              complain.type.name,
              softWrap: true,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
            Text(
              '${complain.complainant} , ${complain.hostelName}',
              softWrap: true,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
            Text(
              complain.date,
              softWrap: true,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
