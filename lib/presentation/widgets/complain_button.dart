import 'package:flutter/material.dart';

class ComplainButton extends StatefulWidget {
  const ComplainButton({
    Key? key,
    required this.title,
    required this.index,
    required this.onSelect,
    required this.selectionList,
  }) : super(key: key);
  final String title;
  final int index;
  final Function onSelect;
  final List<bool> selectionList;

  @override
  _ComplainButtonState createState() => _ComplainButtonState();
}

class _ComplainButtonState extends State<ComplainButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 8),
      child: InkWell(
        onTap: () {
          widget.onSelect(widget.index);
        },
        child: Chip(
          label: Text(widget.title),
          padding: const EdgeInsets.all(4),
          backgroundColor:
              widget.selectionList[widget.index] ? Colors.white : Colors.grey,
          side: const BorderSide(color: Colors.purpleAccent),
        ),
      ),
    );
  }
}
