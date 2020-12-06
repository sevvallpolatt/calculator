import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main(){
  runApp(Calculator());
}
class Calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData.dark(),
      home: SimpleCalculator(),
    );
  }
}
class SimpleCalculator extends StatefulWidget {
  @override
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}
class _SimpleCalculatorState extends State<SimpleCalculator> {

  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "AC") {
        equation = "0";
        result = "0";
        equationFontSize = 38.0;
        resultFontSize = 48.0;
      }

      else if (buttonText == "C") {
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      }

      else if (buttonText == "=") {
        equationFontSize = 38.0;
        resultFontSize = 48.0;

        expression = equation;
        expression = expression.replaceAll('x', '*');
        expression = expression.replaceAll('÷', '/');

        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = "Error";
        }
      }
      else {
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget buildButton(String buttonText, Color buttonColor, double buttonWidth) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.1 * buttonWidth,
      color: buttonColor,
      child: FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
              side: BorderSide(
                color: Colors.black,
                width: 2,
                style: BorderStyle.solid,
              )
          ),
          padding: EdgeInsets.all(16.0),
          onPressed: () => buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.normal,
              color: Colors.white,
            ),
          )
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Simple Calculator')),
        body: Column(
          children: <Widget>[


            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: Text(
                equation, style: TextStyle(fontSize: equationFontSize, fontFamily: 'BigShouldersStencilText'),),
            ),


            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
              child: Text(result,
                style: TextStyle(fontSize: resultFontSize,fontFamily: 'BigShouldersStencilText'),),
            ),


            Expanded(
              child: Divider(),
            ),

            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width*0.5,
              child: Table(
                  children: [
                  TableRow(
                  children: [
                    buildButton("AC", Colors.white54,1),
                    ],
                  ),
                  ],
              ),
            ),
                  Container(
                    width: MediaQuery.of(context).size.width*0.25,
                    child: Table(
                      children: [
                        TableRow(
                          children: [
                            buildButton("C", Colors.orangeAccent,1),

                          ],
                        ),
                      ],
                    ),

                  ),
                  Container(
                    width: MediaQuery.of(context).size.width*0.25,
                    child: Table(
                      children: [
                        TableRow(
                          children: [
                            buildButton("+", Colors.orangeAccent,1),

                          ],
                        ),
                      ],
                    ),

                  )
    ],),


            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Table(
                    children: [
                      TableRow(
                          children: [
                            buildButton("7", Colors.white24, 1.10),
                            buildButton("8", Colors.white24, 1.10),
                            buildButton("9", Colors.white24, 1.10),
                            buildButton("x", Colors.orangeAccent, 1),
                          ]
                      ),

                      TableRow(
                          children: [
                            buildButton("4", Colors.white24, 1.10),
                            buildButton("5", Colors.white24, 1.10),
                            buildButton("6", Colors.white24, 1.10),
                            buildButton("÷", Colors.orangeAccent, 1),
                          ]
                      ),

                      TableRow(
                          children: [
                            buildButton("1", Colors.white24, 1.10),
                            buildButton("2", Colors.white24, 1.10),
                            buildButton("3", Colors.white24, 1.10),
                            buildButton("-", Colors.orangeAccent, 1),
                          ]
                      ),

                      TableRow(
                          children: [
                            buildButton(".", Colors.white24, 1.10),
                            buildButton("0", Colors.white24, 1.10),
                            buildButton("00", Colors.white24, 1.10),
                            buildButton("=", Colors.orangeAccent, 1),
                          ]
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        )
    );
  }
}