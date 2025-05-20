import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculatorscreen extends StatefulWidget {
  const Calculatorscreen({super.key});

  @override
  State<Calculatorscreen> createState() => _CalculatorscreenState();
}

class _CalculatorscreenState extends State<Calculatorscreen> {
  String input = '';
  String output = '0';
  void buttonpressed(String value) {
    setState(() {
      if (value == 'C') {
        input = '';
        output = '0';
      } else if (value == 'DEL') {
        input = input.isNotEmpty ? input.substring(0, input.length - 1) : '';
      } else if (value == '=') {
        try {
          output = evaluate(input);
        } catch (e) {
          output = "Error";
        }
      } else {
        input = input + value;
      }
    });
  }

  String evaluate(String expression) {
    try {
      return _calculate(expression).toString();
    } catch (e) {
      return "error";
    }
  }

  double _calculate(String expression) {
    expression = expression.replaceAll("x", "*").replaceAll("÷", "/");
    Parser p = Parser();
    Expression exp = p.parse(expression);
    ContextModel cm = ContextModel();
    return exp.evaluate(EvaluationType.REAL, cm);
  }

  Widget calculatorbutton(String text, {Color? bgcolor, Color? fgcolor}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: ElevatedButton(
          onPressed: () {
            buttonpressed(text);
          },
          child: Text(
            text,
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(10),
            backgroundColor: bgcolor ?? Colors.white,
            foregroundColor: fgcolor ?? Colors.black,
            shape: CircleBorder(side: BorderSide(color: Colors.black)),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    input,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    output,
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: [
              calculatorbutton('C'),
              calculatorbutton('%'),
              calculatorbutton("DEL"),
              calculatorbutton('/'),
            ],
          ),
          Row(
            children: [
              calculatorbutton('7'),
              calculatorbutton('8'),
              calculatorbutton('9'),
              calculatorbutton('X'),
            ],
          ),
          Row(
            children: [
              calculatorbutton('4'),
              calculatorbutton('5'),
              calculatorbutton('6'),
              calculatorbutton('-'),
            ],
          ),
          Row(
            children: [
              calculatorbutton('1'),
              calculatorbutton('2'),
              calculatorbutton('3'),
              calculatorbutton('+'),
            ],
          ),
          Row(
            children: [
              calculatorbutton('00'),
              calculatorbutton('0'),
              calculatorbutton('.'),
              calculatorbutton('='),
            ],
          ),
        ],
      ),
    );
  }
}
