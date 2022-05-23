import 'package:flutter/material.dart';
import 'package:hostel_complain_management_app/data/enums.dart';
import 'package:hostel_complain_management_app/presentation/widgets/complain_button.dart';

class ComplainButtons extends StatefulWidget {
  const ComplainButtons({Key? key, required this.filterFunction})
      : super(key: key);
  final Function filterFunction;

  @override
  _ComplainButtonsState createState() => _ComplainButtonsState();
}

class _ComplainButtonsState extends State<ComplainButtons> {
  List<bool> selected = [true, false, false, false, false, false];
  List<String> buttonTitles = [
    'All',
    'Mess',
    'Maintenance',
    'Cultural',
    'Sports',
    'Miscellaneous',
  ];
  List<ComplainType> filterComplains = [
    ComplainType.none,
    ComplainType.mess,
    ComplainType.maintenance,
    ComplainType.cultural,
    ComplainType.sports,
    ComplainType.miscellaneous,
  ];

  void select(int index) {
    setState(() {
      selected[index] = true;
      for (int i = 0; i < selected.length; i++) {
        if (i != index) {
          selected[i] = false;
        }
      }
    });
    widget.filterFunction(filterComplains[index]);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.purple,
      padding: const EdgeInsets.all(8),
      height: 60,
      child: ListView.builder(
        itemBuilder: (context, index) => ComplainButton(
            title: buttonTitles[index],
            index: index,
            onSelect: select,
            selectionList: selected),
        itemCount: buttonTitles.length,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
