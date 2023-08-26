import 'package:flutter/material.dart';
import 'package:textcontroller_test/colored_logger.dart';
import 'package:textcontroller_test/model.dart';
import 'package:textcontroller_test/my_dropdown.dart';
import 'package:textcontroller_test/my_textfield.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const MyHomePage(),
    ),
  );
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Flutter Demo Home Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 20);
                },
                itemCount: finalData.length,
                itemBuilder: (context, index) {
                  return switch (finalData[index].type) {
                    "textfield" => MyTextField(
                        // this is the initial value of the textfield
                        initialData: finalData[index].answer,
                        // this is another callback function that is called when the user submits the textfield
                        // this function is called from the child widget
                        onSubmitted: (value) {
                          finalData[index] = finalData[index].copyWith(
                            answer: value,
                          );
                        },
                        // this is the text that is displayed above the textfield
                      ),
                    "dropdown" => MyDropDown<String>(
                        items: finalData[index].options!,
                        //this is a callback function that returns the value to be displayed in the dropdown
                        //suppose you have a list of objects and you want to display a particular property of that object
                        //then you can pass a callback function that returns that property
                        //for example: if you have a list of objects of type Person and you want to display the name of the person
                        //then this callback should look like this: (person) => person.name
                        displayValue: (value) => value,
                        onChanged: (value) {
                          finalData[index] =
                              finalData[index].copyWith(answer: value);
                        },
                      ),
                    //default case
                    _ => const Text('hi'),
                  };
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //showing the data filled by the user
          ColoredLogger.Yellow.log(finalData.toString());
        },
        child: const Icon(Icons.remove_red_eye_outlined),
      ),
    );
  }
}
