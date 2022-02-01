// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Calculadora'),
    );
  }
}

String strInput = "";
final txtEntrada = TextEditingController();
final txtResultado = TextEditingController();

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    txtEntrada.addListener(() {});
    txtResultado.addListener(() {});
  }

  Color clrNum = Color.fromRGBO(38, 52, 84, 1);
  Color clrOp = Color.fromRGBO(63, 86, 141, 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(14, 19, 31, 1),
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Color.fromRGBO(63, 86, 141, 1),
        centerTitle: true,
        titleTextStyle: TextStyle(
            fontSize: 25,
            color: Colors.white,
            fontFamily: 'RobotoMono',
            fontWeight: FontWeight.bold),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              decoration: InputDecoration.collapsed(
                hintText: "0",
                hintStyle: TextStyle(
                  fontSize: 40,
                  fontFamily: 'RobotoMono',
                  color: Colors.white,
                ),
              ),
              style: TextStyle(
                fontSize: 40,
                fontFamily: 'RobotoMono',
                color: Colors.white,
              ),
              textAlign: TextAlign.right,
              controller: txtEntrada,
              onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              decoration: InputDecoration.collapsed(
                hintText: "Resultado",
                hintStyle: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'RobotoMono',
                  color: Colors.white,
                ),
              ),
              style: TextStyle(
                fontSize: 40,
                fontFamily: 'RobotoMono',
                color: Colors.white,
              ),
              textAlign: TextAlign.right,
              controller: txtResultado,
              onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
            ),
          ),
          Expanded(
            child: OrientationBuilder(builder: (context, orientation) {
              return GridView.count(
                crossAxisCount: orientation == Orientation.portrait ? 4 : 8,
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                children: [
                  boton("9", clrNum),
                  boton("8", clrNum),
                  boton("7", clrNum),
                  boton("+", clrOp),
                  boton("6", clrNum),
                  boton("5", clrNum),
                  boton("4", clrNum),
                  boton("-", clrOp),
                  boton("3", clrNum),
                  boton("2", clrNum),
                  boton("1", clrNum),
                  boton("*", clrOp),
                  boton(".", clrOp),
                  boton("0", clrNum),
                  boton("C", clrOp),
                  boton("/", clrOp),
                ],
              );
            }),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 78,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(18, 0, 18, 8),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(clrOp),
                ),
                onPressed: () {
                  Parser p = Parser();
                  ContextModel cm = ContextModel();
                  Expression exp = p.parse(txtEntrada.text);
                  setState(() {
                    txtResultado.text =
                        exp.evaluate(EvaluationType.REAL, cm).toString();

                    if (!txtEntrada.text.endsWith(")")) {
                      txtEntrada.text = "(" + txtEntrada.text + ")";
                    }
                  });
                },
                child: Text(
                  '=',
                  style: TextStyle(
                      fontSize: 28.0,
                      color: Colors.white,
                      fontFamily: 'RobotoMono'),
                ),
              ),
            ),
          ),
          SizedBox(height: 20.0),
        ],
      ),
    );
  }

  Widget boton(btntxt, Color btnColor) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style:
            ButtonStyle(backgroundColor: MaterialStateProperty.all(btnColor)),
        onPressed: () {
          setState(() {
            switch (btntxt) {
              case 'C':
                txtEntrada.text = "";
                txtResultado.text = "";
                break;
              case '.':
                if (!txtEntrada.text.endsWith('.')) {
                  txtEntrada.text = txtEntrada.text + btntxt;
                }
                break;
              case '+':
                if (!txtEntrada.text.endsWith('+')) {
                  txtEntrada.text = txtEntrada.text + btntxt;
                }
                break;
              case '-':
                if (!txtEntrada.text.endsWith('-')) {
                  txtEntrada.text = txtEntrada.text + btntxt;
                }
                break;
              case '*':
                if (!txtEntrada.text.endsWith('*')) {
                  txtEntrada.text = txtEntrada.text + btntxt;
                }
                break;
              case '/':
                if (!txtEntrada.text.endsWith('/')) {
                  txtEntrada.text = txtEntrada.text + btntxt;
                }
                break;
              default:
                txtEntrada.text = txtEntrada.text + btntxt;
            }
          });
        },
        child: Text(
          btntxt,
          style: TextStyle(
              fontSize: 28.0, color: Colors.white, fontFamily: 'RobotoMono'),
        ),
      ),
    );
  }
}
