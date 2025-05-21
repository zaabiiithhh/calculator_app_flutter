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
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
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
                        color: const Color.fromARGB(255, 130, 131, 130),
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calculatorbutton('C'),
                SizedBox(width: 10),
                calculatorbutton('%'),
                SizedBox(width: 10),
                calculatorbutton("DEL"),
                SizedBox(width: 10),
                calculatorbutton('÷'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calculatorbutton('7'),
                SizedBox(width: 10),
                calculatorbutton('8'),
                SizedBox(width: 10),
                calculatorbutton('9'),
                SizedBox(width: 10),
                calculatorbutton('×'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calculatorbutton('4'),
                SizedBox(width: 10),
                calculatorbutton('5'),
                SizedBox(width: 10),
                calculatorbutton('6'),
                SizedBox(width: 10),
                calculatorbutton('-'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calculatorbutton('1'),
                SizedBox(width: 10),
                calculatorbutton('2'),
                SizedBox(width: 10),
                calculatorbutton('3'),
                SizedBox(width: 10),
                calculatorbutton('+'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calculatorbutton('00'),
                SizedBox(width: 10),
                calculatorbutton('0'),
                SizedBox(width: 10),
                calculatorbutton('.'),
                SizedBox(width: 10),
                calculatorbutton('='),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
