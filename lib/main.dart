import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  dynamic displaytxt = 20;

  Widget calcbutton(String btntxt, Color btncolor, Color txtcolor) {
    return Container(
      child: RaisedButton(
        onPressed: () {
          calculation(btntxt);
        },
        child: Text(
          '$btntxt',
          style: TextStyle(
            fontSize: 35,
            color: txtcolor,
          ),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        color: btncolor,
        padding: EdgeInsets.all(20),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text('Calculator'),
        backgroundColor: Colors.grey[850],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      '$text',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 100,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calcbutton('C', Colors.grey[700], Colors.white),
                calcbutton('+/-', Colors.grey[700], Colors.white),
                calcbutton('%', Colors.grey[700], Colors.white),
                calcbutton('/', Colors.orange, Colors.white),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calcbutton('7', Colors.grey, Colors.white),
                calcbutton('8', Colors.grey, Colors.white),
                calcbutton('9', Colors.grey, Colors.white),
                calcbutton('x', Colors.orange, Colors.white),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calcbutton('4', Colors.grey, Colors.white),
                calcbutton('5', Colors.grey, Colors.white),
                calcbutton('6', Colors.grey, Colors.white),
                calcbutton('-', Colors.orange, Colors.white),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calcbutton('1', Colors.grey, Colors.white),
                calcbutton('2', Colors.grey, Colors.white),
                calcbutton('3', Colors.grey, Colors.white),
                calcbutton('+', Colors.orange, Colors.white),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  padding: EdgeInsets.fromLTRB(34, 20, 128, 20),
                  onPressed: () {
                    calculation('0');
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)),
                  child: Text(
                    '0',
                    style: TextStyle(fontSize: 35, color: Colors.white),
                  ),
                  color: Colors.grey,
                ),
                calcbutton('.', Colors.grey, Colors.white),
                calcbutton('=', Colors.orange, Colors.white),
              ],
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  dynamic text = '0';
  double num1 = 0;
  double num2 = 0;

  dynamic result = '';
  dynamic finalResult = '';
  dynamic operation = '';
  dynamic prOper = '';
  void calculation(btnText) {
    if (btnText == 'C') {
      text = '0';
      num1 = 0;
      num2 = 0;
      result = '';
      finalResult = '0';
      operation = '';
      prOper = '';
    } else if (operation == '=' && btnText == '=') {
      if (prOper == '+') {
        finalResult = add();
      } else if (prOper == '-') {
        finalResult = sub();
      } else if (prOper == 'x') {
        finalResult = mul();
      } else if (prOper == '/') {
        finalResult = div();
      }
    } else if (btnText == '+' ||
        btnText == '-' ||
        btnText == 'x' ||
        btnText == '/' ||
        btnText == '=') {
      if (num1 == 0) {
        num1 = double.parse(result);
      } else {
        num2 = double.parse(result);
      }

      if (operation == '+') {
        finalResult = add();
      } else if (operation == '-') {
        finalResult = sub();
      } else if (operation == 'x') {
        finalResult = mul();
      } else if (operation == '/') {
        finalResult = div();
      }
      prOper = operation;
      operation = btnText;
      result = '';
    } else if (btnText == '%') {
      result = num1 / 100;
      finalResult = decCheck(result);
    } else if (btnText == '.') {
      if (!result.toString().contains('.')) {
        result = result.toString() + '.';
      }
      finalResult = result;
    } else if (btnText == '+/-') {
      result.toString().startsWith('-')
          ? result = result.toString().substring(1)
          : result = '-' + result.toString();
      finalResult = result;
    } else {
      result = result + btnText;
      finalResult = result;
    }

    setState(() {
      text = finalResult;
    });
  }

  String decCheck(dynamic result) {
    if (result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');
      if (!(int.parse(splitDecimal[1]) > 0))
        return result = splitDecimal[0].toString();
    }
    return result;
  }

  String add() {
    result = (num1 + num2).toString();
    num1 = double.parse(result);
    return decCheck(result);
  }

  String sub() {
    result = (num1 - num2).toString();
    num1 = double.parse(result);
    return decCheck(result);
  }

  String mul() {
    result = (num1 * num2).toString();
    num1 = double.parse(result);
    return decCheck(result);
  }

  String div() {
    result = (num1 / num2).toString();
    num1 = double.parse(result);
    return decCheck(result);
  }
}
