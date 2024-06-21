import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Innovative Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Innovative Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String output = '0';
  String _currentValue = '0';
  String _operator = '';
  bool _shouldClear = false;

  void _handlePress(String input) {
    setState(() {
      if (input == 'C') {
        output = '0';
        _currentValue = '0';
        _operator = '';
        _shouldClear = false;
      } else if (input == '+' || input == '-' || input == '*' || input == '/' || input == '^' || input == 'log' || input == 'sin' || input == 'cos' || input == 'tan') {
        if (_operator.isEmpty) {
          _currentValue = output;
        } else {
          _calculate();
        }
        _operator = input;
        _shouldClear = true;
      } else if (input == '=') {
        _calculate();
        _operator = '';
      } else if (input == '√') {
        double number = double.parse(output);
        output = sqrt(number).toString();
        _currentValue = output;
      } else if (input == '!') {
        int number = int.parse(output);
        output = _factorial(number).toString();
        _currentValue = output;
      } else {
        if (_shouldClear) {
          output = input;
          _shouldClear = false;
        } else {
          if (output == '0' && input != '.') {
            output = input;
          } else {
            output += input;
          }
        }
      }
    });
  }

  int _factorial(int n) {
    if (n <= 1) return 1;
    return n * _factorial(n - 1);
  }

  void _calculate() {
    double firstNumber = double.parse(_currentValue);
    double secondNumber = double.parse(output);
    double result = 0;

    switch (_operator) {
      case '+':
        result = firstNumber + secondNumber;
        break;
      case '-':
        result = firstNumber - secondNumber;
        break;
      case '*':
        result = firstNumber * secondNumber;
        break;
      case '/':
        result = secondNumber != 0 ? firstNumber / secondNumber : double.infinity;
        break;
      case '^':
        result = pow(firstNumber, secondNumber).toDouble();
        break;
      case 'log':
        result = log(secondNumber) / log(firstNumber);
        break;
      case 'sin':
        result = sin(secondNumber);
        break;
      case 'cos':
        result = cos(secondNumber);
        break;
      case 'tan':
        result = tan(secondNumber);
        break;
    }

    output = result.toString();
    _currentValue = output;
    _shouldClear = true;
  }

  Widget _buildButton(String text, {Color color = Colors.black}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.indigo[50],
        foregroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        padding: EdgeInsets.all(16.0),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      onPressed: () => _handlePress(text),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Text(
                output,
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                textAlign: TextAlign.right,
              ),
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 4,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                children: <Widget>[
                  _buildButton("7"),
                  _buildButton("8"),
                  _buildButton("9"),
                  _buildButton("/", color: Colors.indigo),
                  _buildButton("4"),
                  _buildButton("5"),
                  _buildButton("6"),
                  _buildButton("*", color: Colors.indigo),
                  _buildButton("1"),
                  _buildButton("2"),
                  _buildButton("3"),
                  _buildButton("-", color: Colors.indigo),
                  _buildButton("0"),
                  _buildButton(".", color: Colors.indigo),
                  _buildButton("=", color: Colors.green),
                  _buildButton("+", color: Colors.indigo),
                  _buildButton("^", color: Colors.indigo),
                  _buildButton("√", color: Colors.indigo),
                  _buildButton("!", color: Colors.indigo),
                  _buildButton("C", color: Colors.red),
                  _buildButton("log", color: Colors.indigo),
                  _buildButton("sin", color: Colors.indigo),
                  _buildButton("cos", color: Colors.indigo),
                  _buildButton("tan", color: Colors.indigo),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
