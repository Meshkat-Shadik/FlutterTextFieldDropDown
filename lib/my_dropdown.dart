import 'package:flutter/material.dart';

/// [MyDropDown] is a custom dropdown widget that takes a list of items and displays them in a dropdown
/// It is Generic so you can pass a list of any type

class MyDropDown<T> extends StatefulWidget {
  /// [items] is a list of items to be displayed in the dropdown
  /// It is Generic so you can pass a list of any type
  /// Like List<String> or List<int> or List<Person>
  final List<T> items;

  /// [onChanged] is a callback function that is called when the user selects an item from the dropdown
  /// It is also Generic with the same type as the items
  final void Function(T?)? onChanged;

  /// [displayValue] is a callback function that returns the value to be displayed in the dropdown
  /// Suppose you have a list of objects and you want to display a particular property of that object
  /// then you can pass a callback function that returns that property
  /// for example: if you have a list of objects of type Person and you want to display the name of the person
  /// then this callback should look like this: (person) => person.name
  final String Function(T) displayValue;

  /// [isDense] is a bool that determines whether the dropdown should be dense or not
  /// dense means that the dropdown will be smaller in height i.e. it will take less space vertically
  final bool? isDense;

  const MyDropDown({
    Key? key,
    required this.items,
    this.onChanged,
    required this.displayValue,
    this.isDense,
  }) : super(key: key);

  @override
  State<MyDropDown<T>> createState() => _MyDropDownState<T>();
}

class _MyDropDownState<T> extends State<MyDropDown<T>> {
  /// [selectedValue] is the value that is currently selected in the dropdown
  /// It is Generic with the same type as the items
  T? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
      ),
      child: DropdownButton<T>(
        isDense: widget.isDense ?? false,
        value: selectedValue,
        onChanged: (value) {
          // here we just set the selectedValue to the value that the user selected
          setState(() {
            selectedValue = value;
          });
          // and then we call the onChanged callback function that was passed to this widget
          // it's main purpose is to call anything from the parent widget
          widget.onChanged?.call(value);
        },
        items: widget.items
            .map(
              (value) => DropdownMenuItem(
                value: value,
                child: Text(
                  // here we call the displayValue callback function that was passed to this widget
                  // it's main purpose is to return the value to be displayed in the dropdown
                  widget.displayValue(value),
                ),
              ),
            )
            .toList(),
        isExpanded: true,
        underline: const SizedBox.shrink(),
      ),
    );
  }
}
