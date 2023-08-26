// ignore_for_file: public_member_api_docs, sort_constructors_first
class Question {
  String title;
  String type;
  String answer = '';
  List<String>? options;
  Question({
    required this.title,
    required this.type,
    required this.answer,
    this.options,
  });

  Question copyWith({
    String? title,
    String? type,
    String? answer,
    List<String>? options,
  }) {
    return Question(
      title: title ?? this.title,
      type: type ?? this.type,
      answer: answer ?? this.answer,
      options: options ?? this.options,
    );
  }

  @override
  String toString() =>
      'Question(title: $title, type: $type, answer: $answer , options: $options)\n';
}

// data is a list of questions of type textfield
var data = List<Question>.generate(
  5,
  (i) => Question(
    title: 'Question ${i + 1}',
    type: 'textfield',
    answer: '',
  ),
);

// data2 is a list of questions of type dropdown
var data2 = List<Question>.generate(
  5,
  (i) => Question(
      title: 'Question ${i + 5 + 1}',
      type: 'dropdown',
      answer: '',
      options: List<String>.generate(
        5,
        (i) => 'Option ${i + 1}',
      )),
);

// finalData is consists of both textfield & dropdown types
final finalData = List<Question>.from(data)..addAll(data2);
