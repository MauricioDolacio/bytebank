import 'package:bytebank/screens/transferencia/lista.dart';
import 'package:flutter/material.dart';

void main() =>
    runApp(BytebankApp()); //Colocar dessa forma faz o Hot Reload funcionar

//Aplicativo
class BytebankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.deepPurple[500],
          secondary: Colors.deepPurple[500],
        ),
      ),
      home: ListaTransferencias(),
    );
  }
}
