import 'package:flutter/material.dart';
import 'buttons.dart';
//flutter library to parse the text and calculate the result
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userInput = '';
  String answer = '';

  final List<String> buttons = [
    'C',
    'DEL',
    '%',
    '/',
    '7',
    '8',
    '9',
    'x',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    '0',
    '.',
    '( )',
    '=',
  ];

  bool isOperator(String x) {
    return ['+', '-', 'x', '/', '%', '='].contains(x);
  }

  void clearAll() {
    setState(() {
      userInput = '';
      answer = '';
    });
  }

  void deleteLast() {
    if (userInput.isNotEmpty) {
      setState(() {
        userInput = userInput.substring(0, userInput.length - 1);
      });
    }
  }

  void appendButton(String value) {
  setState(() {
    if (value == '( )') {
      int openBracketCount = userInput.split('(').length - 1;
      int closeBracketCount = userInput.split(')').length - 1;
      if (openBracketCount > closeBracketCount) {
        userInput += ')';
      } else {
        userInput += '(';
      }
    } else {
      userInput += value;
    }
  });
}

  void calculate() {
    String finalQuestion = userInput;
    finalQuestion = finalQuestion.replaceAll('x', '*');

    //parser is from math expression library
    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    double result = exp.evaluate(EvaluationType.REAL, cm);
    answer = result.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    alignment: Alignment.centerRight,
                    child: Text(userInput,
                        style: const TextStyle(
                            fontSize: 40, color: Colors.black54)),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    alignment: Alignment.centerRight,
                    child: Text(answer, style: const TextStyle(fontSize: 40)),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  color: Colors.white,
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                    ),
                    itemCount: buttons.length,
                    itemBuilder: (BuildContext context, int index) {
                      String buttonText = buttons[index];
                      return MyButton(
                        buttonTapped: () {
                          if (buttonText == 'C') {
                            clearAll();
                          } else if (buttonText == 'DEL') {
                            deleteLast();
                          } else if (buttonText == '=') {
                            setState(() {
                              calculate();
                            });
                          } else {
                            appendButton(buttonText);
                          }
                        },
                        text: buttonText,
                        color: isOperator(buttonText)
                            ? Colors.grey[800]
                            : Colors.grey[100],
                        textColor: isOperator(buttonText)
                            ? Colors.white
                            : Colors.black54,
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
