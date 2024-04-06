import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz APP',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white60,
      ),
      home: QuizPage(),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int _questionIndex = 0;
  int _score = 0;
  int _totalAttempted = 0;
  final List<Map<String, dynamic>> _questions = [
    {
      'questionText': 'What is the output of print(2 + 3)?',
      'answers': [
        {'text': '4', 'correct': false},
        {'text': '5', 'correct': true},
        {'text': '6', 'correct': false},
        {'text': '7', 'correct': false},
      ],
      'correctAnswerIndex': 1,
    },
    {
      'questionText': 'Which of the following is not a data type in Python?',
      'answers': [
        {'text': 'int', 'correct': false},
        {'text': 'float', 'correct': false},
        {'text': 'string', 'correct': false},
        {'text': 'tuple', 'correct': true},
      ],
      'correctAnswerIndex': 3,
    },
    {
      'questionText': 'What is the result of 2 * 3?',
      'answers': [
        {'text': '4', 'correct': false},
        {'text': '5', 'correct': false},
        {'text': '6', 'correct': true},
        {'text': '7', 'correct': false},
      ],
      'correctAnswerIndex': 2,
    },
    {
      'questionText': 'Which statement is used to declare a variable in Python?',
      'answers': [
        {'text': 'var', 'correct': false},
        {'text': 'int', 'correct': false},
        {'text': 'variable', 'correct': false},
        {'text': 'None of the above', 'correct': true},
      ],
      'correctAnswerIndex': 3,
    },
    {
      'questionText': 'What is the output of "Hello" + "World"?',
      'answers': [
        {'text': 'HelloWorld', 'correct': true},
        {'text': 'Hello World', 'correct': false},
        {'text': 'HelloWorld!', 'correct': false},
        {'text': 'Hello World!', 'correct': false},
      ],
      'correctAnswerIndex': 0,
    },
    {
      'questionText': 'What is the result of 10 % 3?',
      'answers': [
        {'text': '1', 'correct': true},
        {'text': '2', 'correct': false},
        {'text': '3', 'correct': false},
        {'text': '4', 'correct': false},
      ],
      'correctAnswerIndex': 0,
    },
    {
      'questionText': 'Which statement is used to print a value in Python?',
      'answers': [
        {'text': 'output()', 'correct': false},
        {'text': 'print()', 'correct': true},
        {'text': 'display()', 'correct': false},
        {'text': 'show()', 'correct': false},
      ],
      'correctAnswerIndex': 1,
    },
    {
      'questionText': 'What is the result of 2 ** 3?',
      'answers': [
        {'text': '4', 'correct': false},
        {'text': '6', 'correct': false},
        {'text': '8', 'correct': true},
        {'text': '10', 'correct': false},
      ],
      'correctAnswerIndex': 2,
    },
    {
      'questionText': 'Which of the following is a correct comment in Python?',
      'answers': [
        {'text': '# This is a comment', 'correct': true},
        {'text': '// This is a comment', 'correct': false},
        {'text': '/* This is a comment */', 'correct': false},
        {'text': '<!-- This is a comment -->', 'correct': false},
      ],
      'correctAnswerIndex': 0,
    },
    {
      'questionText': 'What does the function len() do in Python?',
      'answers': [
        {'text': 'Return the sum of two numbers', 'correct': false},
        {'text': 'Return the largest of two numbers', 'correct': false},
        {'text': 'Return the length of a string or list', 'correct': true},
        {'text': 'Return the product of two numbers', 'correct': false},
      ],
      'correctAnswerIndex': 2,
    },
  ];

  // Add more questions here...

  List<bool> _answerSelected = [false, false, false, false];

  void _answerQuestion(bool isCorrect, int index) {
    setState(() {
      _totalAttempted++;
      if (isCorrect) {
        _score += 1;
      }
      _answerSelected = [false, false, false, false];
      _answerSelected[index] = true;
    });
  }

  void _nextQuestion() {
    setState(() {
      _questionIndex = (_questionIndex + 1) % _questions.length;
      _answerSelected = [false, false, false, false];
    });
  }

  void _previousQuestion() {
    setState(() {
      _questionIndex = (_questionIndex - 1) % _questions.length;
      _answerSelected = [false, false, false, false];
    });
  }

  void _submitQuiz() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultPage(
          totalQuestions: _questions.length,
          totalAttempted: _totalAttempted,
          score: _score,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz-Python programming'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Question ${_questionIndex + 1}: ${_questions[_questionIndex]['questionText']}',
              style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            ...List.generate(
              _questions[_questionIndex]['answers'].length,
                  (index) => ElevatedButton(
                onPressed: () {
                  _answerQuestion(
                    _questions[_questionIndex]['answers'][index]['correct'],
                    index,
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: _answerSelected[index] ? Colors.green : null,
                ),
                child: Text(
                  _questions[_questionIndex]['answers'][index]['text'],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: _previousQuestion,
                child: Text('Previous'),
              ),
              Text('Question ${_questionIndex + 1} of ${_questions.length}'),
              ElevatedButton(
                onPressed: _questionIndex == _questions.length - 1 ? _submitQuiz : _nextQuestion,
                child: Text(_questionIndex == _questions.length - 1 ? 'Submit' : 'Next'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ResultPage extends StatelessWidget {
  final int totalQuestions;
  final int totalAttempted;
  final int score;

  ResultPage({
    required this.totalQuestions,
    required this.totalAttempted,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    int unanswered = totalQuestions - totalAttempted;
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Result'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Quiz Completed',
              style: TextStyle(fontSize: 24.0),
            ),
            SizedBox(height: 20.0),
            Text(
              'Total Questions: $totalQuestions',
              style: TextStyle(fontSize: 18.0),
            ),
            Text(
              'Attempted: $totalAttempted',
              style: TextStyle(fontSize: 18.0),
            ),
            Text(
              'Unanswered: $unanswered',
              style: TextStyle(fontSize: 18.0),
            ),
            Text(
              'Score: $score',
              style: TextStyle(fontSize: 18.0),
            ),
          ],
        ),
      ),
    );
  }
}
