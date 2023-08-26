import 'package:flutter/material.dart';

class MyTextField<T> extends StatefulWidget {
  const MyTextField({
    super.key,
    required this.initialData,
    required this.onSubmitted,
    this.hintText = 'Enter your answer',
  });

  /// [question] is the question object that contains the title, type, answer and options
  final T initialData;

  /// [onSubmitted] is a callback function that is called when the user submits the textfield
  /// It is Generic with the same type as the question
  final void Function(String)? onSubmitted;

  /// [hintText] is the text that is displayed when the textfield is empty
  final String hintText;

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  late final TextEditingController textEditingController;

  @override
  void initState() {
    super.initState();

    /// [textEditingController] is a controller for the textfield
    /// it is used to set the initial value of the textfield
    textEditingController = TextEditingController(text: widget.initialData);
  }

  @override
  void dispose() {
    /// disposing the controller when the widget is disposed
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: widget.hintText,
      ),
      controller: textEditingController,
      onSubmitted: (value) {
        // here we call the onSubmitted callback function that was passed to this widget
        // it's main purpose is to call this from the parent widget
        // so that we can update the data in the parent widget
        widget.onSubmitted?.call(value);
      },
    );
  }
}
