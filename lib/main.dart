import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Testcal',
      theme: ThemeData(
        brightness: Brightness.dark,
        //primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'My Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _consoleText = '0';
  String output = '0';
  double num1 = 0.0;
  double num2 = 0.0;
  String operand = "";

  buttonPressed(String buttonText) {                                   //logical part
    print(buttonText);

    if (buttonText == 'CLEAR') {
      _consoleText = '0';
      output = '0';
      num1 = 0.0;
      num2 = 0.0;
      operand = "";
    } else if (buttonText == '+' ||
        buttonText == '-' ||
        buttonText == '*' ||
        buttonText == '/') {
      num1 = double.parse(_consoleText);
      operand = buttonText;
      _consoleText = '0';
    } else if (buttonText == '.') {
      if (_consoleText.contains('.')) {
        print('already containg decimal');
        return;
      } else {
        _consoleText = _consoleText + buttonText;
      }
    } else if (buttonText == '=') {
      num2 = double.parse(_consoleText);
      if (operand == '+') _consoleText = (num1 + num2).toString();
      if (operand == '-') _consoleText = (num1 - num2).toString();
      if (operand == '*') _consoleText = (num1 * num2).toString();
      if (operand == '/') _consoleText = (num1 / num2).toString();

      num1 = 0.0;
      num2 = 0.0;
      operand = "";
    } else {
      _consoleText = _consoleText + buttonText;
    }

    print(_consoleText);

    setState(() {
      output = double.parse(_consoleText).toStringAsFixed(4);
    });
  }

  Widget buildButton(String buttonText,Color buttonColor) {                               //portion to show the inputs
    return Expanded(
      child: MaterialButton(
        color: buttonColor,
        padding: EdgeInsets.all(20),
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          buttonPressed(buttonText);
        },
       // color: Colors.deepOrangeAccent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(                                             //the whole container part
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: Drawer(                                            //app drawer part
        child: ListView(
          children: <Widget>[
            DrawerHeader(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: <Color>[
                  Colors.deepOrange,
                  Colors.deepOrangeAccent
                ])),
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Material(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          elevation: 10,
                          child: Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Image.asset('images/download.png',
                                width: 80, height: 80),
                          )),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Calculator',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      )
                    ],
                  ),
                )),
            ListTile(
              onTap: () {},
              title: Text('About The Calculator'),
            ),
          ],
        ),
      ),
      body: Container(                                                    //main content of the app
       // padding: EdgeInsets.all(8.0),
        child: Column(children: <Widget>[
          Container(
            alignment: Alignment.bottomRight,
            child: Text(output,
                style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: Divider(),
          ),
          Column(
            children: <Widget>[
              Row(
                children: [
                  buildButton('1',Colors.brown),
                  buildButton('2',Colors.amber),
                  buildButton('3',Colors.brown),
                  buildButton('+',Colors.blue)
                ],
              ),
              Row(
                children: [
                  buildButton('4',Colors.brown),
                  buildButton('5',Colors.amber),
                  buildButton('6',Colors.deepOrange),
                  buildButton('-',Colors.blueGrey)
                ],
              ),
              Row(
                children: [
                  buildButton('7',Colors.greenAccent),
                  buildButton('8',Colors.brown),
                  buildButton('9',Colors.black12),
                  buildButton('*',Colors.blueGrey)
                ],
              ),
              Row(
                children: [
                  buildButton('.',Colors.greenAccent),
                  buildButton('0',Colors.white70),
                  buildButton('=',Colors.brown),
                  buildButton('/',Colors.greenAccent)
                ],
              ),
              Row(
                children: [buildButton('CLEAR',Colors.amber)],
              )
            ],
          ),
        ]),
      ),
    );
  }
}
