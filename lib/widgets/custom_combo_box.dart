import 'package:flutter/material.dart';

class CustomComboBox<T> extends StatefulWidget {
  final Function onChange;
  final List<T> values;

  const CustomComboBox({this.values, this.onChange});

  @override
  _CustomComboBoxState<T> createState() => _CustomComboBoxState<T>();
}

class _CustomComboBoxState<T> extends State<CustomComboBox> {
  List<DropdownMenuItem<T>> dropdownMenuItems = new List();
  T selectedItem;

  _createMenuItems() {
    for (T value in widget.values) {
      dropdownMenuItems.add(
          new DropdownMenuItem(value: value, child: Text(value.toString())));
    }
  }

  _onChanged(T _selectedItem) {
    setState(() {
      selectedItem = _selectedItem;
    });
    widget.onChange(selectedItem);
  }

  @override
  void initState() {
    _createMenuItems();
    selectedItem = dropdownMenuItems[0].value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
        color: Colors.white,
        child: new Center(
            child: new DropdownButton(
          value: selectedItem,
          items: dropdownMenuItems,
          onChanged: _onChanged,
        )));
  }
}
