import 'package:flutter/material.dart';
import 'package:hostel_complain_management_app/data/constants.dart';
import 'package:hostel_complain_management_app/data/data_providers/local_storage_service.dart';
import 'package:hostel_complain_management_app/data/enums.dart';
import 'package:hostel_complain_management_app/presentation/widgets/complain_button.dart';

class SecyComplainFilterButtons extends StatefulWidget {
  const SecyComplainFilterButtons({Key? key, required this.filterFunction})
      : super(key: key);
  final Function filterFunction;

  @override
  _SecyComplainFilterButtonsState createState() =>
      _SecyComplainFilterButtonsState();
}

class _SecyComplainFilterButtonsState extends State<SecyComplainFilterButtons> {
  List<bool> selected = [true, false];
  List<String> buttonTitles = [
    LocalStorageService.instance.secretaryDepartment,
    'All',
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
    if (buttonTitles[index] != 'All') {
      widget.filterFunction(COMPLAIN_TYPE[buttonTitles[index].toLowerCase()]!);
    } else {
      widget.filterFunction(ComplainType.none);
    }
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
          selectionList: selected,
        ),
        itemCount: buttonTitles.length,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
